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
		for id = 2, #Watchtower_Flags do
			app:CreateTracker(id)
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

	local left, right, top, bottom = app.Tracker[id].window:GetLeft(), app.Tracker[id].window:GetRight(), app.Tracker[id].window:GetTop(), app.Tracker[id].window:GetBottom()
	local width, height = app.Tracker[id].window:GetSize()
	Watchtower_Flags[id].position = { left = left, right = right, top = top, bottom = bottom, width = width, height = height }
end

function app:ShowTracker(id)
	local w = app.Tracker[id].window
	local p = Watchtower_Flags[id].position

	w:SetScale(Watchtower_Flags[id].scale/100)
	w:ClearAllPoints()
	if Watchtower_Flags[id].position then
		w:SetSize(p.width, p.height)
		if Watchtower_Flags[id].anchor == 1 then
			w:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", p.left, p.top)
		elseif Watchtower_Flags[id].anchor == 2 then
			w:SetPoint("TOPRIGHT", UIParent, "BOTTOMLEFT", p.right, p.top)
		elseif Watchtower_Flags[id].anchor == 3 then
			w:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", p.left, p.bottom)
		elseif Watchtower_Flags[id].anchor == 4 then
			w:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMLEFT", p.right, p.bottom)
		end
	else
		w:SetSize(200, 200)
		w:SetPoint("CENTER", UIParent)
		app:SaveTracker(id)
	end

	app:UpdateTracker(id)
	w:Show()
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
	app.Tracker[id].window:SetBackdropColor(0, 0, 0, 0)
	app.Tracker[id].window:SetBackdropBorderColor(0.25, 0.78, 0.92, 0)
	app.Tracker[id].window:EnableMouse(false)
	app.Tracker[id].window:SetResizable(true)
	app.Tracker[id].window:SetResizeBounds(140, 140, 2000, 2000)
	app.Tracker[id].window:SetMovable(true)
	app.Tracker[id].window:SetClampedToScreen(true)
	app.Tracker[id].window:RegisterForDrag("LeftButton")
	app.Tracker[id].window:SetClampRectInsets(10, -10, -10, 10)
	app.Tracker[id].window:SetScript("OnDragStart", function() app:MoveTracker(id) end)
	app.Tracker[id].window:SetScript("OnDragStop", function() app:SaveTracker(id) end)

	app.Tracker[id].window.corner = CreateFrame("Button", nil, app.Tracker[id].window)
	app.Tracker[id].window.corner:EnableMouse("true")
	app.Tracker[id].window.corner:SetSize(16,16)
	app.Tracker[id].window.corner:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
	app.Tracker[id].window.corner:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
	app.Tracker[id].window.corner:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
	app.Tracker[id].window.corner:SetScript("OnMouseUp", function() app:SaveTracker(id) end)
	app.Tracker[id].window.corner:Hide()

	local tracker = app.Tracker[id]
	tracker.window:SetClipsChildren(true)
	tracker.content = CreateFrame("Frame", nil, tracker.window)
    tracker.content:SetPoint("TOPLEFT", 8, -8)
    tracker.content:SetPoint("BOTTOMRIGHT", -8, 8)
    tracker.content:SetSize(1, 1)
    tracker.content.children = {}

    tracker.pool = CreateFramePool("Button", tracker.content, "Watchtower_TrackerItem")	-- I'll be honest, I don't know why it needs this template

	app:ShowTracker(id)
end

