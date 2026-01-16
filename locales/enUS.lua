--------------------------
-- Watchtower: enUS.lua --
--------------------------
-- English (United States) localisation
-- Translator(s): N/A

-- if GetLocale() ~= "enUS" then return end
local appName, app = ...
local L = app.locales

-- Settings
L.SETTINGS_VERSION =					GAME_VERSION_LABEL .. ":"	-- "Version"
L.SETTINGS_SUPPORT_TEXTLONG =			"Developing this addon takes a significant amount of time and effort.\nPlease consider financially supporting the developer."
L.SETTINGS_SUPPORT_TEXT =				"Support"
L.SETTINGS_SUPPORT_BUTTON =				"Buy Me a Coffee"	-- Brand name, if there isn't a localised version, keep it the way it is
L.SETTINGS_SUPPORT_DESC =				"Thank you!"
L.SETTINGS_HELP_TEXT =					"Feedback & Help"
L.SETTINGS_HELP_BUTTON =				"Discord"	-- Brand name, if there isn't a localised version, keep it the way it is
L.SETTINGS_HELP_DESC =					"Join the Discord server."
L.SETTINGS_ISSUES_TEXT =				"Issue Tracker"
L.SETTINGS_ISSUES_BUTTON =				"GitHub"	-- Brand name, if there isn't a localised version, keep it the way it is
L.SETTINGS_ISSUES_DESC =				"View the issue tracker on GitHub."
L.SETTINGS_URL_COPY =					"Ctrl+C to copy:"
L.SETTINGS_URL_COPIED =					"Link copied to clipboard"

L.SETTINGS_KEYSLASH_TITLE =				SETTINGS_KEYBINDINGS_LABEL .. " & Slash Commands"	-- "Keybindings"
_G["BINDING_NAME_WATCHTOWER_TOGGLE"] =	"Toggle Edit Panel"
L.SLASH_TOGGLE_EDITPANEL =				"Toggle the edit panel"
L.SLASH_OPEN_SETTINGS =					"Open the settings"

L.GENERAL =								GENERAL	-- "General"

-- Edit Panel
L.GROUP_STYLE = {}
L.GROUP_STYLE[1] =						"Icons and Text"
L.GROUP_STYLE[2] =						"|cff9d9d9dIcons Only (Soon™)"
L.GROUP_ANCHOR = {}
L.GROUP_ANCHOR[1] =						"Top Left"
L.GROUP_ANCHOR[2] =						"Top Right"
L.GROUP_ANCHOR[3] =						"Bottom Left"
L.GROUP_ANCHOR[4] =						"Bottom Right"

-- General
L.NEW_VERSION_AVAILABLE =				"There is a newer version of " .. app.NameLong .. " available:"
L.SETTINGS_TOOLTIP =					app.NameLong .. "\n|cffFFFFFF"
										.. app:ShowIcon(app.IconLMB) .. ": " .. L.SLASH_TOGGLE_EDITPANEL .. "\n"
										.. app:ShowIcon(app.IconRMB) .. ": " .. L.SLASH_OPEN_SETTINGS

L.INVALID_COMMAND =						"Invalid command."
L.OR =									"or"
