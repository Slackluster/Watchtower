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
		Watchtower_Settings = Watchtower_Settings or {}

		Watchtower_Settings["minimapIcon"] = true
		Watchtower_Settings["hide"] = false

		app.CreateMinimapButton()
		app.CreateSettings()
	end
end)

--------------
-- SETTINGS --
--------------

function app.OpenSettings()
	Settings.OpenToCategory(app.Settings:GetID())
end

function Watchtower_Click(self, button)
	if button == "LeftButton" then
		-- ???
	elseif button == "RightButton" then
		app.OpenSettings()
	end
end

function Watchtower_Enter(self, button)
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(type(self) ~= "string" and self or button, "ANCHOR_LEFT")
	GameTooltip:AddLine(L.SETTINGS_TOOLTIP)
	GameTooltip:Show()
end

function Watchtower_Leave()
	GameTooltip:Hide()
end

function app.CreateMinimapButton()
	local miniButton = LibStub("LibDataBroker-1.1"):NewDataObject(appName, {
		type = "data source",
		text = app.NameLong,
		icon = app.Icon,

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

function app.CreateSettings()
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
	text:SetText(L.SETTINGS_URL_COPIED)

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

	local category, layout = Settings.RegisterVerticalLayoutCategory(app.Name)
	Settings.RegisterAddOnCategory(category)
	app.Settings = category

	Watchtower_SettingsTextMixin = {}
	function Watchtower_SettingsTextMixin:Init(initializer)
		local data = initializer:GetData()
		self.Text:SetTextToFit(data.text)
	end

	local data = { text = L.SETTINGS_SUPPORT_TEXTLONG }
	local text = layout:AddInitializer(Settings.CreateElementInitializer("Watchtower_SettingsText", data))
	function text:GetExtent()
		return 28 + select(2, string.gsub(data.text, "\n", "")) * 12
	end

	layout:AddInitializer(CreateSettingsButtonInitializer(L.SETTINGS_SUPPORT_TEXT, L.SETTINGS_SUPPORT_BUTTON, function() StaticPopup_Show("WATCHTOWER_URL", nil, nil, "https://buymeacoffee.com/Slackluster") end, L.SETTINGS_SUPPORT_DESC, true))

	layout:AddInitializer(CreateSettingsButtonInitializer(L.SETTINGS_HELP_TEXT, L.SETTINGS_HELP_BUTTON, function() StaticPopup_Show("WATCHTOWER_URL", nil, nil, "https://discord.gg/hGvF59hstx") end, L.SETTINGS_HELP_DESC, true))

	layout:AddInitializer(CreateSettingsButtonInitializer(L.SETTINGS_ISSUES_TEXT, L.SETTINGS_ISSUES_BUTTON, function() StaticPopup_Show("WATCHTOWER_URL", nil, nil, "https://github.com/Slackluster/Watchtower/issues") end, L.SETTINGS_ISSUES_DESC, true))

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(C_AddOns.GetAddOnMetadata(appName, "Version")))

	local variable, name, tooltip = "minimapIcon", L.SETTINGS_MINIMAP, L.SETTINGS_MINIMAP_DESC
	local setting = Settings.RegisterAddOnSetting(category, appName.."_"..variable, variable, Watchtower_Settings, Settings.VarType.Boolean, name, true)
	Settings.CreateCheckbox(category, setting, tooltip)
	setting:SetValueChangedCallback(function()
		if Watchtower_Settings["minimapIcon"] then
			Watchtower_Settings["hide"] = false
			app.MinimapIcon:Show(appName)
		else
			Watchtower_Settings["hide"] = true
			app.MinimapIcon:Hide(appName)
		end
	end)

	local variable, name, tooltip = "statusTrackerLocked", L.SETTINGS_LOCKED, L.SETTINGS_LOCKED_DESC
	local setting = Settings.RegisterAddOnSetting(category, appName.."_"..variable, variable, Watchtower_Settings, Settings.VarType.Boolean, name, true)
	Settings.CreateCheckbox(category, setting, tooltip)
	setting:SetValueChangedCallback(function()

	end)
end
