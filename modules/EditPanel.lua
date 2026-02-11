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
	local inset = 300

	-- Main panel
	app.EditPanel = CreateFrame("Frame", nil, UIParent, "PortraitFrameTexturedBaseTemplate")
	app.EditPanel:SetPortraitToAsset(app.Texture)
	app.EditPanel:SetSize(800,500)
	app.EditPanel:SetPoint("CENTER")
	app.EditPanel:EnableMouse(true)
	app.EditPanel:SetMovable(true)
	app.EditPanel:SetClampedToScreen(true)
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

	app.EditPanel:SetScript("OnShow", function()
		for id = 2, #Watchtower_Flags do
			app.Tracker[id].window:EnableMouse(true)
			app.Tracker[id].window.corner:Show()
			app.Tracker[id].window:SetBackdropColor(0, 0, 0, 0.5)
			app.Tracker[id].window:SetBackdropBorderColor(0.25, 0.78, 0.92, 0.5)
		end
	end)
	app.EditPanel:SetScript("OnHide", function()
		app.CodeBox:Hide()
		for id = 2, #Watchtower_Flags do
			app.Tracker[id].window:EnableMouse(false)
			app.Tracker[id].window.corner:Hide()
			app.Tracker[id].window:SetBackdropColor(0, 0, 0, 0)
			app.Tracker[id].window:SetBackdropBorderColor(0.25, 0.78, 0.92, 0)
		end
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
		table.insert(Watchtower_Flags[app.FlagsList.SelGroup].flags, { flagID = #Watchtower_Flags[app.FlagsList.SelGroup].flags + 1, title = L.NEW_FLAG, icon = 134400, trigger = "return true", events = { "PLAYER_ENTERING_WORLD" }, lastResult = true })
		app.FlagsList.SelFlag = #Watchtower_Flags[app.FlagsList.SelGroup].flags
		app:SetSelected()
		app:UpdateStatusList()
	end

	local function deleteFlag()
		app:DeRegisterEvents(app.FlagsList.Selected)
		table.remove(Watchtower_Flags[app.FlagsList.SelGroup].flags, app.FlagsList.SelFlag)
		app.FlagsList.SelFlag = app.FlagsList.SelFlag - 1
		app:SetSelected()
		app:ReIndexTable(Watchtower_Flags[app.FlagsList.SelGroup].flags)
	end

	local function deleteGroup()
		app.Tracker[app.FlagsList.SelGroup].window:Hide()
		table.remove(Watchtower_Flags, app.FlagsList.SelGroup)
		table.remove(app.Tracker, app.FlagsList.SelGroup)
		app.FlagsList.SelGroup = app.FlagsList.SelGroup - 1
		app.FlagsList.SelFlag = 0
		app:SetSelected()
		app:ReIndexTable(Watchtower_Flags)
		app:ReIndexTable(app.Tracker)
	end

	StaticPopupDialogs["WATCHTOWER_DELETEFLAG"] = {
		text = L.DELETE_FLAG_Q .. "\n" .. L.HOLD_SKIP,
		button1 = CONTINUE,
		button2 = CANCEL,
		whileDead = true,
		hideOnEscape = true,
		OnShow = function(dialog)
			dialog:ClearAllPoints()
			dialog:SetPoint("CENTER", UIParent)
		end,
		OnAccept = deleteFlag,
	}
	StaticPopupDialogs["WATCHTOWER_DELETEGROUP"] = {
		text = L.DELETE_GROUP_Q .. "\n" .. L.HOLD_SKIP,
		button1 = CONTINUE,
		button2 = CANCEL,
		whileDead = true,
		hideOnEscape = true,
		OnShow = function(dialog)
			dialog:ClearAllPoints()
			dialog:SetPoint("CENTER", UIParent)
		end,
		OnAccept = deleteGroup,
	}
	StaticPopupDialogs["WATCHTOWER_CANTDELETE"] = {
		text = L.CANTDELETE_GROUP,
		button1 = OKAY,
		whileDead = true,
		hideOnEscape = true,
		OnShow = function(dialog)
			dialog:ClearAllPoints()
			dialog:SetPoint("CENTER", UIParent)
		end,
	}

	local function delete()
		if app.FlagsList.SelFlag == 0 then
			if #Watchtower_Flags[app.FlagsList.SelGroup].flags >= 1 then
				StaticPopup_Show("WATCHTOWER_CANTDELETE")
			elseif IsShiftKeyDown() then
				deleteGroup()
			else
				StaticPopup_Show("WATCHTOWER_DELETEGROUP")
			end
		elseif IsShiftKeyDown() then
			deleteFlag()
		else
			StaticPopup_Show("WATCHTOWER_DELETEFLAG")
		end
	end

	local function newGroup()
		table.insert(Watchtower_Flags, { groupID = #Watchtower_Flags + 1, title = L.NEW_GROUP, style = 1, font = "Friz Quadrata TT", scale = 100, anchor = 3, flags = {} })
		app.FlagsList.SelGroup = #Watchtower_Flags
		app.FlagsList.SelFlag = 0
		app:SetSelected()
		app:UpdateStatusList()

		app:CreateTracker(app.FlagsList.SelGroup)
		app.EditPanel:GetScript("OnShow")(app.EditPanel)
	end

	app.EditPanel.NewFlagButton = app:MakeButton(app.EditPanel, L.NEW_FLAG)
	app.EditPanel.NewFlagButton:SetPoint("BOTTOMRIGHT", app.EditPanel.StatusList, "TOPRIGHT", 0, 2)
	app.EditPanel.NewFlagButton:SetScript("OnClick", newFlag)

	app.EditPanel.NewGroupButton = app:MakeButton(app.EditPanel, L.NEW_GROUP)
	app.EditPanel.NewGroupButton:SetPoint("TOPRIGHT", app.EditPanel.NewFlagButton, "TOPLEFT", -2, 0)
	app.EditPanel.NewGroupButton:SetScript("OnClick", newGroup)

	app.EditPanel.DeleteButton = app:MakeButton(app.EditPanel, L.DELETE_GROUP)
	app.EditPanel.DeleteButton:SetPoint("TOP", app.EditPanel.NewFlagButton)
	app.EditPanel.DeleteButton:SetPoint("RIGHT", app.EditPanel, -6, 0)
	app.EditPanel.DeleteButton:SetScript("OnClick", delete)

	app.EditPanel.ExportButton = app:MakeButton(app.EditPanel, L.EXPORT_GROUP)
	app.EditPanel.ExportButton:SetPoint("TOPRIGHT", app.EditPanel.DeleteButton, "TOPLEFT", -2, 0)
	app.EditPanel.ExportButton:SetScript("OnClick", function() StaticPopup_Show("WATCHTOWER_EXPORT") end)

	app.EditPanel.ImportButton = app:MakeButton(app.EditPanel, L.IMPORT)
	app.EditPanel.ImportButton:SetPoint("TOPRIGHT", app.EditPanel.ExportButton, "TOPLEFT", -2, 0)
	app.EditPanel.ImportButton:SetScript("OnClick", function() StaticPopup_Show("WATCHTOWER_IMPORT") end)

	-- Flag list
	local scrollBox = CreateFrame("Frame", nil, app.EditPanel.StatusList, "WowScrollBoxList")
	scrollBox:SetPoint("TOPLEFT", app.EditPanel.StatusList, 2, -4)
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

	app.FlagsList = CreateScrollBoxListTreeListView()
	ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, app.FlagsList)

	local function Initializer(listItem, node)
		local data = node:GetData()

		if data.icon then
			listItem.LeftText1:SetText("|T" .. data.icon .. ":18|t")
			if listItem.iconButton then listItem.iconButton:Hide() end
		elseif data.flagID == 0 then	-- Header
			listItem.LeftText1:SetText("")
			if not listItem.iconButton then
				listItem.iconButton = CreateFrame("Button", nil, listItem)
				listItem.iconButton:SetSize(22, 22)
				listItem.iconButton:SetFrameLevel(listItem:GetFrameLevel() + 1)
				listItem.iconButton:SetHighlightAtlas("common-button-collapseExpand-hover")
				listItem.iconButton:SetPropagateMouseClicks(false)
				listItem.iconButton.texture = listItem.iconButton:CreateTexture(nil, "ARTWORK")
				listItem.iconButton.texture:SetAllPoints()
			end
			if node:IsCollapsed() then
				listItem.iconButton.texture:SetTexture("Interface\\AddOns\\Watchtower\\assets\\button-right.png")
			else
				listItem.iconButton.texture:SetTexture("Interface\\AddOns\\Watchtower\\assets\\button-down.png")
			end
			listItem.iconButton:Show()
			listItem.iconButton:ClearAllPoints()
			listItem.iconButton:SetPoint("LEFT", listItem, "LEFT", 0, 1)
			listItem.iconButton:SetScript("OnClick", function()
				if data.flagID == 0 then
					node:ToggleCollapsed()
					Watchtower_Flags[data.groupID].collapsed = node:IsCollapsed()
					app:UpdateStatusList()
				end
			end)
		end

		listItem.LeftText2:SetText(data.title)
		listItem.LeftText2:SetFont("Fonts\\FRIZQT__.TTF", 14)

		if not listItem.Highlight then
			listItem.Highlight = listItem:CreateTexture(nil, "ARTWORK")
			listItem.Highlight:SetAtlas("Options_List_Active")
			listItem.Highlight:SetAllPoints()
		end
		listItem.Highlight:Hide()

		if data.groupID == 1 and data.flagID ~= 0 then
			listItem.LeftText2:SetText("|cff9d9d9d" .. data.title)
		end

		if app.FlagsList.SelGroup == data.groupID and app.FlagsList.SelFlag == data.flagID then
			listItem.LeftText2:SetText("|cffFFFFFF" .. data.title)
			listItem.Highlight:Show()
		end

		listItem:EnableMouse(true)
		listItem:RegisterForDrag("LeftButton")
		listItem:SetScript("OnDragStart", function(self)
			if data.groupID == 1 and data.flagID == 0 then
				app:Print(L.CANTMOVE_GROUP)
				return
			end
			app.Flag.Dragging = true
			app.Flag.Hover = { groupID = data.groupID, flagID = data.flagID }
			self:SetAlpha(0.5)
		end)
		listItem:SetScript("OnDragStop", function(self)
			if not app.Flag.Dragging then return end
			app.Flag.Dragging = false
			self:SetAlpha(1)
			divider:Hide()

			if not (data.groupID == app.Flag.Hover.groupID and data.flagID == app.Flag.Hover.flagID) then
				app:MoveTableEntry({ groupID = data.groupID, flagID = data.flagID }, app.Flag.Hover)
			end
		end)
		listItem:SetScript("OnEnter", function(self)
			if app.Flag.Dragging then
				app.Flag.Hover = { groupID = data.groupID, flagID = data.flagID }
				RunNextFrame(function()
					divider:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, 10)
					divider:Show()
				end)
			end
		end)
		listItem:SetScript("OnLeave", function(self)
			if app.Flag.Dragging then
				if not (app.Flag.Hover.groupID == #Watchtower_Flags and app.Flag.Hover.flagID == #Watchtower_Flags[#Watchtower_Flags].flags and data.groupID == #Watchtower_Flags and data.flagID == #Watchtower_Flags[#Watchtower_Flags].flags) then
					divider:Hide()
				end
			end
		end)
		listItem:SetScript("OnClick", function()
			app.FlagsList.SelGroup = data.groupID
			app.FlagsList.SelFlag = data.flagID
			app:SetSelected()
			app:UpdateStatusList()
		end)
	end

	app.FlagsList:SetElementInitializer("Watchtower_ListButton", Initializer)

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
			-- PanelTemplates_SetTab(app.EditPanel.Options, tab:GetID())
			-- for tabID, frame in pairs (app.EditPanel.Pages) do
			-- 	if tabID == id then
			-- 		frame:Show()
			-- 	else
			-- 		frame:Hide()
			-- 	end
			-- end
		end)

		return tab
	end

	app.EditPanel.Tabs = {}
	app.EditPanel.Pages = {}

	createTab("General", 1)

	app.EditPanel.Pages[0] = CreateFrame("Frame", nil, app.EditPanel.Options, nil)
	app.EditPanel.Pages[0]:SetAllPoints(app.EditPanel.Options)

	local string1 = app.EditPanel.Pages[0]:CreateFontString(nil, "ARTWORK", "Game15Font_o1")
	string1:SetPoint("TOPLEFT", app.EditPanel.Pages[0], 10, -12)
	string1:SetText(L.TUTORIAL_HEADER)

	local string2 = app.EditPanel.Pages[0]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string2:SetJustifyH("LEFT")
	string2:SetPoint("TOPLEFT", string1, "BOTTOMLEFT", 3, -4)
	string2:SetText(L.TUTORIAL_EXPLAIN1 .. "\n" .. L.TUTORIAL_EXPLAIN2)

	local string3 = app.EditPanel.Pages[0]:CreateFontString(nil, "ARTWORK", "Game13Font_o1")
	string3:SetPoint("TOPLEFT", string2, "BOTTOMLEFT", -3, -14)
	string3:SetText(L.TUTORIAL_TRIGGERE)

	local string4 = app.EditPanel.Pages[0]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string4:SetPoint("TOPLEFT", string3, "BOTTOMLEFT", 3, -4)
	string4:SetText(L.TUTORIAL_TRIGGER1)

	local string5 = app.EditPanel.Pages[0]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string5:SetFont("Interface\\AddOns\\Watchtower\\assets\\courbd.ttf", 14, "")
	string5:SetPoint("TOPLEFT", string4, "BOTTOMLEFT", 10, -3)
	string5:SetText("|cffFFFFFFlocal event, arg1, arg2 = ...")

	local string6 = app.EditPanel.Pages[0]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string6:SetPoint("TOPLEFT", string5, "BOTTOMLEFT", -10, -3)
	string6:SetText(L.TUTORIAL_TRIGGER2)

	local string7 = app.EditPanel.Pages[0]:CreateFontString(nil, "ARTWORK", "Game13Font_o1")
	string7:SetPoint("TOPLEFT", string6, "BOTTOMLEFT", -3, -14)
	string7:SetText(L.TUTORIAL_VISIBILITY)

	local string8 = app.EditPanel.Pages[0]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string8:SetPoint("TOPLEFT", string7, "BOTTOMLEFT", 3, -4)
	string8:SetText(L.TUTORIAL_VISIBILITY1)

	local string9 = app.EditPanel.Pages[0]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string9:SetFont("Interface\\AddOns\\Watchtower\\assets\\courbd.ttf", 14, "")
	string9:SetJustifyH("LEFT")
	string9:SetPoint("TOPLEFT", string8, "BOTTOMLEFT", 10, -2)
	string9:SetText("|cffFFFFFFreturn false\nreturn nil\nreturn")

	local string10 = app.EditPanel.Pages[0]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string10:SetPoint("TOPLEFT", string9, "BOTTOMLEFT", -10, -3)
	string10:SetText(L.TUTORIAL_VISIBILITY2)

	local string11 = app.EditPanel.Pages[0]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string11:SetFont("Interface\\AddOns\\Watchtower\\assets\\courbd.ttf", 14, "")
	string11:SetJustifyH("LEFT")
	string11:SetPoint("TOPLEFT", string10, "BOTTOMLEFT", 10, -3)
	string11:SetText("|cffFFFFFFreturn true\nreturn 1337\nreturn \"" .. TEST_STRING_IGNORE_1 .. "\"")

	local string12 = app.EditPanel.Pages[0]:CreateFontString(nil, "ARTWORK", "Game13Font_o1")
	string12:SetPoint("TOPLEFT", string11, "BOTTOMLEFT", -13, -11)
	string12:SetText(L.TUTORIAL_TITLE)

	local string13 = app.EditPanel.Pages[0]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string13:SetPoint("TOPLEFT", string12, "BOTTOMLEFT", 3, -3)
	string13:SetText(L.TUTORIAL_TITLE1)

	local string14 = app.EditPanel.Pages[0]:CreateFontString(nil, "ARTWORK", "Game13Font_o1")
	string14:SetPoint("TOPLEFT", string13, "BOTTOMLEFT", -3, -14)
	string14:SetText(L.TUTORIAL_WHAT)

	local string15 = app.EditPanel.Pages[0]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string15:SetJustifyH("LEFT")
	string15:SetPoint("TOPLEFT", string14, "BOTTOMLEFT", 3, -4)
	string15:SetText(L.TUTORIAL_WHAT1)

	local button1 = app:MakeButton(app.EditPanel.Pages[0], L.TUTORIAL_GETFLAGS)
	button1:SetPoint("TOPLEFT", string15, "BOTTOMLEFT", 0, -4)
	button1:SetScript("OnClick", function() StaticPopup_Show("WATCHTOWER_URL", nil, nil, "https://wago.io/browse/watchtower") end)

	app.EditPanel.Pages[1] = CreateFrame("Frame", nil, app.EditPanel.Options, nil)
	app.EditPanel.Pages[1]:SetAllPoints(app.EditPanel.Options)

	local leftEdge = 60

	local string1 = app.EditPanel.Pages[1]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string1:SetText(L.TITLE)
	string1:SetPoint("TOPLEFT", app.EditPanel.Pages[1], 10, -12)

	local backdrop1 = CreateFrame("Frame", nil, app.EditPanel.Pages[1], "BackdropTemplate")
	backdrop1:SetSize(200, 23)
	backdrop1:SetPoint("TOPLEFT", string1, "BOTTOMLEFT", 0, 0)
	backdrop1:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	backdrop1:SetBackdropColor(0.122, 0.122, 0.122, 0.8)

	app.EditPanel.Pages[1].Title = CreateFrame("EditBox", nil, backdrop1)
	app.EditPanel.Pages[1].Title:SetFontObject(Game12Font)
	app.EditPanel.Pages[1].Title:SetSize(backdrop1:GetWidth()-6, backdrop1:GetHeight())
	app.EditPanel.Pages[1].Title:SetPoint("TOPLEFT", backdrop1, 6, 0)
	app.EditPanel.Pages[1].Title:SetAutoFocus(false)
	app.EditPanel.Pages[1].Title:SetScript("OnEditFocusGained", function(self)
		self:HighlightText(0, 0)
	end)
	app.EditPanel.Pages[1].Title:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
	end)
	app.EditPanel.Pages[1].Title:SetScript("OnEscapePressed", function(self)
		self:SetText(app.FlagsList.Selected.title or "")
		self:ClearFocus()
	end)
	app.EditPanel.Pages[1].Title:SetScript("OnEditFocusLost", function(self)
		app.FlagsList.Selected.title = self:GetText()
		C_Timer.After(0.1, function() app:UpdateStatusList() end)
	end)

	local string2 = app.EditPanel.Pages[1]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string2:SetText(L.ICON)
	string2:SetPoint("TOPLEFT", string1, "TOPLEFT", 220, 0)

	local backdrop2 = CreateFrame("Frame", nil, app.EditPanel.Pages[1], "BackdropTemplate")
	backdrop2:SetSize(120, 23)
	backdrop2:SetPoint("TOPLEFT", string2, "BOTTOMLEFT", 0, 0)
	backdrop2:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	backdrop2:SetBackdropColor(0.122, 0.122, 0.122, 0.8)

	app.EditPanel.Pages[1].Icon = CreateFrame("EditBox", nil, backdrop2)
	app.EditPanel.Pages[1].Icon:SetFontObject(Game12Font)
	app.EditPanel.Pages[1].Icon:SetSize(backdrop2:GetWidth()-6, backdrop2:GetHeight())
	app.EditPanel.Pages[1].Icon:SetPoint("TOPLEFT", backdrop2, 6, 0)
	app.EditPanel.Pages[1].Icon:SetAutoFocus(false)
	app.EditPanel.Pages[1].Icon:SetScript("OnEditFocusGained", function(self)
		self:HighlightText(0, 0)
	end)
	app.EditPanel.Pages[1].Icon:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
	end)
	app.EditPanel.Pages[1].Icon:SetScript("OnEscapePressed", function(self)
		self:SetText(app.FlagsList.Selected.icon or "")
		self:ClearFocus()
	end)
	app.EditPanel.Pages[1].Icon:SetScript("OnEditFocusLost", function(self)
		app.FlagsList.Selected.icon = self:GetText()
		C_Timer.After(0.1, function() app:UpdateStatusList() end)
	end)
	app.EditPanel.Pages[1].Icon.Search = CreateFrame("Button", nil, app.EditPanel.Pages[1].Icon, nil)
	app.EditPanel.Pages[1].Icon.Search:SetSize(14, 14)
	app.EditPanel.Pages[1].Icon.Search:SetPoint("RIGHT", app.EditPanel.Pages[1].Icon, -6, 0)
	app.EditPanel.Pages[1].Icon.Search.Icon = app.EditPanel.Pages[1].Icon.Search:CreateTexture(nil, "BACKGROUND")
	app.EditPanel.Pages[1].Icon.Search.Icon:SetAtlas("common-search-magnifyingglass")
	app.EditPanel.Pages[1].Icon.Search.Icon:SetAllPoints()
	app.EditPanel.Pages[1].Icon.Search:SetAlpha(0.5)
	app.EditPanel.Pages[1].Icon.Search:SetScript("OnEnter", function()
		app.EditPanel.Pages[1].Icon.Search:SetAlpha(1.0)
	end)
	app.EditPanel.Pages[1].Icon.Search:SetScript("OnLeave", function()
		app.EditPanel.Pages[1].Icon.Search:SetAlpha(0.5)
	end)
	app.EditPanel.Pages[1].Icon.Search:SetScript("OnClick", function()
		app.EditPanel.Pages[1].Icon.Search:SetAlpha(0.5)
		LibIconPicker:Open(function(sel)
			app.FlagsList.Selected.icon = sel.icon
			app:UpdateStatusList()
		end, { icon = app.FlagsList.Selected.icon })
	end)

	local string3 = app.EditPanel.Pages[1]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string3:SetText(L.TRIGGER)
	string3:SetPoint("TOPLEFT", backdrop1, "BOTTOMLEFT", 0, -10)

	local backdrop3 = CreateFrame("Frame", nil, app.EditPanel.Pages[1], "BackdropTemplate")
	backdrop3:SetPoint("TOPLEFT", string3, "BOTTOMLEFT", 0, 0)
	backdrop3:SetPoint("BOTTOMLEFT", string3, "TOPLEFT", leftEdge, -131)
	backdrop3:SetPoint("BOTTOMRIGHT", app.EditPanel.Pages[1], "RIGHT", -10, 0)
	backdrop3:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	backdrop3:SetBackdropColor(0.122, 0.122, 0.122, 0.8)

	local scrollFrame1 = CreateFrame("ScrollFrame", nil, backdrop3, "ScrollFrameTemplate")
	scrollFrame1:SetPoint("TOPLEFT", 5, -5)
	scrollFrame1:SetPoint("BOTTOMRIGHT", -20, 4)
	scrollFrame1:SetScript("OnMouseDown", function()
		app.EditPanel.Pages[1].Trigger:SetFocus()
	end)

	scrollFrame1.ScrollBar.Back:Hide()
	scrollFrame1.ScrollBar.Forward:Hide()
	scrollFrame1.ScrollBar:ClearAllPoints()
	scrollFrame1.ScrollBar:SetPoint("TOP", scrollFrame1, 0, 16)
	scrollFrame1.ScrollBar:SetPoint("RIGHT", scrollFrame1, 12, 0)
	scrollFrame1.ScrollBar:SetPoint("BOTTOM", scrollFrame1, 0, -16)

	app.EditPanel.Pages[1].Trigger = CreateFrame("EditBox", nil, scrollFrame1)
	app.EditPanel.Pages[1].Trigger:SetFont("Interface\\AddOns\\Watchtower\\assets\\courbd.ttf", 14, "")
	app.EditPanel.Pages[1].Trigger:SetWidth(scrollFrame1:GetWidth())
	app.EditPanel.Pages[1].Trigger:SetPoint("TOPLEFT")
	app.EditPanel.Pages[1].Trigger:SetMultiLine(true)
	app.EditPanel.Pages[1].Trigger:SetTextColor(0.612, 0.863, 0.996, 1)
	scrollFrame1:SetScrollChild(app.EditPanel.Pages[1].Trigger)

	app.EditPanel.Pages[1].Trigger:SetAutoFocus(false)
	app.EditPanel.Pages[1].Trigger:SetScript("OnEscapePressed", function(self)
		self:SetText(app.FlagsList.Selected.trigger or "")
		self:ClearFocus()
	end)
	app.EditPanel.Pages[1].Trigger:SetScript("OnEditFocusLost", function(self)
		local old = app.FlagsList.Selected.trigger
		app.FlagsList.Selected.trigger = self:GetText():gsub("\n+$", "")
		if old ~= app.FlagsList.Selected.trigger then
			app.FlagsList.Selected.description = nil
		end

		if app.FlagsList.SelGroup ~= 1 then
			app:RegisterEvents(app.FlagsList.Selected)
		else
			app:IsTriggerValid(app.FlagsList.Selected, true)
		end
		C_Timer.After(0.1, function()
			app:SetSelected()
			app:UpdateStatusList()
		end)
	end)

	IndentationLib.enable(app.EditPanel.Pages[1].Trigger, nil, 3)

	app.EditPanel.Pages[1].Expand = CreateFrame("Button", "", app.EditPanel.Pages[1], "UIPanelCloseButton")
	app.EditPanel.Pages[1].Expand:SetPoint("BOTTOMRIGHT", backdrop3, "TOPRIGHT", 0, -3)
	app.EditPanel.Pages[1].Expand:SetSize(22, 23)
	app.EditPanel.Pages[1].Expand:SetNormalTexture("RedButton-Expand")
	app.EditPanel.Pages[1].Expand:SetDisabledTexture("RedButton-Expand-Disabled")
	app.EditPanel.Pages[1].Expand:SetPushedTexture("RedButton-Expand-Pressed")
	app.EditPanel.Pages[1].Expand:SetScript("OnClick", function() app.CodeBox:Show() end)

	app.CodeBox = CreateFrame("Frame", "Watchtower_CodeBox", UIParent, "DefaultPanelTemplate")
	app.CodeBox:SetFrameStrata("HIGH")
	app.CodeBox:SetSize(1000, 700)
	app.CodeBox:SetPoint("CENTER")
	app.CodeBox:EnableMouse(true)
	app.CodeBox:SetMovable(true)
	app.CodeBox:SetClampedToScreen(true)
	app.CodeBox:SetClampRectInsets(app.CodeBox:GetWidth()-inset, -(app.CodeBox:GetWidth()-inset), -(app.CodeBox:GetHeight()-inset), app.CodeBox:GetHeight()-inset)
	app.CodeBox:RegisterForDrag("LeftButton")
	app.CodeBox:SetScript("OnDragStart", function() app.CodeBox:StartMoving() end)
	app.CodeBox:SetScript("OnDragStop", function() app.CodeBox:StopMovingOrSizing() end)
	app.CodeBox:SetScript("OnShow", function()
		app.EditPanel.Pages[1].Expand:Hide()
		backdrop3:SetParent(app.CodeBox)
		backdrop3:ClearAllPoints()
		backdrop3:SetAllPoints("Watchtower_CodeBoxBg")
		app.EditPanel.Pages[1].Trigger:SetWidth(scrollFrame1:GetWidth())
	end)
	app.CodeBox:SetScript("OnHide", function()
		app.EditPanel.Pages[1].Expand:Show()
		backdrop3:SetParent(app.EditPanel.Pages[1])
		backdrop3:ClearAllPoints()
		backdrop3:SetPoint("TOPLEFT", string3, "BOTTOMLEFT", 0, 0)
		backdrop3:SetPoint("BOTTOMLEFT", string3, "TOPLEFT", leftEdge, -131)
		backdrop3:SetPoint("BOTTOMRIGHT", app.EditPanel.Pages[1], "RIGHT", -10, 0)
		app.EditPanel.Pages[1].Trigger:SetWidth(scrollFrame1:GetWidth())
	end)
	app.CodeBox:SetTitle(app.NameLong)
	app.CodeBox:Hide()

	app.CodeBox.CloseButton = CreateFrame("Button", nil, app.CodeBox, "UIPanelCloseButtonDefaultAnchors")
	app.CodeBox.CloseButton:SetNormalTexture("RedButton-Condense")
	app.CodeBox.CloseButton:SetDisabledTexture("RedButton-Condense-Disabled")
	app.CodeBox.CloseButton:SetPushedTexture("RedButton-Condense-Pressed")
	app.CodeBox.CloseButton:SetScript("OnClick", function()
		app.CodeBox:Hide()
	end)

	local string4 = app.EditPanel.Pages[1]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string4:SetText(L.EVENTS)
	string4:SetPoint("TOPLEFT", string3, "BOTTOMLEFT", 0, -130)

	local backdrop4 = CreateFrame("Frame", nil, app.EditPanel.Pages[1], "BackdropTemplate")
	backdrop4:SetPoint("TOPLEFT", string4, "BOTTOMLEFT", 0, 0)
	backdrop4:SetPoint("BOTTOMLEFT", string4, "TOPLEFT", leftEdge, -50)
	backdrop4:SetPoint("BOTTOMRIGHT", app.EditPanel.Pages[1], "RIGHT", -10, 0)
	backdrop4:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	backdrop4:SetBackdropColor(0.122, 0.122, 0.122, 0.8)

	local scrollFrame2 = CreateFrame("ScrollFrame", nil, backdrop4, "ScrollFrameTemplate")
	scrollFrame2:SetPoint("TOPLEFT", 5, -5)
	scrollFrame2:SetPoint("BOTTOMRIGHT", -20, 4)
	scrollFrame2:SetScript("OnMouseDown", function()
		app.EditPanel.Pages[1].Events:SetFocus()
	end)

	scrollFrame2.ScrollBar.Back:Hide()
	scrollFrame2.ScrollBar.Forward:Hide()
	scrollFrame2.ScrollBar:ClearAllPoints()
	scrollFrame2.ScrollBar:SetPoint("TOP", scrollFrame2, 0, 16)
	scrollFrame2.ScrollBar:SetPoint("RIGHT", scrollFrame2, 12, 0)
	scrollFrame2.ScrollBar:SetPoint("BOTTOM", scrollFrame2, 0, -16)

	app.EditPanel.Pages[1].Events = CreateFrame("EditBox", nil, scrollFrame2)
	app.EditPanel.Pages[1].Events:SetFont("Interface\\AddOns\\Watchtower\\assets\\courbd.ttf", 14, "")
	app.EditPanel.Pages[1].Events:SetWidth(scrollFrame2:GetWidth())
	app.EditPanel.Pages[1].Events:SetPoint("TOPLEFT")
	app.EditPanel.Pages[1].Events:SetMultiLine(true)
	app.EditPanel.Pages[1].Events:SetTextColor(0.612, 0.863, 0.996, 1)
	scrollFrame2:SetScrollChild(app.EditPanel.Pages[1].Events)

	app.EditPanel.Pages[1].Events:SetAutoFocus(false)
	app.EditPanel.Pages[1].Events:SetScript("OnEscapePressed", function(self)
		self:SetText(app:MakeCsvString(app.FlagsList.Selected.events or ""))
		self:ClearFocus()
	end)
	app.EditPanel.Pages[1].Events:SetScript("OnEditFocusLost", function(self)
		app.FlagsList.Selected.events = app:MakeCsvTable(self:GetText())
		if app.FlagsList.SelGroup ~= 1 then
			app:RegisterEvents(app.FlagsList.Selected)
		else
			app:IsTriggerValid(app.FlagsList.Selected, true)
		end
		C_Timer.After(0.1, function()
			app:SetSelected()
			app:UpdateStatusList()
		end)
	end)

	local string5 = app.EditPanel.Pages[1]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string5:SetText(L.DESCRIPTION)
	string5:SetPoint("TOPLEFT", backdrop4, "BOTTOMLEFT", 0, -10)

	local backdrop5 = CreateFrame("Frame", nil, app.EditPanel.Pages[1], "BackdropTemplate")
	backdrop5:SetPoint("TOPLEFT", string5, "BOTTOMLEFT", 0, 0)
	backdrop5:SetPoint("BOTTOMLEFT", string5, "TOPLEFT", leftEdge, -58)
	backdrop5:SetPoint("BOTTOMRIGHT", app.EditPanel.Pages[1], "RIGHT", -10, 0)
	backdrop5:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	backdrop5:SetBackdropColor(0.122, 0.122, 0.122, 0.8)

	local scrollFrame3 = CreateFrame("ScrollFrame", nil, backdrop5, "ScrollFrameTemplate")
	scrollFrame3:SetPoint("TOPLEFT", 5, -5)
	scrollFrame3:SetPoint("BOTTOMRIGHT", -20, 4)
	scrollFrame3:SetScript("OnMouseDown", function()
		app.EditPanel.Pages[1].Description:SetFocus()
	end)

	scrollFrame3.ScrollBar.Back:Hide()
	scrollFrame3.ScrollBar.Forward:Hide()
	scrollFrame3.ScrollBar:ClearAllPoints()
	scrollFrame3.ScrollBar:SetPoint("TOP", scrollFrame3, 0, 16)
	scrollFrame3.ScrollBar:SetPoint("RIGHT", scrollFrame3, 12, 0)
	scrollFrame3.ScrollBar:SetPoint("BOTTOM", scrollFrame3, 0, -16)

	app.EditPanel.Pages[1].Description = CreateFrame("EditBox", nil, scrollFrame3)
	app.EditPanel.Pages[1].Description:SetFontObject(Game12Font)
	app.EditPanel.Pages[1].Description:SetWidth(scrollFrame3:GetWidth())
	app.EditPanel.Pages[1].Description:SetPoint("TOPLEFT")
	app.EditPanel.Pages[1].Description:SetMultiLine(true)
	scrollFrame3:SetScrollChild(app.EditPanel.Pages[1].Description)

	app.EditPanel.Pages[1].Description:SetAutoFocus(false)
	app.EditPanel.Pages[1].Description:SetScript("OnEscapePressed", function(self)
		self:SetText(app.FlagsList.Selected.description or "")
		self:ClearFocus()
	end)
	app.EditPanel.Pages[1].Description:SetScript("OnEditFocusGained", function(self)
		self:HighlightText(0, 0)
	end)
	app.EditPanel.Pages[1].Description:SetScript("OnEditFocusLost", function(self)
		app.FlagsList.Selected.description = self:GetText()
		C_Timer.After(0.1, function() app:UpdateStatusList() end)
	end)

	local string6 = app.EditPanel.Pages[1]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string6:SetText(L.URL)
	string6:SetPoint("TOPLEFT", backdrop5, "BOTTOMLEFT", 0, -10)

	local backdrop6 = CreateFrame("Frame", nil, app.EditPanel.Pages[1], "BackdropTemplate")
	backdrop6:SetSize(300, 23)
	backdrop6:SetPoint("TOPLEFT", string6, "BOTTOMLEFT", 0, 0)
	backdrop6:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	backdrop6:SetBackdropColor(0.122, 0.122, 0.122, 0.8)

	app.EditPanel.Pages[1].URL = CreateFrame("EditBox", nil, backdrop6)
	app.EditPanel.Pages[1].URL:SetFontObject(Game12Font)
	app.EditPanel.Pages[1].URL:SetSize(backdrop6:GetWidth()-6, backdrop6:GetHeight())
	app.EditPanel.Pages[1].URL:SetPoint("TOPLEFT", backdrop6, 6, 0)
	app.EditPanel.Pages[1].URL:SetAutoFocus(false)
	app.EditPanel.Pages[1].URL:SetScript("OnEditFocusGained", function(self)
		self:HighlightText(0, 0)
	end)
	app.EditPanel.Pages[1].URL:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
	end)
	app.EditPanel.Pages[1].URL:SetScript("OnEscapePressed", function(self)
		self:SetText(app.FlagsList.Selected.url or "")
		self:ClearFocus()
	end)
	app.EditPanel.Pages[1].URL:SetScript("OnEditFocusLost", function(self)
		app.FlagsList.Selected.url = self:GetText()
		C_Timer.After(0.1, function() app:UpdateStatusList() end)
	end)

	local string7 = app.EditPanel.Pages[1]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string7:SetText(GAME_VERSION_LABEL)
	string7:SetPoint("TOPLEFT", string6, "TOPLEFT", 320, 0)

	local backdrop7 = CreateFrame("Frame", nil, app.EditPanel.Pages[1], "BackdropTemplate")
	backdrop7:SetSize(120, 23)
	backdrop7:SetPoint("TOPLEFT", string7, "BOTTOMLEFT", 0, 0)
	backdrop7:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	backdrop7:SetBackdropColor(0.122, 0.122, 0.122, 0.8)

	app.EditPanel.Pages[1].Version = CreateFrame("EditBox", nil, backdrop7)
	app.EditPanel.Pages[1].Version:SetFontObject(Game12Font)
	app.EditPanel.Pages[1].Version:SetSize(backdrop7:GetWidth()-6, backdrop7:GetHeight())
	app.EditPanel.Pages[1].Version:SetPoint("TOPLEFT", backdrop7, 6, 0)
	app.EditPanel.Pages[1].Version:SetAutoFocus(false)
	app.EditPanel.Pages[1].Version:SetScript("OnEditFocusGained", function(self)
		self:HighlightText(0, 0)
	end)
	app.EditPanel.Pages[1].Version:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
	end)
	app.EditPanel.Pages[1].Version:SetScript("OnEscapePressed", function(self)
		self:SetText(app.FlagsList.Selected.versionString or "")
		self:ClearFocus()
	end)
	app.EditPanel.Pages[1].Version:SetScript("OnEditFocusLost", function(self)
		app.FlagsList.Selected.versionString = self:GetText()
		C_Timer.After(0.1, function() app:UpdateStatusList() end)
	end)

	local function applyTemplate(templateID)
		app.FlagsList.Selected.title = L.FLAG_TEMPLATE[templateID].title
		app.FlagsList.Selected.icon = app.Templates[templateID].icon
		app.FlagsList.Selected.trigger = app.Templates[templateID].trigger
		app.FlagsList.Selected.events = app.Templates[templateID].events
		app.FlagsList.Selected.description = L.FLAG_TEMPLATE[templateID].description

		app:RegisterEvents(app.FlagsList.Selected)
		C_Timer.After(0.1, function()
			app:SetSelected()
			app:UpdateStatusList()
		end)
	end

	StaticPopupDialogs["WATCHTOWER_TEMPLATE"] = {
		text = L.OVERWRITE_FLAG,
		button1 = CONTINUE,
		button2 = CANCEL,
		whileDead = true,
		hideOnEscape = true,
		OnShow = function(dialog)
			dialog:ClearAllPoints()
			dialog:SetPoint("CENTER", UIParent)
		end,
		OnAccept = function(dialog, data) applyTemplate(data) end,
	}

	app.EditPanel.Pages[1].Templates = CreateFrame("DropdownButton", nil, app.EditPanel.Pages[1], "WowStyle1DropdownTemplate")
	app.EditPanel.Pages[1].Templates:SetWidth(100)
	app.EditPanel.Pages[1].Templates:SetPoint("TOPRIGHT", app.EditPanel.Pages[1], -10, -10)
	app.EditPanel.Pages[1].Templates:SetDefaultText(L.TEMPLATES)

	local templates = {}
	for i, entry in ipairs(app.Templates) do
		table.insert(templates, { L.FLAG_TEMPLATE[i].title, function() StaticPopup_Show("WATCHTOWER_TEMPLATE", nil, nil, i) end, i })
	end
	MenuUtil.CreateButtonMenu(app.EditPanel.Pages[1].Templates, unpack(templates))

	app.EditPanel.Pages[2] = CreateFrame("Frame", nil, app.EditPanel.Options, nil)
	app.EditPanel.Pages[2]:SetAllPoints(app.EditPanel.Options)

	local leftEdge = 60

	local string1 = app.EditPanel.Pages[2]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string1:SetText(L.TITLE)
	string1:SetPoint("TOPLEFT", app.EditPanel.Pages[2], 10, -16)

	app.EditPanel.Pages[2].TitleBackdrop = CreateFrame("Frame", nil, app.EditPanel.Pages[2], "BackdropTemplate")
	app.EditPanel.Pages[2].TitleBackdrop:SetSize(200, 23)
	app.EditPanel.Pages[2].TitleBackdrop:SetPoint("LEFT", string1, "LEFT", leftEdge, 0)
	app.EditPanel.Pages[2].TitleBackdrop:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	app.EditPanel.Pages[2].TitleBackdrop:SetBackdropColor(0.122, 0.122, 0.122, 0.8)

	app.EditPanel.Pages[2].Title = CreateFrame("EditBox", nil, app.EditPanel.Pages[2].TitleBackdrop)
	app.EditPanel.Pages[2].Title:SetFontObject(Game12Font)
	app.EditPanel.Pages[2].Title:SetSize(app.EditPanel.Pages[2].TitleBackdrop :GetWidth()-6, app.EditPanel.Pages[2].TitleBackdrop:GetHeight())
	app.EditPanel.Pages[2].Title:SetPoint("TOPLEFT", app.EditPanel.Pages[2].TitleBackdrop, 6, 0)
	app.EditPanel.Pages[2].Title:SetAutoFocus(false)
	app.EditPanel.Pages[2].Title:SetScript("OnEditFocusGained", function(self)
		self:HighlightText(0, 0)
	end)
	app.EditPanel.Pages[2].Title:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
	end)
	app.EditPanel.Pages[2].Title:SetScript("OnEscapePressed", function(self)
		self:SetText(app.FlagsList.Selected.title or "")
		self:ClearFocus()
	end)
	app.EditPanel.Pages[2].Title:SetScript("OnEditFocusLost", function(self)
		app.FlagsList.Selected.title = self:GetText()
		C_Timer.After(0.1, function() app:UpdateStatusList() end)
	end)

	local string2 = app.EditPanel.Pages[2]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string2:SetText(L.STYLE)
	string2:SetPoint("TOPLEFT", string1, "BOTTOMLEFT", 0, -20)

	local function setStyle(value)
		app.FlagsList.Selected.style = value
		app:UpdateStatusList()
	end

	app.EditPanel.Pages[2].Style = CreateFrame("DropdownButton", nil, app.EditPanel.Pages[2], "WowStyle1DropdownTemplate")
	app.EditPanel.Pages[2].Style:SetDefaultText(L.GROUP_STYLE[1])
	app.EditPanel.Pages[2].Style:SetWidth(196)
	app.EditPanel.Pages[2].Style:SetPoint("LEFT", string2, leftEdge + 2, 0)
	local dropdown = app.EditPanel.Pages[2].Style
	app.EditPanel.Pages[2].Style:SetupMenu(function(dropdown, root)
		for i, style in ipairs(L.GROUP_STYLE) do
			local radio = root:CreateRadio(style, function()
				if app.FlagsList.Selected then
					return L.GROUP_STYLE[app.FlagsList.Selected.style] == style
				end
			end,
			function()
				app.FlagsList.Selected.style = i
				app:SetSelected()
			end)
		end
	end)

	local string3 = app.EditPanel.Pages[2]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string3:SetText(L.ANCHOR)
	string3:SetPoint("TOPLEFT", string2, "BOTTOMLEFT", 0, -20)

	local function setAnchor(value)
		app.FlagsList.Selected.anchor = value
		app:UpdateStatusList()
	end

	app.EditPanel.Pages[2].Anchor = CreateFrame("DropdownButton", nil, app.EditPanel.Pages[2], "WowStyle1DropdownTemplate")
	app.EditPanel.Pages[2].Anchor:SetDefaultText(L.GROUP_ANCHOR[1])
	app.EditPanel.Pages[2].Anchor:SetWidth(196)
	app.EditPanel.Pages[2].Anchor:SetPoint("LEFT", string3, leftEdge + 2, 0)
	local dropdown = app.EditPanel.Pages[2].Anchor
	app.EditPanel.Pages[2].Anchor:SetupMenu(function(dropdown, root)
		for i, anchor in ipairs(L.GROUP_ANCHOR) do
			local radio = root:CreateRadio(anchor, function()
				if app.FlagsList.Selected then
					return L.GROUP_ANCHOR[app.FlagsList.Selected.anchor] == anchor
				end
			end,
			function()
				app.FlagsList.Selected.anchor = i
				app:SetSelected()
				app:UpdateTracker(app.FlagsList.SelGroup)
			end)
		end
	end)

	local string4 = app.EditPanel.Pages[2]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string4:SetText(L.FONT)
	string4:SetPoint("TOPLEFT", string3, "BOTTOMLEFT", 0, -20)

	local LSM = LibStub("LibSharedMedia-3.0")
	app.Fonts = {}
	for _, handle in ipairs(LSM:List("font")) do
		table.insert(app.Fonts, { name = handle, path = LSM:Fetch("font", handle) })
	end

	local FontObjects = {}
	for _, font in ipairs(app.Fonts) do
		local fo = CreateFont("WatchtowerFont_" .. font.name)
		fo:SetFont(font.path, 13, "")
		FontObjects[font.path] = fo
	end

	app.EditPanel.Pages[2].Font = CreateFrame("DropdownButton", nil, app.EditPanel.Pages[2], "WowStyle1DropdownTemplate")
	app.EditPanel.Pages[2].Font:SetWidth(196)
	app.EditPanel.Pages[2].Font:SetPoint("LEFT", string4, leftEdge + 2, 0)
	local dropdown = app.EditPanel.Pages[2].Font
	app.EditPanel.Pages[2].Font:SetupMenu(function(dropdown, root)
		for _, font in ipairs(app.Fonts) do
			local radio = root:CreateRadio(font.name, function()
				if app.FlagsList.Selected then
					return app.FlagsList.Selected.font == font.name
				end
			end,
			function()
				app.FlagsList.Selected.font = font.name
				app:SetSelected()
				app:UpdateTracker(app.FlagsList.SelGroup)
			end)

			radio:AddInitializer(function(button)
				button.fontString:SetFontObject(FontObjects[font.path])
			end)
		end
	end)

	local string5 = app.EditPanel.Pages[2]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string5:SetText(L.SCALE)
	string5:SetPoint("TOPLEFT", string4, "BOTTOMLEFT", 0, -20)

	local min, max, increment = 50, 200, 5
	local options = Settings.CreateSliderOptions(min, max, increment)
	--options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Top, "Scale")
	--options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Left, value)
	options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value) return value .. "%" end)
	options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Max, max)
	options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Min, min)

	app.EditPanel.Pages[2].Scale = CreateFrame("Frame", nil, app.EditPanel.Pages[2], "MinimalSliderWithSteppersTemplate")
	app.EditPanel.Pages[2].Scale:SetWidth(204)
	app.EditPanel.Pages[2].Scale:SetPoint("LEFT", string5, leftEdge - 2, -2)
	app.EditPanel.Pages[2].Scale:Init(100, options.minValue, options.maxValue, options.steps, options.formatters)
	app.EditPanel.Pages[2].Scale:RegisterCallback("OnValueChanged", function(self, value)
		app.FlagsList.Selected.scale = value
		if app.Tracker[app.FlagsList.SelGroup] then
			app:ShowTracker(app.FlagsList.SelGroup)
		end
	end)

	PanelTemplates_SetTab(app.EditPanel.Options, 1)
	PanelTemplates_UpdateTabs(app.EditPanel.Options)

	app.FlagsList.SelGroup = 1
	app.FlagsList.SelFlag = 0
	app:SetSelected()
	app:UpdateStatusList()
