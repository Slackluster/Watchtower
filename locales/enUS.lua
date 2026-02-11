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
L.SETTINGS_URL_COPY =					"Ctrl+C to copy:"
L.SETTINGS_URL_COPIED =					"Link copied to clipboard"

L.SETTINGS_KEYSLASH_TITLE =				SETTINGS_KEYBINDINGS_LABEL .. " & Slash Commands"	-- "Keybindings"
_G["BINDING_NAME_WATCHTOWER_TOGGLE"] =	app.NameShort .. ": Toggle Edit Panel"
L.SLASH_TOGGLE_EDITPANEL =				"Toggle the edit panel"
L.SLASH_OPEN_SETTINGS =					"Open the settings"

L.GENERAL =								GENERAL	-- "General"

-- Tutorial
L.TUTORIAL_HEADER =						"Readme.txt"
L.TUTORIAL_EXPLAIN1 =					"Flags run code on events and can be made visible via an icon and title."
L.TUTORIAL_EXPLAIN2 =					"Flags in the Inactive group don't show or run (except when edited)."
L.TUTORIAL_TRIGGER =					"Trigger code"
L.TUTORIAL_TRIGGER1 =					"You can grab the triggered event's name and arguments using:"
L.TUTORIAL_TRIGGER2 =					"Code runs regardless of the flag's visibility."
L.TUTORIAL_VISIBILITY =					"Visibility"
L.TUTORIAL_VISIBILITY1 =				"Code that returns falsy hides the flag:"
L.TUTORIAL_VISIBILITY2 =				"Code that returns truthy shows the flag:"
L.TUTORIAL_TITLE =						"Flag title"
L.TUTORIAL_TITLE1 =						"Code returning a number or string will set the flag's title to that value."
L.TUTORIAL_WHAT =						"I don't know what any of this means! D:"
L.TUTORIAL_WHAT1 =						"You can take it easy and just import the flags you want to use."
L.TUTORIAL_GETFLAGS =					"Get flags here!"
L.TUTORIAL_EXAMPLE_TITLE1 =				"Inactive flag"
L.TUTORIAL_EXAMPLE_TITLE2 =				"Hidden flag"
L.TUTORIAL_EXAMPLE_SETTINGS =			"Open Watchtower settings"
L.TUTORIAL_EXAMPLE_INACTIVE =			"You can drag this flag to any other group to make it active."
L.TUTORIAL_EXAMPLE_MOVE =				"Groups can be moved when this edit panel is open."

-- Edit Panel
L.NEW_FLAG =							"New Flag"
L.NEW_GROUP =							"New Group"
L.INACTIVE =							FACTION_INACTIVE	-- "Inactive"
L.DELETE_FLAG =							"Delete Flag"
L.DELETE_GROUP =						"Delete Group"
L.IMPORT =								HUD_EDIT_MODE_IMPORT_LAYOUT	-- "Import"
L.EXPORT_FLAG =							"Export Flag"
L.EXPORT_GROUP =						"Export Group"
L.EXPORT_COPIED =						"Export string copied to clipboard"
L.DELETE_FLAG_Q =						"Delete this flag?"
L.DELETE_GROUP_Q =						"Delete this group?"
L.HOLD_SKIP =							"Hold Shift to skip this confirmation."
L.CANTDELETE_GROUP =					"Can't delete a group with flags"
L.CANTMOVE_GROUP =						"Can't move this group"

L.TITLE =								LFG_LIST_TITLE	-- "Title"
L.ICON =								EMBLEM_SYMBOL	-- "Icon"
L.TRIGGER =								"Trigger"
L.EVENTS =								EVENTS_LABEL	-- "Events"
L.DESCRIPTION =							DESCRIPTION	-- "Description"
L.URL =									"URL"
L.TEMPLATES =							"Templates"
L.OVERWRITE_FLAG =						"Overwrite this flag with this template?"

