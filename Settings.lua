------------------------------
-- Watchtower: Settings.lua --
------------------------------

local appName, app = ...
local api = app.api
local L = app.locales

-------------
-- ON LOAD --
-------------

app.Event:Register("ADDON_LOADED", function(addOnName, containsBindings)
	if addOnName == appName then
		Watchtower_Settings = Watchtower_Settings or {}
		app.Settings = Watchtower_Settings

		Watchtower_Flags = Watchtower_Flags or {
			{ ["groupID"] = 1, ["title"] = L.INACTIVE, ["flags"] = {
				{ ["flagID"] = 1, ["events"] = { "GLOBAL_MOUSE_DOWN" }, ["lastResult"] = true, ["icon"] = 134400,
				["title"] = L.TUTORIAL_EXAMPLE_TITLE1,
				["trigger"] = "-- " .. L.TUTORIAL_EXPLAIN2 .. "\n\nprint(\"Click\")\nreturn true\n\n-- " .. L.TUTORIAL_EXAMPLE_INACTIVE, },
			}, },
			{ ["groupID"] = 2, ["scale"] = 100, ["anchor"] = 3, ["style"] = 1, ["font"] = "Friz Quadrata TT", ["title"] = L.NEW_GROUP, ["flags"] = {
				{ ["flagID"] = 1, ["events"] = { "PLAYER_ENTERING_WORLD" }, ["lastResult"] = false, ["icon"] = 134400,
				["title"] = L.TUTORIAL_EXAMPLE_TITLE2,
				["trigger"] = "-- " .. L.TUTORIAL_TRIGGER1 .. "\nlocal event, isInitialLogin, isReloadingUi = ...\n\nif event == \"PLAYER_ENTERING_WORLD\" then\n   print(\"|cff3FC7EBWatchtower|R " .. TEST_STRING_IGNORE_1 .. "\")\nend\n\n-- " .. L.TUTORIAL_VISIBILITY1 .. "\nreturn false", },
				{ ["flagID"] = 2,
				["events"] = { "PLAYER_ENTERING_WORLD" }, ["lastResult"] = true, ["icon"] = 134400,
				["title"] = L.TUTORIAL_EXAMPLE_SETTINGS,
				["trigger"] = "-- " .. L.TUTORIAL_VISIBILITY2 .. "\nreturn true\n\n-- " .. L.TUTORIAL_EXAMPLE_MOVE,
				},
				{ ["flagID"] = 3, ["events"] = { "PLAYER_ENTERING_WORLD", "CHAT_MSG_CURRENCY", "BAG_UPDATE_DELAYED", "MERCHANT_CLOSED" }, ["lastResult"] = true, ["icon"] = 4696085,
				["title"] = "Tendies",
				["trigger"] = "local quantity = C_CurrencyInfo.GetCurrencyInfo(2032).quantity\nlocal name = C_CurrencyInfo.GetCurrencyInfo(2032).name\n\nif quantity == 0 then\n   return false\nelse\n   -- " .. L.TUTORIAL_TITLE1 .. "\n   return quantity .. \" \" .. name\nend" },
			}, },
		}

		app:CreateMinimapButton()
		app:CreateSettings()

		-- Beta cleanup
		for _, group in ipairs(Watchtower_Flags) do
			for _, flag in ipairs(group.flags) do
				if not flag.load then
					flag.load = {}
				end
				if not flag.actions then
					flag.actions = {}
				end
			end
		end
	end
end)

--------------
-- SETTINGS --
--------------

function app:OpenSettings()
	Settings.OpenToCategory(app.SettingsCategory:GetID())
end

