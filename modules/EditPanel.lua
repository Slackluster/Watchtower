-------------------------------
-- Watchtower: EditPanel.lua --
-------------------------------

local appName, app = ...
local api = app.api
local L = app.locales

-------------
-- ON LOAD --
-------------

app.Event:Register("ADDON_LOADED", function(addOnName, containsBindings)
	if addOnName == appName then
		app:CreateEditPanel()
		app:RegisterEvents()
	end
end)

----------------
-- EDIT PANEL --
----------------

function api:ToggleEditPanel()
	if app.EditPanel:IsShown() then
		app.EditPanel:Hide()
	else
		app.EditPanel:Show()
	end
end

function app:CreateEditPanel()
	-- Main panel
	app.EditPanel = CreateFrame("Frame", nil, UIParent, "PortraitFrameTexturedBaseTemplate")
	app.EditPanel:SetPortraitToAsset(app.Texture)
	app.EditPanel:SetSize(800,500)
	app.EditPanel:SetPoint("CENTER")
	app.EditPanel:EnableMouse(true)
	app.EditPanel:SetMovable(true)
	app.EditPanel:SetClampedToScreen(true)
	local inset = 300
	app.EditPanel:SetClampRectInsets(app.EditPanel:GetWidth()-inset, -(app.EditPanel:GetWidth()-inset), -(app.EditPanel:GetHeight()-inset), app.EditPanel:GetHeight()-inset)
	app.EditPanel:RegisterForDrag("LeftButton")
	app.EditPanel:SetScript("OnDragStart", function() app.EditPanel:StartMoving() end)
	app.EditPanel:SetScript("OnDragStop", function() app.EditPanel:StopMovingOrSizing() end)
	app.EditPanel:SetTitle(app.NameLong)
	app.EditPanel:Hide()

	app.EditPanel.CloseButton = CreateFrame("Button", nil, app.EditPanel, "UIPanelCloseButtonDefaultAnchors")
	app.EditPanel.CloseButton:SetScript("OnClick", function()
		app.EditPanel:Hide()
	end)

	app.EditPanel.StatusList = CreateFrame("Frame", nil, app.EditPanel, nil)
	app.EditPanel.StatusList:SetPoint("TOPLEFT", app.EditPanel, 6, -50)
	app.EditPanel.StatusList:SetPoint("BOTTOMLEFT", app.EditPanel, 6, 9)
	app.EditPanel.StatusList:SetWidth(250)
	app.EditPanel.StatusList.Background = app.EditPanel.StatusList:CreateTexture(nil, "BACKGROUND")
	app.EditPanel.StatusList.Background:SetAllPoints()
	app.EditPanel.StatusList.Background:SetAtlas("Professions-background-summarylist")
	NineSliceUtil.ApplyLayoutByName(app.EditPanel.StatusList, "InsetFrameTemplate")

	local function newFlag()
		table.insert(Watchtower_Flags, { id = #Watchtower_Flags + 1, text = "New Flag", icon = 134400, trigger = "return true", events = { "PLAYER_ENTERING_WORLD" }, lastResult = true })
		app.ScrollView2.Selection = #Watchtower_Flags
		app:UpdateStatusList()
	end

	local function deleteFlag()
		-- TODO: confirm dialog
		app:DeRegisterEvents(Watchtower_Flags[app.ScrollView2.Selection])
		table.remove(Watchtower_Flags, app.ScrollView2.Selection)
		app:ReIndexTable(Watchtower_Flags)
		app.ScrollView2.Selection = max(1, app.ScrollView2.Selection - 1)
		if #Watchtower_Flags == 0 then
			newFlag()
		else
			app:UpdateStatusList()
		end
	end

	local function importFlag()
	end

	local function exportFlag()
	end

	app.EditPanel.NewButton = app:MakeButton(app.EditPanel, "New")
	app.EditPanel.NewButton:SetPoint("BOTTOMRIGHT", app.EditPanel.StatusList, "TOPRIGHT", 0, 2)
	app.EditPanel.NewButton:SetScript("OnClick", newFlag)

	app.EditPanel.ImportButton = app:MakeButton(app.EditPanel, "Import")
	app.EditPanel.ImportButton:SetPoint("TOPRIGHT", app.EditPanel.NewButton, "TOPLEFT", -2, 0)
	app.EditPanel.ImportButton:SetScript("OnClick", importFlag)

	app.EditPanel.DeleteButton = app:MakeButton(app.EditPanel, "Delete")
	app.EditPanel.DeleteButton:SetPoint("TOP", app.EditPanel.NewButton)
	app.EditPanel.DeleteButton:SetPoint("RIGHT", app.EditPanel, -6, 0)
	app.EditPanel.DeleteButton:SetScript("OnClick", deleteFlag)

	app.EditPanel.ExportButton = app:MakeButton(app.EditPanel, "Export")
	app.EditPanel.ExportButton:SetPoint("TOPRIGHT", app.EditPanel.DeleteButton, "TOPLEFT", -2, 0)
	app.EditPanel.ExportButton:SetScript("OnClick", exportFlag)

	-- Flag list
	local scrollBox = CreateFrame("Frame", nil, app.EditPanel.StatusList, "WowScrollBoxList")
	scrollBox:SetPoint("TOPLEFT", app.EditPanel.StatusList, 7, -6)
	scrollBox:SetPoint("BOTTOMRIGHT", app.EditPanel.StatusList, -18, 4)
	scrollBox:EnableMouse(true)
	scrollBox:RegisterForDrag("LeftButton")
	scrollBox:SetScript("OnDragStart", function() app.EditPanel:StartMoving() end)
	scrollBox:SetScript("OnDragStop", function() app.EditPanel:StopMovingOrSizing() end)

	local scrollBar = CreateFrame("EventFrame", nil, app.EditPanel.StatusList, "MinimalScrollBar")
	scrollBar:SetPoint("TOPLEFT", scrollBox, "TOPRIGHT")
	scrollBar:SetPoint("BOTTOMLEFT", scrollBox, "BOTTOMRIGHT")

	local divider = app.EditPanel.StatusList:CreateTexture(nil, "ARTWORK")
	divider:SetSize(240,20)
	divider:SetAtlas("CovenantChoice-Celebration-KyrianGlowLine")
	divider:Hide()

	app.ScrollView2 = CreateScrollBoxListTreeListView()
	ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, app.ScrollView2)

	function app:ReIndexTable(tbl)
		table.sort(tbl, function(a, b)
			return a.id < b.id
		end)

		for i, entry in ipairs(tbl) do
			entry.id = i
		end

		app:UpdateStatusList()
	end

	function app:MoveTableEntry(tbl, oldIndex, targetIndex)
		tbl[oldIndex].id = targetIndex + 0.5
		app:ReIndexTable(tbl)
	end

	local function Initializer(listItem, node)
		local data = node:GetData()

		--if data.index then
			listItem.LeftText1:SetText("|T" .. data.icon .. ":18|t")
			listItem.LeftText2:SetText(data.text)
			listItem.LeftText2:SetFont("Fonts\\FRIZQT__.TTF", 14)
		--end

		if not listItem.Highlight then
			listItem.Highlight = listItem:CreateTexture(nil, "ARTWORK")
			listItem.Highlight:SetAtlas("Options_List_Active")
			listItem.Highlight:SetAllPoints()
		end
		listItem.Highlight:Hide()

		if app.ScrollView2.Selection == data.id then
			listItem.LeftText2:SetText("|cffFFFFFF" .. data.text)
			listItem.Highlight:Show()
		end

		listItem:EnableMouse(true)
		listItem:RegisterForDrag("LeftButton")
		listItem:SetScript("OnDragStart", function(self)
			app.Flag.Dragging = true
			self:SetAlpha(0.5)
		end)
		listItem:SetScript("OnDragStop", function(self)
			if not app.Flag.Dragging then return end
			app.Flag.Dragging = false
			self:SetAlpha(1)
			divider:Hide()

			if not (data.id == app.Flag.Hover) then
				app:MoveTableEntry(Watchtower_Flags, data.id, app.Flag.Hover)
			end
		end)
		listItem:SetScript("OnEnter", function(self)
			if app.Flag.Dragging then
				app.Flag.Hover = data.id
				RunNextFrame(function()
					divider:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, 10)
					divider:Show()
				end)
			end
		end)
		listItem:SetScript("OnLeave", function(self)
			if app.Flag.Dragging then
				if not(data.id == #Watchtower_Flags and app.Flag.Hover == #Watchtower_Flags) then
					divider:Hide()
				end
			end
		end)
		listItem:SetScript("OnClick", function()
			app.ScrollView2.Selection = data.id
			app:UpdateStatusList()
		end)
	end

	app.ScrollView2:SetElementInitializer("Watchtower_ListButton", Initializer)

	-- Options frame
	app.EditPanel.Options = CreateFrame("Frame", nil, app.EditPanel, "NineSlicePanelTemplate")
	app.EditPanel.Options:SetPoint("TOPLEFT", app.EditPanel.StatusList, "TOPRIGHT", 4, 0)
	app.EditPanel.Options:SetPoint("BOTTOMRIGHT", app.EditPanel, -6, 9)
	app.EditPanel.Options.Background = app.EditPanel.Options:CreateTexture(nil, "BACKGROUND")
	app.EditPanel.Options.Background:SetAtlas("thewarwithin-landingpage-background")
	app.EditPanel.Options.Background:SetAllPoints()
	app.EditPanel.Options.Background:SetTexCoord(1, 0, 0, 1)
	NineSliceUtil.ApplyLayoutByName(app.EditPanel.Options, "InsetFrameTemplate")

	local function createTab(label, id)
		local tab = CreateFrame("Button", nil, app.EditPanel.Options, "PanelTopTabButtonTemplate")
		tab:SetText(label)
		tab:SetID(id)

		if id == 1 then
			tab:SetPoint("BOTTOMLEFT", app.EditPanel.Options, "TOPLEFT", 10, -3)
		else
			tab:SetPoint("LEFT", app.EditPanel.Tabs[id - 1], "RIGHT", -15, 0)
		end

		app.EditPanel.Tabs[id] = tab
		PanelTemplates_SetNumTabs(app.EditPanel.Options, #app.EditPanel.Tabs)

		tab:SetScript("OnClick", function()
			PanelTemplates_SetTab(app.EditPanel.Options, tab:GetID())
			for tabID, frame in pairs (app.EditPanel.Pages) do
				if tabID == id then
					frame:Show()
				else
					frame:Hide()
				end
			end
		end)

		return tab
	end

	app.EditPanel.Tabs = {}

	createTab("General", 1)

	app.EditPanel.Pages = {}
	app.EditPanel.Pages[1] = CreateFrame("Frame", nil, app.EditPanel.Options, nil)
	app.EditPanel.Pages[1]:SetAllPoints(app.EditPanel.Options)
	app.EditPanel.Pages[1]:Show()

	local leftEdge = 60

	local string1 = app.EditPanel.Pages[1]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string1:SetText("Title")
	string1:SetPoint("TOPLEFT", app.EditPanel.Pages[1], 10, -20)

	local backdrop = CreateFrame("Frame", nil, app.EditPanel.Pages[1], "BackdropTemplate")
	backdrop:SetSize(200, 23)
	backdrop:SetPoint("LEFT", string1, "LEFT", leftEdge, 0)
	backdrop:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	backdrop:SetBackdropColor(0.122, 0.122, 0.122, 0.8)

	app.EditPanel.Options.Title = CreateFrame("EditBox", nil, backdrop)
	app.EditPanel.Options.Title:SetFontObject(ChatFontNormal)
	app.EditPanel.Options.Title:SetSize(backdrop:GetWidth()-6, backdrop:GetHeight())
	app.EditPanel.Options.Title:SetPoint("TOPLEFT", backdrop, 6, 0)
	app.EditPanel.Options.Title:SetAutoFocus(false)
	app.EditPanel.Options.Title:SetScript("OnEditFocusGained", function(self)
		self:HighlightText(0, 0)
	end)
	app.EditPanel.Options.Title:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
	end)
	app.EditPanel.Options.Title:SetScript("OnEscapePressed", function(self)
		self:SetText(Watchtower_Flags[app.ScrollView2.Selection].text or "")
		self:ClearFocus()
	end)
	app.EditPanel.Options.Title:SetScript("OnEditFocusLost", function(self)
		Watchtower_Flags[app.ScrollView2.Selection].text = self:GetText()
		app:UpdateStatusList()
	end)

	local string2 = app.EditPanel.Pages[1]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string2:SetText("Icon")
	string2:SetPoint("TOPLEFT", string1, "BOTTOMLEFT", 0, -20)

	local backdrop = CreateFrame("Frame", nil, app.EditPanel.Pages[1], "BackdropTemplate")
	backdrop:SetSize(200, 23)
	backdrop:SetPoint("LEFT", string2, "LEFT", leftEdge, 0)
	backdrop:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	backdrop:SetBackdropColor(0.122, 0.122, 0.122, 0.8)

	app.EditPanel.Options.Icon = CreateFrame("EditBox", nil, backdrop)
	app.EditPanel.Options.Icon:SetFontObject(ChatFontNormal)
	app.EditPanel.Options.Icon:SetSize(backdrop:GetWidth()-6, backdrop:GetHeight())
	app.EditPanel.Options.Icon:SetPoint("TOPLEFT", backdrop, 6, 0)
	app.EditPanel.Options.Icon:SetAutoFocus(false)
	app.EditPanel.Options.Icon:SetScript("OnEditFocusGained", function(self)
		self:HighlightText(0, 0)
	end)
	app.EditPanel.Options.Icon:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
	end)
	app.EditPanel.Options.Icon:SetScript("OnEscapePressed", function(self)
		self:SetText(Watchtower_Flags[app.ScrollView2.Selection].icon or "")
		self:ClearFocus()
	end)
	app.EditPanel.Options.Icon:SetScript("OnEditFocusLost", function(self)
		Watchtower_Flags[app.ScrollView2.Selection].icon = self:GetText()
		app:UpdateStatusList()
	end)

	local string3 = app.EditPanel.Pages[1]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string3:SetText("Trigger")
	string3:SetPoint("TOPLEFT", string2, "BOTTOMLEFT", 0, -20)

	local backdrop = CreateFrame("Frame", nil, app.EditPanel.Pages[1], "BackdropTemplate")
	backdrop:SetPoint("TOPLEFT", string3, "TOPLEFT", leftEdge, 0)
	backdrop:SetPoint("BOTTOMLEFT", string3, "TOPLEFT", leftEdge, -118)
	backdrop:SetPoint("BOTTOMRIGHT", app.EditPanel.Options, "RIGHT", -10, 0)
	backdrop:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	backdrop:SetBackdropColor(0.122, 0.122, 0.122, 0.8)

	local scrollFrame1 = CreateFrame("ScrollFrame", nil, backdrop, "UIPanelScrollFrameTemplate")
	scrollFrame1:SetPoint("TOPLEFT", 5, -5)
	scrollFrame1:SetPoint("BOTTOMRIGHT", -27, 4)
	scrollFrame1:SetScript("OnMouseDown", function()
		app.EditPanel.Options.Trigger:SetFocus()
	end)

	app.EditPanel.Options.Trigger = CreateFrame("EditBox", nil, scrollFrame1)
	app.EditPanel.Options.Trigger:SetFont("Interface\\AddOns\\Watchtower\\assets\\courbd.ttf", 14, "")
	app.EditPanel.Options.Trigger:SetWidth(scrollFrame1:GetWidth())
	app.EditPanel.Options.Trigger:SetPoint("TOPLEFT")
	app.EditPanel.Options.Trigger:SetMultiLine(true)
	app.EditPanel.Options.Trigger:SetTextColor(0.612, 0.863, 0.996, 1)
	scrollFrame1:SetScrollChild(app.EditPanel.Options.Trigger)

	app.EditPanel.Options.Trigger:SetAutoFocus(false)
	app.EditPanel.Options.Trigger:SetScript("OnEscapePressed", function(self)
		self:SetText(Watchtower_Flags[app.ScrollView2.Selection].trigger or "")
		self:ClearFocus()
	end)
	app.EditPanel.Options.Trigger:SetScript("OnEditFocusLost", function(self)
		Watchtower_Flags[app.ScrollView2.Selection].trigger = self:GetText()
		app:RegisterEvents(app.ScrollView2.Selection)
		app:UpdateStatusList()
	end)

	IndentationLib.enable(app.EditPanel.Options.Trigger, nil, 3)

	function app:RunTrigger(id, debug)
		if not Watchtower_Flags[id].trigger then
			if debug then
				app:Print("There is no code to test.")
			end
			return false
		end

		local func, error = loadstring(Watchtower_Flags[id].trigger)
		if error then
			if debug then
				app:Print("There is an error in your trigger code:")
				DevTools_Dump(error)
			end
			return false
		end

		local env = app:CreateTriggerEnv()
		setfenv(func, env)

		local ok, result = pcall(func)
		if not ok then
			if debug then
				app:Print("There is an error in your trigger code:")
				app:Print(result)
			end
			return false
		end

		if debug then
			app:Print("No syntax errors found in your trigger. :)")
		end

		return result
	end

	app.EditPanel.TestButton = app:MakeButton(app.EditPanel.Pages[1], "Test")
	app.EditPanel.TestButton:SetPoint("TOPLEFT", string3, "BOTTOMLEFT", -2, -6)
	app.EditPanel.TestButton:SetScript("OnClick", function()
		Watchtower_Flags[app.ScrollView2.Selection].lastResult = app:RunTrigger(app.ScrollView2.Selection, true)
		app:UpdateStatusTracker()
	end)

	local f = CreateFrame("Frame")
	local function doesEventExist(event)
		if type(event) ~= "string" or event == "" then
			return false, "Attempt to register unknown event"
		end

		local exists, error = pcall(f.RegisterEvent, f, event)
		if not exists then
			return false, error
		end

		return true
	end

	function app:MakeCsvTable(str)
		local tbl = {}
		if not str or str == "" then return tbl end

		for value in string.gmatch(str, "[^,;]+") do	-- Separate by , and ;
			local event = value:match("^%s*(.-)%s*$")	-- Trim whitespace

			local exists, error = doesEventExist(event)
			if not exists then
				app:Print(error)
			else
				table.insert(tbl, string.upper(event))
			end
		end

		return tbl
	end

	function app:MakeCsvString(tbl)
		if not tbl or tbl == "" then return "" end
		return table.concat(tbl, ", ")
	end

	local string4 = app.EditPanel.Pages[1]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string4:SetText("Events")
	string4:SetPoint("TOPLEFT", string3, "BOTTOMLEFT", 0, -120)

	local backdrop = CreateFrame("Frame", nil, app.EditPanel.Pages[1], "BackdropTemplate")
	backdrop:SetPoint("TOPLEFT", string4, "TOPLEFT", leftEdge, 0)
	backdrop:SetPoint("BOTTOMLEFT", string4, "TOPLEFT", leftEdge, -36)
	backdrop:SetPoint("BOTTOMRIGHT", app.EditPanel.Options, "RIGHT", -10, 0)
	backdrop:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	backdrop:SetBackdropColor(0.122, 0.122, 0.122, 0.8)

	local scrollFrame2 = CreateFrame("ScrollFrame", nil, backdrop, "UIPanelScrollFrameTemplate")
	scrollFrame2.ScrollBar:Hide()
	scrollFrame2.ScrollBar.Show = nop
	scrollFrame2:SetPoint("TOPLEFT", 5, -5)
	scrollFrame2:SetPoint("BOTTOMRIGHT", -27, 4)
	scrollFrame2:SetScript("OnMouseDown", function()
		app.EditPanel.Options.Events:SetFocus()
	end)

	app.EditPanel.Options.Events = CreateFrame("EditBox", nil, scrollFrame2)
	app.EditPanel.Options.Events:SetFont("Interface\\AddOns\\Watchtower\\assets\\courbd.ttf", 14, "")
	app.EditPanel.Options.Events:SetWidth(scrollFrame2:GetWidth())
	app.EditPanel.Options.Events:SetPoint("TOPLEFT")
	app.EditPanel.Options.Events:SetMultiLine(true)
	app.EditPanel.Options.Events:SetTextColor(0.612, 0.863, 0.996, 1)
	scrollFrame2:SetScrollChild(app.EditPanel.Options.Events)

	app.EditPanel.Options.Events:SetAutoFocus(false)
	app.EditPanel.Options.Events:SetScript("OnEscapePressed", function(self)
		self:SetText(app:MakeCsvString(Watchtower_Flags[app.ScrollView2.Selection].events or ""))
		self:ClearFocus()
	end)
	app.EditPanel.Options.Events:SetScript("OnEditFocusLost", function(self)
		Watchtower_Flags[app.ScrollView2.Selection].events = app:MakeCsvTable(self:GetText())
		app:RegisterEvents(app.ScrollView2.Selection)
		app:UpdateStatusList()
	end)

	PanelTemplates_SetTab(app.EditPanel.Options, 1)
	PanelTemplates_UpdateTabs(app.EditPanel.Options)

	app.ScrollView2.Selection = 1
	app:UpdateStatusList()