end

function app:SetSelected()
	if app.FlagsList.SelFlag == 0 then
		app.FlagsList.Selected = Watchtower_Flags[app.FlagsList.SelGroup]
	else
		app.FlagsList.Selected = Watchtower_Flags[app.FlagsList.SelGroup].flags[app.FlagsList.SelFlag]
	end
	if app.FlagsList.SelGroup == 1 and app.FlagsList.SelFlag == 0 then
		app.EditPanel.DeleteButton:Disable()
		app.EditPanel.ExportButton:Disable()
	else
		app.EditPanel.DeleteButton:Enable()
		app.EditPanel.ExportButton:Enable()
	end

	if app.FlagsList.Selected.icon then
		app.EditPanel.Pages[0]:Hide()
		app.EditPanel.Pages[1]:Show()
		app.EditPanel.Pages[2]:Hide()

		app.EditPanel.DeleteButton:SetText(L.DELETE_FLAG)
		app.EditPanel.DeleteButton:SetWidth(app.EditPanel.DeleteButton:GetTextWidth()+20)
		app.EditPanel.ExportButton:SetText(L.EXPORT_FLAG)
		app.EditPanel.ExportButton:SetWidth(app.EditPanel.ExportButton:GetTextWidth()+20)

		app.EditPanel.Pages[1].Title:SetText(app.FlagsList.Selected.title or "")
		app.EditPanel.Pages[1].Icon:SetText(app.FlagsList.Selected.icon or "")
		app.EditPanel.Pages[1].Trigger:SetText(app.FlagsList.Selected.trigger or "")
		app.EditPanel.Pages[1].Events:SetText(app:MakeCsvString(app.FlagsList.Selected.events or ""))
		app.EditPanel.Pages[1].Description:SetText(app.FlagsList.Selected.description or "")
	else
		app.EditPanel.DeleteButton:SetText(L.DELETE_GROUP)
		app.EditPanel.DeleteButton:SetWidth(app.EditPanel.DeleteButton:GetTextWidth()+20)
		app.EditPanel.ExportButton:SetText(L.EXPORT_GROUP)
		app.EditPanel.ExportButton:SetWidth(app.EditPanel.ExportButton:GetTextWidth()+20)

		if app.FlagsList.SelGroup == 1 then
			app.EditPanel.Pages[0]:Show()
			app.EditPanel.Pages[1]:Hide()
			app.EditPanel.Pages[2]:Hide()
		else
			app.EditPanel.Pages[0]:Hide()
			app.EditPanel.Pages[1]:Hide()
			app.EditPanel.Pages[2]:Show()

			app.EditPanel.Pages[2].Title:SetText(app.FlagsList.Selected.title or "")
			app.EditPanel.Pages[2].Style:OverrideText(L.GROUP_STYLE[app.FlagsList.Selected.style])
			app.EditPanel.Pages[2].Anchor:OverrideText(L.GROUP_ANCHOR[app.FlagsList.Selected.anchor])
			app.EditPanel.Pages[2].Font:OverrideText(app.FlagsList.Selected.font)
			app.EditPanel.Pages[2].Scale:SetValue(app.FlagsList.Selected.scale)

			for _, font in ipairs(app.Fonts) do
				if font.name == app.FlagsList.Selected.font then
					app.EditPanel.Pages[2].Font.Text:SetFont(font.path, 13, "")
					break
				end
			end
		end
	end
