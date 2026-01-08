-----------------------------
-- Watchtower: Tracker.lua --
-----------------------------

local appName, app = ...
local L = app.locales
local api = app.api

-------------
-- ON LOAD --
-------------

app.Event:Register("ADDON_LOADED", function(addOnName, containsBindings)
	if addOnName == appName then
		Watchtower_Settings["statusTrackerPosition"] = Watchtower_Settings["statusTrackerPosition"] or { ["height"] = 412.8004760742188, ["width"] = 232.7999114990234, ["left"] = 92.40211486816406, ["bottom"] = 205.1995391845703 }

		app:CreateStatusTracker()
		app:UpdateStatusTracker()
		app:ShowStatusTracker()
	end
end)

--------------------
-- STATUS TRACKER --
--------------------

function app:MoveStatusTracker()
	if not Watchtower_Settings["statusTrackerLocked"] then
		app.StatusTracker:StartMoving()
	end
end

function app:SaveStatusTracker()
	app.StatusTracker:StopMovingOrSizing()

	local left = app.StatusTracker:GetLeft()
	local bottom = app.StatusTracker:GetBottom()
	local width, height = app.StatusTracker:GetSize()
	Watchtower_Settings["statusTrackerPosition"] = { ["left"] = left, ["bottom"] = bottom, ["width"] = width, ["height"] = height }
end

function app:ShowStatusTracker()
	app.StatusTracker:ClearAllPoints()
	app.StatusTracker:SetSize(Watchtower_Settings["statusTrackerPosition"].width, Watchtower_Settings["statusTrackerPosition"].height)
	app.StatusTracker:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", Watchtower_Settings["statusTrackerPosition"].left, Watchtower_Settings["statusTrackerPosition"].bottom)

	app:UpdateStatusTracker()
	app.StatusTracker:Show()
end

function app:ToggleStatusTracker()
	if app.StatusTracker:IsShown() then
		app.StatusTracker:Hide()
	else
		app:ShowStatusTracker()
	end
end

function app:CreateStatusTracker()
	app.StatusTracker = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
	app.StatusTracker:SetPoint("CENTER")
	app.StatusTracker:SetSize(300, 300)
	app.StatusTracker:SetFrameStrata("MEDIUM")
	app.StatusTracker:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	app.StatusTracker:SetBackdropColor(0, 0, 0, 0.5)
	app.StatusTracker:SetBackdropBorderColor(0.25, 0.78, 0.92, 0.5)
	app.StatusTracker:EnableMouse(true)
	app.StatusTracker:SetResizable(true)
	app.StatusTracker:SetResizeBounds(140, 140, 2000, 2000)
	app.StatusTracker:SetMovable(true)
	app.StatusTracker:SetClampedToScreen(true)
	app.StatusTracker:RegisterForDrag("LeftButton")
	app.StatusTracker:SetClampRectInsets(10, -10, -10, 10)
	app.StatusTracker:SetScript("OnDragStart", function() app:MoveStatusTracker() end)
	app.StatusTracker:SetScript("OnDragStop", function() app:SaveStatusTracker() end)
	--app.StatusTracker:Hide()

	local scrollBox = CreateFrame("Frame", nil, app.StatusTracker, "WowScrollBoxList")
	scrollBox:SetPoint("TOPLEFT", app.StatusTracker, "TOPLEFT", 8, -4)
	scrollBox:SetPoint("BOTTOMRIGHT", app.StatusTracker, "BOTTOMRIGHT", -18, 4)
	scrollBox:EnableMouse(true)
	scrollBox:RegisterForDrag("LeftButton")
	scrollBox:SetScript("OnDragStart", function() app:MoveStatusTracker() end)
	scrollBox:SetScript("OnDragStop", function() app:SaveStatusTracker() end)

	local scrollBar = CreateFrame("EventFrame", nil, app.StatusTracker, "MinimalScrollBar")
	scrollBar:SetPoint("TOPLEFT", scrollBox, "TOPRIGHT")
	scrollBar:SetPoint("BOTTOMLEFT", scrollBox, "BOTTOMRIGHT")
	scrollBox:HookScript("OnSizeChanged", function()
		if scrollBox:HasScrollableExtent() then
			scrollBar:Show()
		else
			scrollBar:Hide()
		end
	end)

	app.StatusTracker.Corner = CreateFrame("Button", nil, app.StatusTracker)
	app.StatusTracker.Corner:EnableMouse("true")
	app.StatusTracker.Corner:SetPoint("BOTTOMRIGHT")
	app.StatusTracker.Corner:SetSize(16,16)
	app.StatusTracker.Corner:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
	app.StatusTracker.Corner:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
	app.StatusTracker.Corner:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
	app.StatusTracker.Corner:SetScript("OnMouseDown", function() app.StatusTracker:StartSizing("BOTTOMRIGHT") end)
	app.StatusTracker.Corner:SetScript("OnMouseUp", function() app:SaveStatusTracker() end)

	app.ScrollView = CreateScrollBoxListTreeListView()
	ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, app.ScrollView)

	local function Initializer(listItem, node)
		local data = node:GetData()

		--if data.index then
			listItem.Text:SetText("|T" .. data.icon .. ":16|t" .. " " .. data.text)
			listItem.Text:SetFont("Fonts\\FRIZQT__.TTF", 20)
		--end

		listItem:EnableMouse(true)
		listItem:RegisterForDrag("LeftButton")
		listItem:SetScript("OnDragStart", function() app:MoveStatusTracker() end)
		listItem:SetScript("OnDragStop", function() app:SaveStatusTracker() end)
	end

	app.ScrollView:SetElementInitializer("Watchtower_ListItem30", Initializer)
end

function app:UpdateStatusTracker()
	local DataProvider = CreateTreeDataProvider()

	for k, v in ipairs(app.Table) do
		DataProvider:Insert({ icon = v.icon, text = v.text })
	end

	app.ScrollView:SetDataProvider(DataProvider, true)
end

app.Table = {
	{ icon = "Interface\\Icons\\ui_profession_blacksmithing", text = "Blacksmithing" },
	{ icon = "Interface\\Icons\\ui_profession_leatherworking", text = "Leatherworking" },
	{ icon = "Interface\\Icons\\ui_profession_alchemy", text = "Alchemy" },
	{ icon = "Interface\\Icons\\ui_profession_tailoring", text = "Tailoring" },
	{ icon = "Interface\\Icons\\ui_profession_cooking", text = "Cooking" },
	{ icon = "Interface\\Icons\\ui_profession_fishing", text = "Fishing" },
	{ icon = "Interface\\Icons\\ui_profession_herbalism", text = "Herbalism" },
	{ icon = "Interface\\Icons\\ui_profession_mining", text = "Mining" },
	{ icon = "Interface\\Icons\\ui_profession_engineering", text = "Engineering" },
	{ icon = "Interface\\Icons\\ui_profession_enchanting", text = "Enchanting" },
	{ icon = "Interface\\Icons\\ui_profession_skinning", text = "Skinning" },
	{ icon = "Interface\\Icons\\ui_profession_jewelcrafting", text = "Jewelcrafting" },
	{ icon = "Interface\\Icons\\ui_profession_inscription", text = "Inscription" },
}