L.STYLE =								"Style"
L.GROUP_STYLE = {}
L.GROUP_STYLE[1] =						"Icons and Text"
L.GROUP_STYLE[2] =						"|cff9d9d9dIcons Only (Soon™)"
L.ANCHOR =								"Anchor"
L.GROUP_ANCHOR = {}
L.GROUP_ANCHOR[1] =						"Top Left"
L.GROUP_ANCHOR[2] =						"Top Right"
L.GROUP_ANCHOR[3] =						"Bottom Left"
L.GROUP_ANCHOR[4] =						"Bottom Right"
L.FONT =								"Font"
L.SCALE =								HOUSING_EXPERT_DECOR_SUBMODE_SCALE	-- "Scale"

L.FLAG_TEMPLATE = {}
L.FLAG_TEMPLATE[1] = {}
L.FLAG_TEMPLATE[1].title =				"Buy Marks of Honor"
L.FLAG_TEMPLATE[1].description =		"Becomes visible when this character has 2000 or more Honor, as a reminder to buy the cache that contains 5 Marks of Honor."
L.FLAG_TEMPLATE[2] = {}
L.FLAG_TEMPLATE[2].title =				"Garrison Invasion"
L.FLAG_TEMPLATE[2].description =		"Becomes visible when no character on your account has completed a (Platinum) Garrison invasion yet this week."
L.FLAG_TEMPLATE[3] = {}
L.FLAG_TEMPLATE[3].title =				"Portal: Isle of Thunder"
L.FLAG_TEMPLATE[3].description =		"Becomes visible when this character has not yet unlocked the portal from Townlong Steppes to the Isle of Thunder."
L.FLAG_TEMPLATE[4] = {}
L.FLAG_TEMPLATE[4].title =				"Faded Treasure Map"
L.FLAG_TEMPLATE[4].description =		"Becomes visible if the Darkmoon Faire is up, and this character has not completed the Faded Treasure Map quest for 100 Darkmoon Prize Tickets."
L.FLAG_TEMPLATE[5] = {}
L.FLAG_TEMPLATE[5].title =				"Darkmoon Adventurer's Guide"
L.FLAG_TEMPLATE[5].description =		"Becomes visible if the Darkmoon Faire is up, and this character does not own the Darkmoon Adventurer's Guide."
L.FLAG_TEMPLATE[6] = {}
L.FLAG_TEMPLATE[6].title =				"Chromie Time"
L.FLAG_TEMPLATE[6].description =		"Becomes visible when this character is in Chromie Time."
L.FLAG_TEMPLATE[7] = {}
L.FLAG_TEMPLATE[7].title =				"Buy Scroll of Teleport"
L.FLAG_TEMPLATE[7].description =		"Automatically buy a Scroll of Teleport: Theater of Pain from One-Eyed Joby if you don't have one already. This flag is always hidden."

-- Debugging
L.ERROR_UNKNOWN_EVENT =					"Unknown event:"
L.ERROR_BLOCKED1 =						"Access to \"%s\" is blocked"
L.ERROR_BLOCKED2 =						"Assignment to \"%s\" is blocked"
L.FUNCTION_ERROR =						"Function error:"
L.FUNCTION_OUTPUT =						"Function output:"
L.IMPORT_ERROR =						"Import error:"
L.EXPORT_ERROR =						"Export error:"
L.ERROR_BLOCKED =						"%s was blocked"
L.ERROR_UNKNOWN =						"An unknown error occurred"
L.ERROR_INVALID_IMPORT_STRING =			"Invalid import string"
L.ERROR_DECODE =						"Failed decode #"	-- Followed by a number
L.FLAG_ERROR_LUA =						"Watchtower flag [%s] caused an error on '%s':"	-- The %s's are variale flag title and event name

-- General
L.NEW_VERSION_AVAILABLE =				"There is a newer version of " .. app.NameLong .. " available:"
L.SETTINGS_TOOLTIP =					app.NameLong .. "\n|cffFFFFFF"
										.. app:ShowIcon(app.IconLMB) .. ": " .. L.SLASH_TOGGLE_EDITPANEL .. "\n"
										.. app:ShowIcon(app.IconRMB) .. ": " .. L.SLASH_OPEN_SETTINGS

L.INVALID_COMMAND =						"Invalid command"
L.OR =									"or"
