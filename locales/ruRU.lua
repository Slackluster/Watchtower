--------------------------
-- Watchtower: ruRU.lua --
--------------------------
-- Russian (Russia) localisation
-- Translator(s): ZamestoTV

if GetLocale() ~= "ruRU" then return end
local appName, app = ...
local L = app.locales

-- Settings
L.SETTINGS_VERSION =					GAME_VERSION_LABEL .. ":"	-- "Version"
L.SETTINGS_SUPPORT_TEXTLONG =			"Разработка этого аддона требует значительного времени и усилий.\nПожалуйста, рассмотрите возможность финансовой поддержки разработчика."
L.SETTINGS_SUPPORT_TEXT =				"Поддержать"
L.SETTINGS_SUPPORT_BUTTON =				"Buy Me a Coffee" -- Brand name, if there isn't a localised version, keep it the way it is
L.SETTINGS_SUPPORT_DESC =				"Спасибо!"
L.SETTINGS_HELP_TEXT =					"Обратная связь и помощь"
L.SETTINGS_HELP_BUTTON =				"Discord" -- Brand name, if there isn't a localised version, keep it the way it is
L.SETTINGS_HELP_DESC =					"Присоединиться к серверу Discord."
L.SETTINGS_ISSUES_TEXT =				"Отслеживание ошибок"
L.SETTINGS_ISSUES_BUTTON =				"GitHub" -- Brand name, if there isn't a localised version, keep it the way it is
L.SETTINGS_ISSUES_DESC =				"Просмотреть трекер ошибок на GitHub."
L.SETTINGS_URL_COPY =					"Ctrl+C — скопировать:"
L.SETTINGS_URL_COPIED =					"Ссылка скопирована в буфер обмена"

L.SETTINGS_KEYSLASH_TITLE =				SETTINGS_KEYBINDINGS_LABEL .. " & Слэш-команды"	-- "Keybindings"
_G["BINDING_NAME_WATCHTOWER_TOGGLE"] =	"Включить панель редактирования"
L.SLASH_TOGGLE_EDITPANEL =				"Включить панель редактирования"
L.SLASH_OPEN_SETTINGS =					"Откройте настройки"

L.GENERAL =								GENERAL	-- "General"

-- Edit Panel
-- L.NEW_FLAG =							"New Flag"
-- L.NEW_GROUP =							"New Group"
-- L.INACTIVE =							FACTION_INACTIVE
-- L.DELETE_FLAG =							"Delete Flag"
-- L.DELETE_GROUP =						"Delete Group"
-- L.IMPORT =								HUD_EDIT_MODE_IMPORT_LAYOUT
-- L.EXPORT_FLAG =							"Export Flag"
-- L.EXPORT_GROUP =						"Export Group"
-- L.DELETE_FLAG =							"Delete this flag?"
-- L.DELETE_GROUP =						"Delete this group?"
-- L.HOLD_SKIP =							"Hold Shift to skip this confirmation."
-- L.CANTDELETE_GROUP =					"Can't delete a group with flags."
-- L.CANTMOVE_GROUP =						"Can't move this group"

-- L.TITLE =								LFG_LIST_TITLE
-- L.ICON =								EMBLEM_SYMBOL
-- L.TRIGGER =								"Trigger"
-- L.EVENTS =								EVENTS_LABEL
-- L.TEMPLATES =							"Templates"
-- L.OVERWRITE_FLAG =						"Overwrite this flag with this template?"

-- L.STYLE =								"Style"
-- L.GROUP_STYLE = {}
-- L.GROUP_STYLE[1] =						"Icons and Text"
-- L.GROUP_STYLE[2] =						"|cff9d9d9dIcons Only (Soon™)"
-- L.ANCHOR =								"Anchor"
L.GROUP_ANCHOR = {}
L.GROUP_ANCHOR[1] =						"Верхний левый"
L.GROUP_ANCHOR[2] =						"Верхний правый"
L.GROUP_ANCHOR[3] =						"Нижний левый"
L.GROUP_ANCHOR[4] =						"Нижний правый"
-- L.FONT =								"Font"
-- L.SCALE =								HOUSING_EXPERT_DECOR_SUBMODE_SCALE

-- L.FLAG_TEMPLATE = {}
-- L.FLAG_TEMPLATE[1] = {}
-- L.FLAG_TEMPLATE[1].title =				"Buy Marks of Honor"
-- L.FLAG_TEMPLATE[1].description =		"Becomes visible when this character has 2000 or more Honor, as a reminder to buy the cache that contains 5 Marks of Honor."
-- L.FLAG_TEMPLATE[2] = {}
-- L.FLAG_TEMPLATE[2].title =				"Garrison Invasion"
-- L.FLAG_TEMPLATE[2].description =		"Becomes visible when no character on your account has completed a (Platinum) Garrison invasion yet this week."
-- L.FLAG_TEMPLATE[3] = {}
-- L.FLAG_TEMPLATE[3].title =				"Portal: Isle of Thunder"
-- L.FLAG_TEMPLATE[3].description =		"Becomes visible when this character has not yet unlocked the portal from Townlong Steppes to the Isle of Thunder."
-- L.FLAG_TEMPLATE[4] = {}
-- L.FLAG_TEMPLATE[4].title =				"Faded Treasure Map"
-- L.FLAG_TEMPLATE[4].description =		"Becomes visible if the Darkmoon Faire is up, and this character has not completed the Faded Treasure Map quest for 100 Darkmoon Prize Tickets."
-- L.FLAG_TEMPLATE[5] = {}
-- L.FLAG_TEMPLATE[5].title =				"Darkmoon Adventurer's Guide"
-- L.FLAG_TEMPLATE[5].description =		"Becomes visible if the Darkmoon Faire is up, and this character does not own the Darkmoon Adventurer's Guide."
-- L.FLAG_TEMPLATE[6] = {}
-- L.FLAG_TEMPLATE[6].title =				"Chromie Time"
-- L.FLAG_TEMPLATE[6].description =		"Becomes visible when this character is in Chromie Time."
-- L.FLAG_TEMPLATE[7] = {}
-- L.FLAG_TEMPLATE[7].title =				"Buy Scroll of Teleport"
-- L.FLAG_TEMPLATE[7].description =		"Automatically buy a Scroll of Teleport: Theater of Pain from One-Eyed Joby if you don't have one already. This flag is always hidden."

-- Debugging
-- L.ERROR_UNKNOWN_EVENT =					"Attempt to register unknown event"
-- L.ERROR_BLOCKED1 =						"Access to \"%s\" is blocked"
-- L.ERROR_BLOCKED2 =						"Assignment to \"%s\" is blocked"
-- L.ERROR_FUNCTION =						"Function error:"
-- L.RETURN_FUNCTION =						"Function returns:"

-- General
L.NEW_VERSION_AVAILABLE =				"Доступна новая версия " .. app.NameLong .. ":"
L.SETTINGS_TOOLTIP =					app.NameLong .. "\n|cffFFFFFF"
 										.. app:ShowIcon(app.IconLMB) .. ": " .. L.SLASH_TOGGLE_EDITPANEL .. "\n"
 										.. app:ShowIcon(app.IconRMB) .. ": " .. L.SLASH_OPEN_SETTINGS

L.INVALID_COMMAND =						"Неверная команда."
L.OR =									"или"
