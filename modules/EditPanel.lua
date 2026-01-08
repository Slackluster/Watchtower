-------------------------------
-- Watchtower: EditPanel.lua --
-------------------------------

local appName, app = ...
local L = app.locales
local api = app.api

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
	app.EditPanel:SetSize(900,500)
	app.EditPanel:SetPoint("CENTER")
	app.EditPanel:EnableMouse(true)
	app.EditPanel:SetMovable(true)
	app.EditPanel:SetClampedToScreen(true)
	app.EditPanel:SetClampRectInsets(700, -700, -300, 300)	-- 200px insets
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
	app.EditPanel.StatusList:SetPoint("TOPLEFT", app.EditPanel, 10, -50)
	app.EditPanel.StatusList:SetPoint("BOTTOMLEFT", app.EditPanel, 10, 8)
	app.EditPanel.StatusList:SetWidth(274)
	app.EditPanel.StatusList.Background = app.EditPanel.StatusList:CreateTexture(nil, "BACKGROUND")
	app.EditPanel.StatusList.Background:SetAllPoints()
	app.EditPanel.StatusList.Background:SetAtlas("Professions-background-summarylist")
	NineSliceUtil.ApplyLayoutByName(app.EditPanel.StatusList, "InsetFrameTemplate")

	app.EditPanel.MakeNewButton = app:MakeButton(app.EditPanel, "New Flag")
	app.EditPanel.MakeNewButton:SetPoint("BOTTOMRIGHT", app.EditPanel.StatusList, "TOPRIGHT", 0, 2)

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

	app.ScrollView2 = CreateScrollBoxListTreeListView()
	ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, app.ScrollView2)

	local function Initializer(listItem, node)
		local data = node:GetData()

		--if data.index then
			listItem.LeftText1:SetText("|T" .. data.icon .. ":18|t")
			listItem.LeftText2:SetText(data.text)
			listItem.LeftText2:SetFont("Fonts\\FRIZQT__.TTF", 14)
		--end

		listItem:EnableMouse(true)
		listItem:RegisterForDrag("LeftButton")
		listItem:SetScript("OnDragStart", function() app.EditPanel:StartMoving() end)
		listItem:SetScript("OnDragStop", function() app.EditPanel:StopMovingOrSizing() end)
	end

	app.ScrollView2:SetElementInitializer("Watchtower_ListButton", Initializer)
	app:UpdateStatusList()

	-------------------------------------------------------------

	app.EditPanel.StatusOptions = CreateFrame("Frame", nil, app.EditPanel, "NineSlicePanelTemplate")
	app.EditPanel.StatusOptions:SetPoint("TOPLEFT", app.EditPanel.StatusList, "TOPRIGHT", 4, 0)
	app.EditPanel.StatusOptions:SetPoint("BOTTOMRIGHT", app.EditPanel, -6, 8)
	app.EditPanel.StatusOptions.Background = app.EditPanel.StatusOptions:CreateTexture(nil, "BACKGROUND")
	app.EditPanel.StatusOptions.Background:SetAtlas("thewarwithin-landingpage-background")
	app.EditPanel.StatusOptions.Background:SetAllPoints()
	NineSliceUtil.ApplyLayoutByName(app.EditPanel.StatusOptions, "InsetFrameTemplate")

	app.EditPanel.StatusOptions.Tabs = {}
	app.EditPanel.StatusOptions.numTabs = 0

	local function createTab(label)
		app.EditPanel.StatusOptions.numTabs = app.EditPanel.StatusOptions.numTabs + 1

		local tab = CreateFrame("Button", nil, app.EditPanel.StatusOptions, "PanelTopTabButtonTemplate")
		tab:SetText(label)
		tab:SetID(app.EditPanel.StatusOptions.numTabs)

		if app.EditPanel.StatusOptions.numTabs == 1 then
			tab:SetPoint("BOTTOMLEFT", app.EditPanel.StatusOptions, "TOPLEFT", 10, -3)
		else
			tab:SetPoint("LEFT", app.EditPanel.StatusOptions.Tabs[app.EditPanel.StatusOptions.numTabs - 1], "RIGHT", -15, 0)
		end

		app.EditPanel.StatusOptions.Tabs[app.EditPanel.StatusOptions.numTabs] = tab
		PanelTemplates_SetNumTabs(app.EditPanel.StatusOptions, app.EditPanel.StatusOptions.numTabs)

		tab:SetScript("OnClick", function()
			PanelTemplates_SetTab(app.EditPanel.StatusOptions, tab:GetID())
		end)

		return tab
	end

	local tab1 = createTab("General")
	local tab2 = createTab("Advanced")

	PanelTemplates_SetTab(app.EditPanel.StatusOptions, 1)
	PanelTemplates_UpdateTabs(app.EditPanel.StatusOptions)
end

function app:UpdateStatusList()
	local DataProvider = CreateTreeDataProvider()

	for k, v in ipairs(app.Table) do
		DataProvider:Insert({ icon = v.icon, text = v.text })
	end

	app.ScrollView2:SetDataProvider(DataProvider, true)
end