end

function app:ReIndexTable(tbl)
	table.sort(tbl, function(a, b)
		if a and b then
			if a.flagID then
				return a.flagID < b.flagID
			elseif a.groupID then
				return a.groupID < b.groupID
			end
		end
	end)

	for i, entry in ipairs(tbl) do
		if entry.flagID then
			entry.flagID = i
		elseif entry.groupID then
			entry.groupID = i
		end
	end

	app:UpdateStatusList()
end

function app:MoveTableEntry(old, target)
	if target.groupID == 1 then
		app:DeRegisterEvents(Watchtower_Flags[old.groupID].flags[old.flagID])
	elseif old.groupID == 1 then
		app:RegisterEvents(Watchtower_Flags[old.groupID].flags[old.flagID])
	end

	app.FlagsList.SelGroup = target.groupID
	if old.flagID == 0 then
		app.FlagsList.SelFlag = 0
		Watchtower_Flags[old.groupID].groupID = target.groupID + 0.5
		app:ReIndexTable(Watchtower_Flags)
	elseif old.groupID == target.groupID then
		app.FlagsList.SelFlag = target.flagID
		Watchtower_Flags[old.groupID].flags[old.flagID].flagID = target.flagID + 0.5
		app:ReIndexTable(Watchtower_Flags[old.groupID].flags)
	else
		app.FlagsList.SelFlag = target.flagID + 1
		local flag = table.remove(Watchtower_Flags[old.groupID].flags, old.flagID)
		table.insert(Watchtower_Flags[target.groupID].flags, flag)
		Watchtower_Flags[target.groupID].flags[#Watchtower_Flags[target.groupID].flags].flagID = target.flagID + 0.5
		app:ReIndexTable(Watchtower_Flags[old.groupID].flags)
		app:ReIndexTable(Watchtower_Flags[target.groupID].flags)
	end

	for i = 2, #Watchtower_Flags do
		app:ShowTracker(i)
	end
end

function app:MakeCsvTable(str)
	local f = CreateFrame("Frame")
	local function doesEventExist(event)
		if type(event) ~= "string" or event == "" then
			return false, L.ERROR_UNKNOWN_EVENT .. " " .. event
		end

		local exists, error = pcall(f.RegisterEvent, f, event)
		if not exists then
			return false, error
		end

		return true
	end

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

function app:UpdateStatusList()
	local DataProvider = CreateTreeDataProvider()

	for gID, group in ipairs(Watchtower_Flags) do
		local groupNode = DataProvider:Insert({ groupID = group.groupID, flagID = 0, title = group.title })
		if group.collapsed then groupNode:ToggleCollapsed() end
		for fID, flag in ipairs (Watchtower_Flags[gID].flags) do
			groupNode:Insert({ groupID = group.groupID, flagID = flag.flagID, icon = flag.icon, title = flag.title })
		end
	end

	app.FlagsList:SetDataProvider(DataProvider, true)
	app:SetSelected()
	app:UpdateAllTrackers()
end