function app:UpdateTracker(id)
	if Watchtower_Flags[id].anchor == 1 then
		app.Tracker[id].window.corner:ClearAllPoints()
		app.Tracker[id].window.corner:SetPoint("BOTTOMRIGHT")
		app.Tracker[id].window.corner:SetScript("OnMouseDown", function() app.Tracker[id].window:StartSizing("BOTTOMRIGHT") end)
		app.Tracker[id].window.corner:GetNormalTexture():SetRotation(0)
		app.Tracker[id].window.corner:GetHighlightTexture():SetRotation(0)
		app.Tracker[id].window.corner:GetPushedTexture():SetRotation(0)
	elseif Watchtower_Flags[id].anchor == 2 then
		app.Tracker[id].window.corner:ClearAllPoints()
		app.Tracker[id].window.corner:SetPoint("BOTTOMLEFT")
		app.Tracker[id].window.corner:SetScript("OnMouseDown", function() app.Tracker[id].window:StartSizing("BOTTOMLEFT") end)
		app.Tracker[id].window.corner:GetNormalTexture():SetRotation(-math.pi/2)
		app.Tracker[id].window.corner:GetHighlightTexture():SetRotation(-math.pi/2)
		app.Tracker[id].window.corner:GetPushedTexture():SetRotation(-math.pi/2)
	elseif Watchtower_Flags[id].anchor == 3 then
		app.Tracker[id].window.corner:ClearAllPoints()
		app.Tracker[id].window.corner:SetPoint("TOPRIGHT")
		app.Tracker[id].window.corner:SetScript("OnMouseDown", function() app.Tracker[id].window:StartSizing("TOPRIGHT") end)
		app.Tracker[id].window.corner:GetNormalTexture():SetRotation(math.pi / 2)
		app.Tracker[id].window.corner:GetHighlightTexture():SetRotation(math.pi / 2)
		app.Tracker[id].window.corner:GetPushedTexture():SetRotation(math.pi / 2)
	elseif Watchtower_Flags[id].anchor == 4 then
		app.Tracker[id].window.corner:ClearAllPoints()
		app.Tracker[id].window.corner:SetPoint("TOPLEFT")
		app.Tracker[id].window.corner:SetScript("OnMouseDown", function() app.Tracker[id].window:StartSizing("TOPLEFT") end)
		app.Tracker[id].window.corner:GetNormalTexture():SetRotation(math.pi)
		app.Tracker[id].window.corner:GetHighlightTexture():SetRotation(math.pi)
		app.Tracker[id].window.corner:GetPushedTexture():SetRotation(math.pi)
	end

	local flags = {}
	for _, flag in ipairs(Watchtower_Flags[id].flags) do
		if flag.lastResult == true then
			table.insert(flags, flag)
		end
	end

	app.Tracker[id].pool:ReleaseAll()
	app.Tracker[id].content.children = {}

	local growUp = Watchtower_Flags[id].anchor >= 3
	local alignRight = Watchtower_Flags[id].anchor == 2 or Watchtower_Flags[id].anchor == 4
	local yOffset = 0
	local spacing = 6
	local rowHeight = 26

	local function makeRow(flag)
		local row = app.Tracker[id].pool:Acquire()
		row:SetParent(app.Tracker[id].content)
		row:SetHeight(rowHeight)
		row:EnableMouse(false)

		if not row.Text then
			row.Text = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		end

		if alignRight then
			row.Text:SetText(flag.title .. " |T" .. flag.icon .. ":24:24|t")
		else
			row.Text:SetText("|T" .. flag.icon .. ":24:24|t " .. flag.title)
		end

		for _, font in ipairs(app.Fonts) do
			if font.name == Watchtower_Flags[id].font then
				row.Text:SetFont(font.path, 16)
				break
			end
		end

		row.Text:ClearAllPoints()
		if alignRight then
			row.Text:SetPoint("RIGHT", row, "RIGHT", 0, 0)
			row.Text:SetPoint("TOP", row, "TOP", 0, 0)
			row.Text:SetPoint("BOTTOM", row, "BOTTOM", 0, 0)
			row.Text:SetJustifyH("RIGHT")
		else
			row.Text:SetPoint("LEFT", row, "LEFT", 0, 0)
			row.Text:SetPoint("TOP", row, "TOP", 0, 0)
			row.Text:SetPoint("BOTTOM", row, "BOTTOM", 0, 0)
			row.Text:SetJustifyH("LEFT")
		end

		row:SetWidth(app.Tracker[id].content:GetWidth())
		row:ClearAllPoints()
		return row
	end

	if growUp then
		for i = #flags, 1, -1 do
			local row = makeRow(flags[i])
			if alignRight then
				row:SetPoint("BOTTOMRIGHT", app.Tracker[id].content, "BOTTOMRIGHT", 2, yOffset)
			else
				row:SetPoint("BOTTOMLEFT", app.Tracker[id].content, "BOTTOMLEFT", -2, yOffset)
			end
			yOffset = yOffset + rowHeight + spacing
			table.insert(app.Tracker[id].content.children, row)
			row:Show()
		end
	else
		for i, flag in ipairs(flags) do
			local row = makeRow(flags[i])
			if alignRight then
				row:SetPoint("TOPRIGHT", app.Tracker[id].content, "TOPRIGHT", 2, -yOffset - 1)
			else
				row:SetPoint("TOPLEFT", app.Tracker[id].content, "TOPLEFT", -2, -yOffset - 1)
			end
			yOffset = yOffset + rowHeight + spacing
			table.insert(app.Tracker[id].content.children, row)
			row:Show()
		end
	end
end
