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
	--app.EditPanel:Hide()

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

	local function makeNew()
		table.insert(app.Table, { id = #app.Table + 1, text = "New Flag", icon = 134400 })
		app.ScrollView2.Selection = #app.Table
		app:UpdateStatusList()
	end

	app.EditPanel.MakeNewButton = app:MakeButton(app.EditPanel, "New Flag")
	app.EditPanel.MakeNewButton:SetPoint("BOTTOMRIGHT", app.EditPanel.StatusList, "TOPRIGHT", 0, 2)
	app.EditPanel.MakeNewButton:SetScript("OnClick", makeNew)

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

	local function reIndexTable(tbl)
		table.sort(tbl, function(a, b)
			return a.id < b.id
		end)

		for i, entry in ipairs(tbl) do
			entry.id = i
		end

		app:UpdateStatusList()
	end

	local function moveTableEntry(tbl, oldIndex, targetIndex)
		tbl[oldIndex].id = targetIndex + 0.5
		reIndexTable(tbl)
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
			listItem.Highlight:SetAllPoints()  -- usually needed to cover the button
			listItem.Highlight:SetBlendMode("ADD") -- optional, matches Blizzard glow style
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
				moveTableEntry(app.Table, data.id, app.Flag.Hover)
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
				if not(data.id == #app.Table and app.Flag.Hover == #app.Table) then
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

	-------------------------------------------------------------

	app.EditPanel.Options = CreateFrame("Frame", nil, app.EditPanel, "NineSlicePanelTemplate")
	app.EditPanel.Options:SetPoint("TOPLEFT", app.EditPanel.StatusList, "TOPRIGHT", 4, 0)
	app.EditPanel.Options:SetPoint("BOTTOMRIGHT", app.EditPanel, -6, 9)
	app.EditPanel.Options.Background = app.EditPanel.Options:CreateTexture(nil, "BACKGROUND")
	app.EditPanel.Options.Background:SetAtlas("thewarwithin-landingpage-background")
	app.EditPanel.Options.Background:SetAllPoints()
	NineSliceUtil.ApplyLayoutByName(app.EditPanel.Options, "InsetFrameTemplate")

	app.EditPanel.Options.Tabs = {}
	app.EditPanel.Options.numTabs = 0

	local function createTab(label)
		app.EditPanel.Options.numTabs = app.EditPanel.Options.numTabs + 1

		local tab = CreateFrame("Button", nil, app.EditPanel.Options, "PanelTopTabButtonTemplate")
		tab:SetText(label)
		tab:SetID(app.EditPanel.Options.numTabs)

		if app.EditPanel.Options.numTabs == 1 then
			tab:SetPoint("BOTTOMLEFT", app.EditPanel.Options, "TOPLEFT", 10, -3)
		else
			tab:SetPoint("LEFT", app.EditPanel.Options.Tabs[app.EditPanel.Options.numTabs - 1], "RIGHT", -15, 0)
		end

		app.EditPanel.Options.Tabs[app.EditPanel.Options.numTabs] = tab
		PanelTemplates_SetNumTabs(app.EditPanel.Options, app.EditPanel.Options.numTabs)

		tab:SetScript("OnClick", function()
			PanelTemplates_SetTab(app.EditPanel.Options, tab:GetID())
			for tabName, frame in pairs (app.EditPanel.Page) do
				if tabName == label then
					frame:Show()
				else
					frame:Hide()
				end
			end
		end)

		return tab
	end

	local tab1 = createTab("General")
	local tab2 = createTab("Advanced")

	PanelTemplates_SetTab(app.EditPanel.Options, 1)
	PanelTemplates_UpdateTabs(app.EditPanel.Options)

	------------------------

	app.EditPanel.Page = {}
	app.EditPanel.Page["General"] = CreateFrame("Frame", nil, app.EditPanel.Options, nil)
	app.EditPanel.Page["General"]:SetAllPoints(app.EditPanel.Options)
	app.EditPanel.Page["General"]:Show()

	local string1 = app.EditPanel.Page["General"]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string1:SetText("Title")
	string1:SetPoint("TOPLEFT", app.EditPanel.Page["General"], 10, -20)
	app.EditPanel.Options.Title = CreateFrame("EditBox", nil, app.EditPanel.Page["General"], "InputBoxTemplate")
	app.EditPanel.Options.Title:SetSize(80,20)
	app.EditPanel.Options.Title:SetPoint("LEFT", string1, "RIGHT", 20, 0)

	app.EditPanel.Options.Title:SetAutoFocus(false)
	app.EditPanel.Options.Title:SetAutoFocus(false)
	app.EditPanel.Options.Title:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
	end)
	app.EditPanel.Options.Title:SetScript("OnEscapePressed", function(self)
		self:SetText(app.Table[app.ScrollView2.Selection].text or "")
		self:ClearFocus()
	end)
	app.EditPanel.Options.Title:SetScript("OnEditFocusLost", function(self)
		app.Table[app.ScrollView2.Selection].text = self:GetText()
		app:UpdateStatusList()
	end)

	local string2 = app.EditPanel.Page["General"]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	string2:SetText("Icon")
	string2:SetPoint("TOPLEFT", string1, "BOTTOMLEFT", 0, -20)
	app.EditPanel.Options.Icon = CreateFrame("EditBox", nil, app.EditPanel.Page["General"], "InputBoxTemplate")
	app.EditPanel.Options.Icon:SetSize(80,20)
	app.EditPanel.Options.Icon:SetPoint("LEFT", string2, "RIGHT", 20, 0)

	app.EditPanel.Options.Icon:SetAutoFocus(false)
	app.EditPanel.Options.Icon:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
	end)
	app.EditPanel.Options.Icon:SetScript("OnEscapePressed", function(self)
		self:SetText(app.Table[app.ScrollView2.Selection].icon or "")
		self:ClearFocus()
	end)
	app.EditPanel.Options.Icon:SetScript("OnEditFocusLost", function(self)
		app.Table[app.ScrollView2.Selection].icon = self:GetText()
		app:UpdateStatusList()
	end)

	app.EditPanel.DeleteButton = app:MakeButton(app.EditPanel.Page["General"], "Delete")
	app.EditPanel.DeleteButton:SetPoint("TOPRIGHT", app.EditPanel.Page["General"], -10, -10)
	app.EditPanel.DeleteButton:SetScript("OnClick", function()
		-- TODO: confirm dialog
		table.remove(app.Table, app.ScrollView2.Selection)
		reIndexTable(app.Table)
		app.ScrollView2.Selection = max(1, app.ScrollView2.Selection - 1)
		if #app.Table == 0 then
			makeNew()
		else
			app:UpdateStatusList()
		end
	end)

	app.EditPanel.Page["Advanced"] = CreateFrame("Frame", nil, app.EditPanel.Options, nil)
	app.EditPanel.Page["Advanced"]:SetAllPoints(app.EditPanel.Options)
	app.EditPanel.Page["Advanced"]:Hide()

	---

	app.ScrollView2.Selection = 1
	app:UpdateStatusList()
end

function app:UpdateStatusList()
	local DataProvider = CreateTreeDataProvider()

	for k, v in ipairs(app.Table) do
		DataProvider:Insert({ id = v.id, icon = v.icon, text = v.text })
	end

	app.ScrollView2:SetDataProvider(DataProvider, true)

	app.EditPanel.Options.Title:SetText(app.Table[app.ScrollView2.Selection].text or "")
	app.EditPanel.Options.Icon:SetText(app.Table[app.ScrollView2.Selection].icon or "")

	if app.ScrollView then app:UpdateStatusTracker() end
end
