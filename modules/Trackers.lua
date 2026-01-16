-----------------------------
-- Watchtower: Tracker.lua --
-----------------------------

local appName, app = ...
local api = app.api
local L = app.locales

-------------
-- ON LOAD --
-------------

app.Event:Register("ADDON_LOADED", function(addOnName, containsBindings)
	if addOnName == appName then
		for i = 2, #Watchtower_Flags do
			app:CreateTracker(i)
		end
	end
end)

--------------
-- TRACKERS --
--------------

app.Tracker = {}

function app:UpdateAllTrackers()
	for i = 2, #Watchtower_Flags do
		if app.Tracker[i] then app:UpdateTracker(i) end
	end
end

function app:MoveTracker(id)
	app.Tracker[id].window:StartMoving()
end

function app:SaveTracker(id)
	app.Tracker[id].window:StopMovingOrSizing()

	local left = app.Tracker[id].window:GetLeft()
	local bottom = app.Tracker[id].window:GetBottom()
	local width, height = app.Tracker[id].window:GetSize()
	Watchtower_Flags[id].position = { left = left, bottom = bottom, width = width, height = height }
end

function app:ShowTracker(id)
	app.Tracker[id].window:ClearAllPoints()
	if Watchtower_Flags[id].position then
		app.Tracker[id].window:SetSize(Watchtower_Flags[id].position.width, Watchtower_Flags[id].position.height)
		app.Tracker[id].window:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", Watchtower_Flags[id].position.left, Watchtower_Flags[id].position.bottom)
	else
		app.Tracker[id].window:SetSize(200, 200)
		app.Tracker[id].window:SetPoint("CENTER", UIParent)
		app:SaveTracker(id)
	end

	app:UpdateTracker(id)
	app.Tracker[id].window:Show()
end

function app:ToggleTracker(id)
	if app.Tracker[id].window:IsShown() then
		app.Tracker[id].window:Hide()
	else
		app:ShowTracker(id)
	end
end

function app:CreateTracker(id)
	app.Tracker[id] = {}
	app.Tracker[id].window = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
	app.Tracker[id].window:SetPoint("CENTER")
	app.Tracker[id].window:SetSize(300, 300)
	app.Tracker[id].window:SetFrameStrata("MEDIUM")
	app.Tracker[id].window:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	app.Tracker[id].window:SetBackdropColor(0, 0, 0, 0.5)
	app.Tracker[id].window:SetBackdropBorderColor(0.25, 0.78, 0.92, 0.5)
	app.Tracker[id].window:EnableMouse(true)
	app.Tracker[id].window:SetResizable(true)
	app.Tracker[id].window:SetResizeBounds(140, 140, 2000, 2000)
	app.Tracker[id].window:SetMovable(true)
	app.Tracker[id].window:SetClampedToScreen(true)
	app.Tracker[id].window:RegisterForDrag("LeftButton")
	app.Tracker[id].window:SetClampRectInsets(10, -10, -10, 10)
	app.Tracker[id].window:SetScript("OnDragStart", function() app:MoveTracker(id) end)
	app.Tracker[id].window:SetScript("OnDragStop", function() app:SaveTracker(id) end)

	local scrollBox = CreateFrame("Frame", nil, app.Tracker[id].window, "WowScrollBoxList")
	scrollBox:SetPoint("TOPLEFT", app.Tracker[id].window, "TOPLEFT", 8, -4)
	scrollBox:SetPoint("BOTTOMRIGHT", app.Tracker[id].window, "BOTTOMRIGHT", -18, 4)
	scrollBox:EnableMouse(true)
	scrollBox:RegisterForDrag("LeftButton")
	scrollBox:SetScript("OnDragStart", function() app:MoveTracker(id) end)
	scrollBox:SetScript("OnDragStop", function() app:SaveTracker(id) end)

	local scrollBar = CreateFrame("EventFrame", nil, app.Tracker[id].window, "MinimalScrollBar")
	scrollBar:SetPoint("TOPLEFT", scrollBox, "TOPRIGHT")
	scrollBar:SetPoint("BOTTOMLEFT", scrollBox, "BOTTOMRIGHT")
	scrollBox:HookScript("OnSizeChanged", function()
		if scrollBox:HasScrollableExtent() then
			scrollBar:Show()
		else
			scrollBar:Hide()
		end
	end)

	app.Tracker[id].window.Corner = CreateFrame("Button", nil, app.Tracker[id].window)
	app.Tracker[id].window.Corner:EnableMouse("true")
	app.Tracker[id].window.Corner:SetPoint("BOTTOMRIGHT")
	app.Tracker[id].window.Corner:SetSize(16,16)
	app.Tracker[id].window.Corner:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
	app.Tracker[id].window.Corner:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
	app.Tracker[id].window.Corner:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
	app.Tracker[id].window.Corner:SetScript("OnMouseDown", function() app.Tracker[id].window:StartSizing("BOTTOMRIGHT") end)
	app.Tracker[id].window.Corner:SetScript("OnMouseUp", function() app:SaveTracker(id) end)

	app.Tracker[id].scrollView = CreateScrollBoxListTreeListView()
	ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, app.Tracker[id].scrollView)

	local function Initializer(listItem, node)
		local data = node:GetData()

		--if data.index then
			listItem.Text:SetText("|T" .. data.icon .. ":16|t" .. " " .. data.title)
			listItem.Text:SetFont("Fonts\\FRIZQT__.TTF", 20)
		--end

		listItem:EnableMouse(true)
		listItem:RegisterForDrag("LeftButton")
		listItem:SetScript("OnDragStart", function() app:MoveTracker(id) end)
		listItem:SetScript("OnDragStop", function() app:SaveTracker(id) end)
	end

	app.Tracker[id].scrollView:SetElementInitializer("Watchtower_ListItem30", Initializer)

	app:UpdateTracker(id)
	app:ShowTracker(id)
end

function app:UpdateTracker(id)
	local DataProvider = CreateTreeDataProvider()

	for k, v in ipairs(Watchtower_Flags[id].flags) do
		if type(v.lastResult) == "boolean" and v.lastResult then
			DataProvider:Insert({ id = v.id, icon = v.icon, title = v.title })
		end
	end

	app.Tracker[id].scrollView:SetDataProvider(DataProvider, true)
end