end

function app:UpdateStatusList()
	local DataProvider = CreateTreeDataProvider()

	for k, v in ipairs(Watchtower_Flags) do
		DataProvider:Insert({ id = v.id, icon = v.icon, text = v.text })
	end

	app.ScrollView2:SetDataProvider(DataProvider, true)

	if Watchtower_Flags[app.ScrollView2.Selection] then
		app.EditPanel.Options.Title:SetText(Watchtower_Flags[app.ScrollView2.Selection].text or "")
		app.EditPanel.Options.Icon:SetText(Watchtower_Flags[app.ScrollView2.Selection].icon or "")
		app.EditPanel.Options.Trigger:SetText(Watchtower_Flags[app.ScrollView2.Selection].trigger or "")
		app.EditPanel.Options.Events:SetText(app:MakeCsvString(Watchtower_Flags[app.ScrollView2.Selection].events or ""))
	end

	if app.ScrollView then app:UpdateStatusTracker() end
end

function app:CreateTriggerEnv()
	local env = {}

	local safeG = setmetatable({}, {
		__index = function(_, key)
			if app.Blocked[key] then
				error(("Access to '%s' is blocked"):format(tostring(key)), 2)
			end
			return _G[key]
		end,
			__newindex = function(_, key, value)
			if app.Blocked[key] then
				error(("Assignment to '%s' is blocked"):format(tostring(key)), 2)
			end
			_G[key] = value
		end,
	})
	env._G = safeG

	setmetatable(env, {
		__index = function(tbl, key)
			if app.Blocked[key] then
				error(("Access to '%s' is blocked"):format(tostring(key)), 2)
			end
			local v = rawget(tbl, key)
			if v ~= nil then return v end
			return _G[key]
		end,
		__newindex = function(tbl, key, value)
			if app.Blocked[key] then
				error(("Assignment to '%s' is blocked"):format(tostring(key)), 2)
			end
			rawset(tbl, key, value)
		end,
	})

	return env
end

function app:ValidateTrigger(flag)
	local func, error = loadstring(flag.trigger)
	if not func then
		return false, error
	end

	local env = app:CreateTriggerEnv()
	setfenv(func, env)

	local ok, runtimeErr = pcall(func)
	if not ok then
		return false, runtimeErr
	end

	return true
end


function app:DeRegisterEvents(flag)
	if flag.handles then
		for _, handle in ipairs(flag.handles) do
			app.Event:Unregister(handle)
		end
	end
	flag.handles = {}
end

function app:RegisterEvents(flagID)
	local function handleEvents(flag)
		local func, error = loadstring(flag.trigger)
		if not error then
			for _, event in ipairs(flag.events) do
				local wrapper = function(...)
					local ok, result = pcall(func, ...)
					if ok then
						flag.lastResult = result
					else
						flag.lastResult = false
					end
				end

				local handle = app.Event:Register(event, wrapper)
				table.insert(flag.handles, handle)
			end
		end
	end

	if flagID then
		app:DeRegisterEvents(Watchtower_Flags[flagID])
		handleEvents(Watchtower_Flags[flagID])
	else
		for _, flag in ipairs(Watchtower_Flags) do
			app:DeRegisterEvents(flag)
			handleEvents(flag)
		end
	end
end