function app:CreateMinimapButton()
	local miniButton = LibStub("LibDataBroker-1.1"):NewDataObject(app.NameLong, {
		type = "data source",
		text = app.NameLong,
		icon = app.Texture,

		OnClick = Watchtower_Click,

		OnTooltipShow = function(tooltip)
			if not tooltip or not tooltip.AddLine then return end
			tooltip:AddLine(L.SETTINGS_TOOLTIP)
		end,
	})

	app.MinimapIcon = LibStub("LibDBIcon-1.0", true)
	app.MinimapIcon:Register(appName, miniButton, app.Settings)

	function app:ToggleMinimapIcon()
		if app.Settings["minimapIcon"] then
			app.Settings["hide"] = false
			app.MinimapIcon:Show(appName)
		else
			app.Settings["hide"] = true
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

	local text = app.LinkCopiedFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	text:SetPoint("CENTER", app.LinkCopiedFrame, "CENTER", 0, 0)
	text:SetPoint("TOP", app.LinkCopiedFrame, "TOP", 0, 0)
	text:SetJustifyH("CENTER")
	text:SetText(app.IconReady .. " " .. L.SETTINGS_URL_COPIED)

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
		text = L.SETTINGS_URL_COPY,
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

	local function button(name, buttonName, description, func)
		layout:AddInitializer(CreateSettingsButtonInitializer(name, buttonName, func, description, true))
	end

	local function checkbox(variable, name, description, default, callback, parentSetting, parentCheckbox)
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

		return setting, checkbox
	end

	local function checkboxDropdown(cbVariable, cbName, description, cbDefaultValue, ddVariable, ddDefaultValue, options, callback)
		local cbSetting = Settings.RegisterAddOnSetting(category, appName.."_"..cbVariable, cbVariable, app.Settings, type(cbDefaultValue), cbName, cbDefaultValue)
		local ddSetting = Settings.RegisterAddOnSetting(category, appName.."_"..ddVariable, ddVariable, app.Settings, type(ddDefaultValue), "", ddDefaultValue)
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
	end

	local function dropdown(variable, name, description, default, options, callback)
		local setting = Settings.RegisterAddOnSetting(category, appName.."_"..variable, variable, app.Settings, type(default), name, default)
		local function GetOptions()
			local container = Settings.CreateControlTextContainer()
			for _, option in ipairs(options) do
				container:Add(option.value, option.name, option.description)
			end
			return container:GetData()
		end
		Settings.CreateDropdown(category, setting, GetOptions, description)
		if callback then
			setting:SetValueChangedCallback(callback)
		end
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

	text(L.SETTINGS_VERSION .. " |cffFFFFFF" .. C_AddOns.GetAddOnMetadata(appName, "Version"), nil, nil, 14)
	text(L.SETTINGS_SUPPORT_TEXTLONG)
	button(L.SETTINGS_SUPPORT_TEXT, L.SETTINGS_SUPPORT_BUTTON, L.SETTINGS_SUPPORT_DESC, function() StaticPopup_Show("WATCHTOWER_URL", nil, nil, "https://buymeacoffee.com/Slackluster") end)
	button(L.SETTINGS_HELP_TEXT, L.SETTINGS_HELP_BUTTON, L.SETTINGS_HELP_DESC, function() StaticPopup_Show("WATCHTOWER_URL", nil, nil, "https://discord.gg/hGvF59hstx") end)

	local _, isExpanded = expandableHeader(L.SETTINGS_KEYSLASH_TITLE)

		keybind("WATCHTOWER_TOGGLE", isExpanded)

		local leftText = { "|cffFFFFFF" ..
			"/watch|r " .. L.OR .. " |cffFFFFFF/wt",
			"/watch settings" }
		local middleText = {
			L.SLASH_TOGGLE_EDITPANEL,
			L.SLASH_OPEN_SETTINGS }
		leftText = table.concat(leftText, "\n\n")
		middleText = table.concat(middleText, "\n\n")
		text(leftText, middleText, nil, nil, isExpanded)

	header(L.GENERAL)

	checkbox("minimapIcon", L.SETTINGS_MINIMAP_TITLE, L.SETTINGS_MINIMAP_DESC, true, function() app:ToggleMinimapIcon() end)
end
