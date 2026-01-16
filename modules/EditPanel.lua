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
		table.insert(Watchtower_Flags[app.FlagsList.SelGroup].flags, { flagID = #Watchtower_Flags[app.FlagsList.SelGroup].flags + 1, title = "New Flag", icon = 134400, trigger = "return true", events = { "PLAYER_ENTERING_WORLD" }, lastResult = true })
		app.FlagsList.SelFlag = #Watchtower_Flags[app.FlagsList.SelGroup].flags
		app:SetSelected()
		app:UpdateStatusList()
	end

	local function delete()
		local function deleteFlag()
			app:DeRegisterEvents(app.FlagsList.Selected)
			table.remove(Watchtower_Flags[app.FlagsList.SelGroup].flags, app.FlagsList.SelFlag)
			app.FlagsList.SelFlag = app.FlagsList.SelFlag - 1
			app:SetSelected()
			app:ReIndexTable(Watchtower_Flags[app.FlagsList.SelGroup].flags)
		end

		local function deleteGroup()
			table.remove(Watchtower_Flags, app.FlagsList.SelGroup)
			app.FlagsList.SelGroup = app.FlagsList.SelGroup - 1
			app.FlagsList.SelFlag = 0
			app:SetSelected()
			app:ReIndexTable(Watchtower_Flags)
		end

		StaticPopupDialogs["WATCHTOWER_DELETEFLAG"] = {
			text = "Delete this flag?" .. "\n" .. "(Hold Shift to skip this confirmation.)",
			button1 = YES,
			button2 = NO,
			whileDead = true,
			hideOnEscape = true,
			OnShow = function(dialog)
				dialog:ClearAllPoints()
				dialog:SetPoint("CENTER", UIParent)
			end,
			OnAccept = deleteFlag,
		}
		StaticPopupDialogs["WATCHTOWER_DELETEGROUP"] = {
			text = "Delete this group?" .. "\n" .. "(Hold Shift to skip this confirmation.)",
			button1 = YES,
			button2 = NO,
			whileDead = true,
			hideOnEscape = true,
			OnShow = function(dialog)
				dialog:ClearAllPoints()
				dialog:SetPoint("CENTER", UIParent)
			end,
			OnAccept = deleteGroup,
		}
		StaticPopupDialogs["WATCHTOWER_CANTDELETE"] = {
			text = "Can't delete a group with flags.",
			button1 = OKAY,
			whileDead = true,
			hideOnEscape = true,
			OnShow = function(dialog)
				dialog:ClearAllPoints()
				dialog:SetPoint("CENTER", UIParent)
			end,
		}

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
		table.insert(Watchtower_Flags, { groupID = #Watchtower_Flags + 1, title = "New Group", flags = {} })
		app.FlagsList.SelGroup = #Watchtower_Flags
		app.FlagsList.SelFlag = 0
		app:SetSelected()
		app:UpdateStatusList()
	end

	local function import()
	end

	local function export()
	end

	app.EditPanel.NewFlagButton = app:MakeButton(app.EditPanel, "New Flag")
	app.EditPanel.NewFlagButton:SetPoint("BOTTOMRIGHT", app.EditPanel.StatusList, "TOPRIGHT", 0, 2)
	app.EditPanel.NewFlagButton:SetScript("OnClick", newFlag)

	app.EditPanel.NewGroupButton = app:MakeButton(app.EditPanel, "New Group")
	app.EditPanel.NewGroupButton:SetPoint("TOPRIGHT", app.EditPanel.NewFlagButton, "TOPLEFT", -2, 0)
	app.EditPanel.NewGroupButton:SetScript("OnClick", newGroup)

	app.EditPanel.DeleteButton = app:MakeButton(app.EditPanel, "Delete")
	app.EditPanel.DeleteButton:SetPoint("TOP", app.EditPanel.NewFlagButton)
	app.EditPanel.DeleteButton:SetPoint("RIGHT", app.EditPanel, -6, 0)
	app.EditPanel.DeleteButton:SetScript("OnClick", delete)

	app.EditPanel.ExportButton = app:MakeButton(app.EditPanel, "Export")
	app.EditPanel.ExportButton:SetPoint("TOPRIGHT", app.EditPanel.DeleteButton, "TOPLEFT", -2, 0)
	app.EditPanel.ExportButton:SetScript("OnClick", export)
	app.EditPanel.ExportButton:Disable()

	app.EditPanel.ImportButton = app:MakeButton(app.EditPanel, "Import")
	app.EditPanel.ImportButton:SetPoint("TOPRIGHT", app.EditPanel.ExportButton, "TOPLEFT", -2, 0)
	app.EditPanel.ImportButton:SetScript("OnClick", import)
	app.EditPanel.ImportButton:Disable()

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

		if app.FlagsList.SelGroup == data.groupID and app.FlagsList.SelFlag == data.flagID then
			listItem.LeftText2:SetText("|cffFFFFFF" .. data.title)
			listItem.Highlight:Show()
		end

		listItem:EnableMouse(true)
		listItem:RegisterForDrag("LeftButton")
		listItem:SetScript("OnDragStart", function(self)
			if data.groupID == 1 and data.flagID == 0 then
				app:Print("Can't move this group")
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

			if not ({ groupID = data.groupID, flagID = data.flagID } == app.Flag.Hover) then
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

	app.EditPanel.Pages[1] = CreateFrame("Frame", nil, app.EditPanel.Options, nil)
	app.EditPanel.Pages[1]:SetAllPoints(app.EditPanel.Options)

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

	app.EditPanel.Pages[1].Title = CreateFrame("EditBox", nil, backdrop)
	app.EditPanel.Pages[1].Title:SetFontObject(ChatFontNormal)
	app.EditPanel.Pages[1].Title:SetSize(backdrop:GetWidth()-6, backdrop:GetHeight())
	app.EditPanel.Pages[1].Title:SetPoint("TOPLEFT", backdrop, 6, 0)
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

	app.EditPanel.Pages[1].Icon = CreateFrame("EditBox", nil, backdrop)
	app.EditPanel.Pages[1].Icon:SetFontObject(ChatFontNormal)
	app.EditPanel.Pages[1].Icon:SetSize(backdrop:GetWidth()-6, backdrop:GetHeight())
	app.EditPanel.Pages[1].Icon:SetPoint("TOPLEFT", backdrop, 6, 0)
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
		app:UpdateStatusList()
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
	string3:SetText("Trigger")
	string3:SetPoint("TOPLEFT", string2, "BOTTOMLEFT", 0, -20)

	local backdrop = CreateFrame("Frame", nil, app.EditPanel.Pages[1], "BackdropTemplate")
	backdrop:SetPoint("TOPLEFT", string3, "TOPLEFT", leftEdge, 0)
	backdrop:SetPoint("BOTTOMLEFT", string3, "TOPLEFT", leftEdge, -118)
	backdrop:SetPoint("BOTTOMRIGHT", app.EditPanel.Pages[1], "RIGHT", -10, 0)
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
		app.EditPanel.Pages[1].Trigger:SetFocus()
	end)

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
		app.FlagsList.Selected.trigger = self:GetText():gsub("\n+$", "")
		app:RegisterEvents(app.FlagsList.Selected)
		app:UpdateStatusList()
	end)

	IndentationLib.enable(app.EditPanel.Pages[1].Trigger, nil, 3)

	app.EditPanel.TestButton = app:MakeButton(app.EditPanel.Pages[1], "Test")
	app.EditPanel.TestButton:SetPoint("TOPLEFT", string3, "BOTTOMLEFT", -2, -6)
	app.EditPanel.TestButton:SetScript("OnClick", function()
		app.FlagsList.Selected.lastResult = app:TestTrigger(app.FlagsList.Selected)
		app:UpdateStatusTracker()
	end)

	local string4 = app.EditPanel.Pages[1]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string4:SetText("Events")
	string4:SetPoint("TOPLEFT", string3, "BOTTOMLEFT", 0, -120)

	local backdrop = CreateFrame("Frame", nil, app.EditPanel.Pages[1], "BackdropTemplate")
	backdrop:SetPoint("TOPLEFT", string4, "TOPLEFT", leftEdge, 0)
	backdrop:SetPoint("BOTTOMLEFT", string4, "TOPLEFT", leftEdge, -36)
	backdrop:SetPoint("BOTTOMRIGHT", app.EditPanel.Pages[1], "RIGHT", -10, 0)
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
		app.EditPanel.Pages[1].Events:SetFocus()
	end)

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
		app:RegisterEvents(app.FlagsList.Selected)
		app:UpdateStatusList()
	end)

	app.EditPanel.Pages[2] = CreateFrame("Frame", nil, app.EditPanel.Options, nil)
	app.EditPanel.Pages[2]:SetAllPoints(app.EditPanel.Options)

	local leftEdge = 60

	local string1 = app.EditPanel.Pages[2]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string1:SetText("Title")
	string1:SetPoint("TOPLEFT", app.EditPanel.Pages[2], 10, -20)

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
	app.EditPanel.Pages[2].Title:SetFontObject(ChatFontNormal)
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
		app:UpdateStatusList()
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
	else
		app.EditPanel.DeleteButton:Enable()
	end

	if app.FlagsList.Selected.icon then
		app.EditPanel.Pages[1]:Show()
		app.EditPanel.Pages[2]:Hide()

		app.EditPanel.DeleteButton:SetText("Delete Flag")
		app.EditPanel.DeleteButton:SetWidth(app.EditPanel.DeleteButton:GetTextWidth()+20)

		app.EditPanel.Pages[1].Title:SetText(app.FlagsList.Selected.title or "")
		app.EditPanel.Pages[1].Icon:SetText(app.FlagsList.Selected.icon or "")
		app.EditPanel.Pages[1].Trigger:SetText(app.FlagsList.Selected.trigger or "")
		app.EditPanel.Pages[1].Events:SetText(app:MakeCsvString(app.FlagsList.Selected.events or ""))
	else
		app.EditPanel.Pages[1]:Hide()
		app.EditPanel.Pages[2]:Show()

		app.EditPanel.DeleteButton:SetText("Delete Group")
		app.EditPanel.DeleteButton:SetWidth(app.EditPanel.DeleteButton:GetTextWidth()+20)

		if app.FlagsList.SelGroup == 1 then
			app.EditPanel.Pages[2].Title:Disable()
			app.EditPanel.Pages[2].Title:SetText("|cff9d9d9d" .. (app.FlagsList.Selected.title or ""))
			app.EditPanel.Pages[2].TitleBackdrop:SetBackdropBorderColor(0.7, 0.7, 0.7, 1)
		else
			app.EditPanel.Pages[2].Title:Enable()
			app.EditPanel.Pages[2].Title:SetText(app.FlagsList.Selected.title or "")
			app.EditPanel.Pages[2].TitleBackdrop:SetBackdropBorderColor(1, 1, 1, 1)
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
end

function app:MakeCsvTable(str)
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
	C_Timer.After(0.1, function()	-- Prevent clicks from editbox to scrollview from disappearing
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
		if app.ScrollView then app:UpdateStatusTracker() end
	end)
end

function app:CreateTriggerEnv()	-- Vibecoded, feedback appreciated
	local env = {}

	local safeG = setmetatable({}, {
		__index = function(_, key)
			if app.Blocked[key] then
				error(("Access to \"%s\" is blocked"):format(tostring(key)), 2)
			end
			return _G[key]
		end,
			__newindex = function(_, key, value)
			if app.Blocked[key] then
				error(("Assignment to \"%s\" is blocked"):format(tostring(key)), 2)
			end
			_G[key] = value
		end,
	})
	env._G = safeG

	setmetatable(env, {
		__index = function(tbl, key)
			if app.Blocked[key] then
				error(("Access to \"%s\" is blocked"):format(tostring(key)), 2)
			end
			local v = rawget(tbl, key)
			if v ~= nil then return v end
			return _G[key]
		end,
		__newindex = function(tbl, key, value)
			if app.Blocked[key] then
				error(("Assignment to \"%s\" is blocked"):format(tostring(key)), 2)
			end
			rawset(tbl, key, value)
		end,
	})

	return env
end

function app:TestTrigger(flag)
	if not flag.trigger then
		app:Print("There is no code to test.")
		return false
	end

	local func, error = loadstring(flag.trigger)
	if error then
		app:Print("There is an error in your trigger code:")
		DevTools_Dump(error)
		return false
	end

	local env = app:CreateTriggerEnv()
	setfenv(func, env)

	local ok, result = pcall(func)
	if not ok then
		app:Print("There is an error in your trigger code:")
		app:Print(result)
		return false
	end

	app:Print("No syntax errors found in your trigger. :)")

	return result
end

function app:DeRegisterEvents(flag)
	if flag.handles then
		for _, handle in ipairs(flag.handles) do
			app.Event:Unregister(handle)
		end
	end
	flag.handles = {}
end

function app:RegisterEvents(flag)
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
					--RunNextFrame(function() app:UpdateStatusTracker() end)
				end

				local handle = app.Event:Register(event, wrapper)
				table.insert(flag.handles, handle)
			end
		end
	end

	if flag then
		app:DeRegisterEvents(flag)
		handleEvents(flag)
	else
		for _, header in ipairs(Watchtower_Flags) do
			for _, flg in ipairs(header) do
				app:DeRegisterEvents(flg)
				handleEvents(flg)
			end
		end
	end
end
