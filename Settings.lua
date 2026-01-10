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

		Watchtower_Settings["minimapIcon"] = true
		Watchtower_Settings["hide"] = false

		app:CreateMinimapButton()
		app:CreateSettings()
	end
end)

--------------
-- SETTINGS --
--------------

function app:OpenSettings()
	Settings.OpenToCategory(app.Settings:GetID())
end

function app:CreateMinimapButton()
	local miniButton = LibStub("LibDataBroker-1.1"):NewDataObject(appName, {
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
	app.MinimapIcon:Register(appName, miniButton, Watchtower_Settings)

	if Watchtower_Settings["minimapIcon"] then
		Watchtower_Settings["hide"] = false
		app.MinimapIcon:Show(appName)
	else
		Watchtower_Settings["hide"] = true
		app.MinimapIcon:Hide(appName)
	end
end

function app:CreateSettings()
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
	text:SetText(app:ShowIcon(app.IconReady) .. " " .. L.SETTINGS_URL_COPIED)

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

	local function createExpandableSection(layout, name)
		local initializer = CreateFromMixins(SettingsExpandableSectionInitializer)
		local data = { name = name, expanded = false }

		initializer:Init("Watchtower_SettingsExpandTemplate", data)
		initializer.GetExtent = ScrollBoxFactoryInitializerMixin.GetExtent

		layout:AddInitializer(initializer)

		return initializer, function()
			return initializer.data.expanded
		end
	end

	local category, layout = Settings.RegisterVerticalLayoutCategory(app.Name)
	Settings.RegisterAddOnCategory(category)
	app.Settings = category

	local data = { leftText = L.SETTINGS_VERSION .. " |cffFFFFFF" .. C_AddOns.GetAddOnMetadata(appName, "Version") }
	local text = layout:AddInitializer(Settings.CreateElementInitializer("Watchtower_SettingsText", data))
	function text:GetExtent()
		return 14
	end

	local data = { leftText = L.SETTINGS_SUPPORT_TEXTLONG }
	local text = layout:AddInitializer(Settings.CreateElementInitializer("Watchtower_SettingsText", data))
	function text:GetExtent()
		return 28 + select(2, string.gsub(data.leftText, "\n", "")) * 12
	end

	layout:AddInitializer(CreateSettingsButtonInitializer(L.SETTINGS_SUPPORT_TEXT, L.SETTINGS_SUPPORT_BUTTON, function() StaticPopup_Show("WATCHTOWER_URL", nil, nil, "https://buymeacoffee.com/Slackluster") end, L.SETTINGS_SUPPORT_DESC, true))

	layout:AddInitializer(CreateSettingsButtonInitializer(L.SETTINGS_HELP_TEXT, L.SETTINGS_HELP_BUTTON, function() StaticPopup_Show("WATCHTOWER_URL", nil, nil, "https://discord.gg/hGvF59hstx") end, L.SETTINGS_HELP_DESC, true))

	layout:AddInitializer(CreateSettingsButtonInitializer(L.SETTINGS_ISSUES_TEXT, L.SETTINGS_ISSUES_BUTTON, function() StaticPopup_Show("WATCHTOWER_URL", nil, nil, "https://github.com/Slackluster/Watchtower/issues") end, L.SETTINGS_ISSUES_DESC, true))

	local expandInitializer, isExpanded = createExpandableSection(layout, L.SETTINGS_KEYSLASH_TITLE)

		local action = "WATCHTOWER_TOGGLE"
		local bindingIndex = C_KeyBindings.GetBindingIndex(action)
		local initializer = CreateKeybindingEntryInitializer(bindingIndex, true)
		local keybind = layout:AddInitializer(initializer)
		keybind:AddShownPredicate(isExpanded)

		local data = { leftText = "|cffFFFFFF"
			.. "/watch|r " .. L.OR .. " |cffFFFFFF/wst" .. "\n\n"
			.. "/watch settings",
		middleText =
			L.SLASH_TOGGLE_EDITPANEL .. "\n\n" ..
			L.SLASH_OPEN_SETTINGS
		}
		local text = layout:AddInitializer(Settings.CreateElementInitializer("Watchtower_SettingsText", data))
		function text:GetExtent()
			return 28 + select(2, string.gsub(data.leftText, "\n", "")) * 12
		end
		text:AddShownPredicate(isExpanded)

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L.GENERAL))
end
