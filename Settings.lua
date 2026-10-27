------------------------------
-- Watchtower: Settings.lua --
------------------------------

local appName, app = ...
local L = app.locales

-------------
-- ON LOAD --
-------------

app.Event:Register("ADDON_LOADED", function(addOnName, containsBindings)
	if addOnName == appName then
		app.Settings.seen = app.Settings.seen or {}

		app:CreateMinimapButton()
		app:CreateSettings()
	end
end)

--------------
-- SETTINGS --
--------------

function app:OpenSettings()
	if InCombatLockdown() then
		app:Print(ERR_AFFECTING_COMBAT .. ".")
	else
		Settings.OpenToCategory(app.SettingsCategory:GetID())
	end
end

function app:CreateMinimapButton()
	local miniButton = LibStub("LibDataBroker-1.1"):NewDataObject(app.NameLong, {
		type = "data source",
		text = app.NameLong,
		icon = app.Icon,

		OnClick = Watchtower_Click,
		OnEnter = Watchtower_Enter,
		OnLeave = Watchtower_Leave,
	})

	app.MinimapIcon = LibStub("LibDBIcon-1.0", true)
	app.MinimapIcon:Register(appName, miniButton, app.Settings)

	function app:ToggleMinimapIcon()
		if app.Settings.minimapIcon then
			app.Settings.hide = false
			app.MinimapIcon:Show(appName)
		else
			app.Settings.hide = true
			app.MinimapIcon:Hide(appName)
		end
	end
	app:ToggleMinimapIcon()
end

function app:CreateSettings()
	-- Helper functions
	app.LinkCopiedFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
	app.LinkCopiedFrame:SetPoint("CENTER")
	app.LinkCopiedFrame:SetFrameStrata("TOOLTIP")
	app.LinkCopiedFrame:SetHeight(1)
	app.LinkCopiedFrame:SetWidth(1)
	app.LinkCopiedFrame:Hide()

	app.LinkCopiedFrame.Text = app.LinkCopiedFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	app.LinkCopiedFrame.Text:SetPoint("CENTER", app.LinkCopiedFrame, "CENTER")
	app.LinkCopiedFrame.Text:SetPoint("TOP", app.LinkCopiedFrame, "TOP")
	app.LinkCopiedFrame.Text:SetJustifyH("CENTER")

	app.LinkCopiedFrame.animation = app.LinkCopiedFrame:CreateAnimationGroup()
	local fadeOut = app.LinkCopiedFrame.animation:CreateAnimation("Alpha")
	fadeOut:SetFromAlpha(1)
	fadeOut:SetToAlpha(0)
	fadeOut:SetDuration(1)
	fadeOut:SetStartDelay(1)
	fadeOut:SetSmoothing("IN_OUT")
	app.LinkCopiedFrame.animation:SetToFinalAlpha(true)
	app.LinkCopiedFrame.animation:SetScript("OnFinished", function()
		app.LinkCopiedFrame:Hide()
	end)

	StaticPopupDialogs["WATCHTOWER_URL"] = {
		text = L.CTRL_C_COPY,
		button1 = CLOSE,
		whileDead = true,
		hasEditBox = true,
		editBoxWidth = 240,
		OnShow = function(dialog, data)
			dialog:ClearAllPoints()
			dialog:SetPoint("CENTER", UIParent)

			local editBox = dialog.GetEditBox and dialog:GetEditBox() or dialog.editBox
			editBox:SetText(data)
			editBox:SetAutoFocus(true)
			editBox:HighlightText()
			editBox:SetScript("OnEditFocusLost", function()
				editBox:SetFocus()
			end)
			editBox:SetScript("OnEscapePressed", function()
				dialog:Hide()
			end)
			editBox:SetScript("OnTextChanged", function()
				editBox:SetText(data)
				editBox:HighlightText()
			end)
			editBox:SetScript("OnKeyUp", function(self, key)
				if (IsControlKeyDown() and (key == "C" or key == "X")) then
					dialog:Hide()
					app.LinkCopiedFrame.Text:SetText(app.IconReady .. " " .. L.LINK_COPIED)
					app.LinkCopiedFrame:Show()
					app.LinkCopiedFrame:SetAlpha(1)
					app.LinkCopiedFrame.animation:Play()
				end
			end)
		end,
		OnHide = function(dialog)
			local editBox = dialog.GetEditBox and dialog:GetEditBox() or dialog.editBox
			editBox:SetScript("OnEditFocusLost", nil)
			editBox:SetScript("OnEscapePressed", nil)
			editBox:SetScript("OnTextChanged", nil)
			editBox:SetScript("OnKeyUp", nil)
			editBox:SetText("")
		end,
	}

	Watchtower_SettingsTextMixin = {}
	function Watchtower_SettingsTextMixin:Init(initializer)
		local data = initializer:GetData()
		self.LeftText:SetTextToFit(data.leftText)
		self.MiddleText:SetTextToFit(data.middleText)
		self.RightText:SetTextToFit(data.rightText)

		SettingsPanel.Container.SettingsList.Header.Title:SetText(CreateSimpleTextureMarkup(app.Icon, 16, 16) .. " " .. app.NameLong)
	end

	Watchtower_SettingsExpandMixin = CreateFromMixins(SettingsExpandableSectionMixin)

	function Watchtower_SettingsExpandMixin:Init(initializer)
		SettingsExpandableSectionMixin.Init(self, initializer)
		self.data = initializer.data
	end

	function Watchtower_SettingsExpandMixin:OnExpandedChanged(expanded)
		SettingsInbound.RepairDisplay()
	end

	function Watchtower_SettingsExpandMixin:CalculateHeight()
		return 24
	end

	function Watchtower_SettingsExpandMixin:OnExpandedChanged(expanded)
		self:EvaluateVisibility(expanded)
		SettingsInbound.RepairDisplay()
	end

	function Watchtower_SettingsExpandMixin:EvaluateVisibility(expanded)
		if expanded then
			self.Button.Right:SetAtlas("Options_ListExpand_Right_Expanded", TextureKitConstants.UseAtlasSize)
		else
			self.Button.Right:SetAtlas("Options_ListExpand_Right", TextureKitConstants.UseAtlasSize)
		end
	end

	local category, layout

	local function addNewTag(initializer, variable)
		initializer.data.newTagID = appName
		app.NewFeatures = app.NewFeatures or {}
		table.insert(app.NewFeatures, variable)
	end

	local function showNewTag(self) -- Thank you, R41Z0R!
		if self.data and self.data.newTagID and self.data.newTagID == appName then
			self.NewFeature:SetShown(true)
		end
	end
	hooksecurefunc(SettingsCheckboxControlMixin, "Init", showNewTag)
	hooksecurefunc(SettingsDropdownControlMixin, "Init", showNewTag)
	hooksecurefunc(SettingsCheckboxDropdownControlMixin, "Init", showNewTag)

	hooksecurefunc(SettingsPanel, "DisplayCategory", function(self, category)
		if category == app.SettingsCategory then
			for _, feature in ipairs(app.NewFeatures) do
				app.Settings.seen[feature] = true
			end
		end
	end)

	local function showNewCategoryTag(self)
		if app.NewFeatures then
			local unseenNew = false
			for _, feature in ipairs(app.NewFeatures) do
				if not app.Settings.seen[feature] then
					unseenNew = true
					break
				end
			end

			if unseenNew then
				local data = self:GetData()
				if data and data.data and data.data.category and data.data.category.ID == app.SettingsCategory:GetID() then
					self.NewFeature:SetShown(true)
				end
			end
		end
	end
	hooksecurefunc(SettingsCategoryListButtonMixin, "Init", showNewCategoryTag)

	local function button(name, buttonName, description, func)
		layout:AddInitializer(CreateSettingsButtonInitializer(name, buttonName, func, description, true))
	end

	local function checkbox(variable, name, description, default, callback, parentSetting, parentCheckbox, isNew)
		local setting = Settings.RegisterAddOnSetting(category, appName .. "_" .. variable, variable, app.Settings, type(default), name, default)
		local checkbox = Settings.CreateCheckbox(category, setting, description)

		if parentSetting and parentCheckbox then
			checkbox:SetParentInitializer(parentCheckbox, function() return parentSetting:GetValue() end)
			if callback then
				parentSetting:SetValueChangedCallback(callback)
			end
		elseif callback then
			setting:SetValueChangedCallback(callback)
		end

		if isNew then addNewTag(checkbox, variable) end

		return setting, checkbox
	end

	local function checkboxDropdown(cbVariable, cbName, description, cbDefaultValue, ddVariable, ddDefaultValue, options, callback, isNew)
		local cbSetting = Settings.RegisterAddOnSetting(category, appName .. "_" .. cbVariable, cbVariable, app.Settings, type(cbDefaultValue), cbName, cbDefaultValue)
		local ddSetting = Settings.RegisterAddOnSetting(category, appName .. "_" .. ddVariable, ddVariable, app.Settings, type(ddDefaultValue), "", ddDefaultValue)
		local function GetOptions()
			local container = Settings.CreateControlTextContainer()
			for _, option in ipairs(options) do
				container:Add(option.value, option.name, option.description)
			end
			return container:GetData()
		end

		local initializer = CreateSettingsCheckboxDropdownInitializer(cbSetting, cbName, description, ddSetting, GetOptions, "")
		layout:AddInitializer(initializer)

		if callback then
			cbSetting:SetValueChangedCallback(callback)
			ddSetting:SetValueChangedCallback(callback)
		end

		if isNew then addNewTag(initializer, cbVariable) end
	end

	local function dropdown(variable, name, description, default, options, callback, isNew)
		local setting = Settings.RegisterAddOnSetting(category, appName .. "_" .. variable, variable, app.Settings, type(default), name, default)
		local function GetOptions()
			local container = Settings.CreateControlTextContainer()
			for _, option in ipairs(options) do
				container:Add(option.value, option.name, option.description)
			end
			return container:GetData()
		end

		local initializer = Settings.CreateDropdown(category, setting, GetOptions, description)

		if callback then
			setting:SetValueChangedCallback(callback)
		end

		if isNew then addNewTag(initializer, variable) end
	end

	local function expandableHeader(name)
		local initializer = CreateFromMixins(SettingsExpandableSectionInitializer)
		local data = { name = name, expanded = false }

		initializer:Init("Watchtower_SettingsExpandTemplate", data)
		initializer.GetExtent = ScrollBoxFactoryInitializerMixin.GetExtent

		layout:AddInitializer(initializer)

		return initializer, function()
			return initializer.data.expanded
		end
	end

	local function header(name)
		layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(name))
	end

	local function keybind(name, isExpanded)
		local action = name
		local bindingIndex = C_KeyBindings.GetBindingIndex(action)
		local initializer = CreateKeybindingEntryInitializer(bindingIndex, true)
		local keybind = layout:AddInitializer(initializer)
		if isExpanded ~= nil then keybind:AddShownPredicate(isExpanded) end
	end

	local function text(leftText, middleText, rightText, customExtent, isExpanded)
		local data = { leftText = leftText, middleText = middleText, rightText = rightText }
		local text = layout:AddInitializer(Settings.CreateElementInitializer("Watchtower_SettingsText", data))
		function text:GetExtent()
			if customExtent then return customExtent end
			return 28 + select(2, string.gsub(data.leftText, "\n", "")) * 12
		end
		if isExpanded ~= nil then text:AddShownPredicate(isExpanded) end
	end

	-- Settings
	category, layout = Settings.RegisterVerticalLayoutCategory(app.Name)
	Settings.RegisterAddOnCategory(category)
	app.SettingsCategory = category

	text(L.VERSION .. " |cffFFFFFF" .. app.Version, nil, nil, 14)
	text(L.SUPPORT_TEXTLONG1 .. "\n" .. L.SUPPORT_TEXTLONG2)
	button(L.SUPPORT, L.BUY_ME_A_COFFEE, L.THANK_YOU, function() StaticPopup_Show("WATCHTOWER_URL", nil, nil, "https://buymeacoffee.com/Slackluster") end)
	button(L.FEEDBACK_AND_HELP, L.DISCORD, L.JOIN_DISCORD_SERVER, function() StaticPopup_Show("WATCHTOWER_URL", nil, nil, "https://discord.gg/hGvF59hstx") end)

	local _, isExpanded = expandableHeader(L.KEYBINDINGS_AND_SLASH_COMMANDS)

		keybind("WATCHTOWER_TOGGLE", isExpanded)

		local leftText = { "|cffFFFFFF" ..
			"/watch|r " .. L.OR .. " |cffFFFFFF/wt",
			"/watch settings" }
		local middleText = {
			L.TOGGLE_EDIT_PANEL,
			L.OPEN_SETTINGS }
		leftText = table.concat(leftText, "\n\n")
		middleText = table.concat(middleText, "\n\n")
		text(leftText, middleText, nil, nil, isExpanded)

	header(L.GENERAL)

	checkbox("minimapIcon", L.SHOW_MINIMAP_ICON, string.format(L.SHOW_MINIMAP_ICON_DESC, app.NameShort), true, function() app:ToggleMinimapIcon() end)
end
