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
L.SETTINGS_URL_COPY =					"Ctrl+C — скопировать:"
L.SETTINGS_URL_COPIED =					"Ссылка скопирована в буфер обмена"

L.SETTINGS_KEYSLASH_TITLE =				SETTINGS_KEYBINDINGS_LABEL .. " & Слэш-команды"	-- "Keybindings"
_G["BINDING_NAME_WATCHTOWER_TOGGLE"] =	app.NameShort .. ": Включить панель редактирования"
L.SLASH_TOGGLE_EDITPANEL =				"Включить панель редактирования"
L.SLASH_OPEN_SETTINGS =					"Откройте настройки"

L.SETTINGS_MINIMAP =					"Показывать иконку на миникарте"
L.SETTINGS_MINIMAP_DESC =				"Показывать иконку на миникарте. Если вы отключите это, " .. app.NameLong .. " все еще доступен из отсека аддонов."

-- Edit Panel
L.NEW_FLAG =							"Новый флаг"
L.NEW_GROUP =							"Новая группа"
L.INACTIVE =							FACTION_INACTIVE	-- "Inactive"
L.DELETE_FLAG =							"Удалить флаг"
L.DELETE_GROUP =						"Удалить группу"
L.IMPORT =								HUD_EDIT_MODE_IMPORT_LAYOUT	-- "Import"
L.EXPORT_FLAG =							"Экспортировать флаг"
L.EXPORT_GROUP =						"Экспортировать группу"
L.EXPORT_COPIED =						"Экспортная строка скопирована в буфер обмена"
L.DELETE_FLAG_Q =						"Удалить этот флаг?"
L.DELETE_GROUP_Q =						"Удалить эту группу?"
L.HOLD_SKIP =							"Удерживайте Shift, чтобы не спрашивать подтверждение."
L.CANTDELETE_GROUP =					"Нельзя удалить группу с флагами внутри"
L.CANTMOVE_GROUP =						"Невозможно переместить эту группу"

L.GENERAL =								GENERAL	-- "General"

-- L.TUTORIAL_HEADER =						"Readme.txt"
-- L.TUTORIAL_EXPLAIN1 =					"Flags run code on events and can be made visible via an icon and title."
-- L.TUTORIAL_EXPLAIN2 =					"Flags in the Inactive group don't show or run (except when edited)."
-- L.TUTORIAL_TRIGGER =					"Trigger code"
-- L.TUTORIAL_TRIGGER1 =					"You can grab the triggered event's name and arguments using:"
-- L.TUTORIAL_TRIGGER2 =					"Code runs regardless of the flag's visibility."
-- L.TUTORIAL_VISIBILITY =					"Visibility"
-- L.TUTORIAL_VISIBILITY1 =				"Code that returns falsy hides the flag:"
-- L.TUTORIAL_VISIBILITY2 =				"Code that returns truthy shows the flag:"
-- L.TUTORIAL_TITLE =						"Flag title"
-- L.TUTORIAL_TITLE1 =						"Code returning a number or string will set the flag's title to that value."
-- L.TUTORIAL_WHAT =						"I don't know what any of this means! D:"
-- L.TUTORIAL_WHAT1 =						"You can take it easy and just import the flags you want to use."
-- L.TUTORIAL_GETFLAGS =					"Get flags here!"
-- L.TUTORIAL_EXAMPLE_TITLE1 =				"Inactive flag"
-- L.TUTORIAL_EXAMPLE_TITLE2 =				"Hidden flag"
-- L.TUTORIAL_EXAMPLE_SETTINGS =			"Open Watchtower settings"
-- L.TUTORIAL_EXAMPLE_INACTIVE =			"You can drag this flag to any other group to make it active."
-- L.TUTORIAL_EXAMPLE_MOVE =				"Groups can be moved when this edit panel is open."

L.TITLE =								LFG_LIST_TITLE	-- "Title"
L.ICON =								EMBLEM_SYMBOL	-- "Icon"
L.TRIGGER =								"Триггер"
L.EVENTS =								EVENTS_LABEL	-- "Events"
-- L.DESCRIPTION =							DESCRIPTION	-- "Description"
-- L.URL =									"URL"
L.TEMPLATES =							"Шаблоны"
L.OVERWRITE_FLAG =						"Перезаписать текущий флаг этим шаблоном?"

L.STYLE =								"Стиль"
L.GROUP_STYLE = {}
L.GROUP_STYLE[1] =						"Иконки и текст"
L.GROUP_STYLE[2] =						"|cff9d9d9dТолько иконки (в разработке™)"
L.ANCHOR =								"Точка привязки"
L.GROUP_ANCHOR = {}
L.GROUP_ANCHOR[1] =						"Верхний левый"
L.GROUP_ANCHOR[2] =						"Верхний правый"
L.GROUP_ANCHOR[3] =						"Нижний левый"
L.GROUP_ANCHOR[4] =						"Нижний правый"
L.FONT =								"Шрифт"
L.SCALE =								HOUSING_EXPERT_DECOR_SUBMODE_SCALE	-- "Scale"

-- L.LOAD =								"Load"

-- L.ACTIONS =								DAMAGE_METER_CATEGORY_ACTIONS	-- "Actions"

-- L.HIDE_AFTER =							"Hide after X seconds "

L.FLAG_TEMPLATE = {}
L.FLAG_TEMPLATE[1] = {}
L.FLAG_TEMPLATE[1].title =				"Купить Почетные знаки"
L.FLAG_TEMPLATE[1].description =		"Становится видимым, когда у персонажа ≥ 2000 чести — напоминание купить ящик с 5 Почетными знаками."
L.FLAG_TEMPLATE[2] = {}
L.FLAG_TEMPLATE[2].title =				"Вторжение в гарнизон"
L.FLAG_TEMPLATE[2].description =		"Становится видимым, если на аккаунте ни один персонаж ещё не завершил (платиновое) вторжение в гарнизон на этой неделе."
L.FLAG_TEMPLATE[3] = {}
L.FLAG_TEMPLATE[3].title =				"Портал: Остров Грома"
L.FLAG_TEMPLATE[3].description =		"Становится видимым, если персонаж ещё не открыл портал из Танлунских степей на Остров Грома."
L.FLAG_TEMPLATE[4] = {}
L.FLAG_TEMPLATE[4].title =				"Выцветшая карта сокровищ"
L.FLAG_TEMPLATE[4].description =		"Становится видимым, когда работает Ярмарка Новолуния и персонаж не выполнил квест «Выцветшая карта сокровищ» на 100 билетов Ярмарки Новолуния."
L.FLAG_TEMPLATE[5] = {}
L.FLAG_TEMPLATE[5].title =				"Справочник ярмарки Новолуния"
L.FLAG_TEMPLATE[5].description =		"Становится видимым, когда работает Ярмарка Новолуния и у персонажа нет Справочника ярмарки Новолуния."
L.FLAG_TEMPLATE[6] = {}
L.FLAG_TEMPLATE[6].title =				"Время Хроми"
L.FLAG_TEMPLATE[6].description =		"Становится видимым, когда персонаж находится в режиме Времени Хроми."
L.FLAG_TEMPLATE[7] = {}
L.FLAG_TEMPLATE[7].title =				"Купить свиток телепорта"
L.FLAG_TEMPLATE[7].description =		"Автоматически покупает Свиток телепортации: Театр Боли у Одноглазого Джоби, если у вас его нет. Этот флаг всегда скрыт."

-- Debugging
L.ERROR_UNKNOWN_EVENT =					"Неизвестное событие:"
L.ERROR_BLOCKED1 =						"Доступ к \"%s\" заблокирован"
L.ERROR_BLOCKED2 =						"Присваивание \"%s\" заблокировано"
L.FUNCTION_ERROR =						"Ошибка функции:"
L.FUNCTION_OUTPUT =						"Вывод функции:"
L.IMPORT_ERROR =						"Ошибка импорта:"
L.EXPORT_ERROR =						"Ошибка экспорта:"
L.ERROR_BLOCKED =						"%s был заблокирован"
L.ERROR_UNKNOWN =						"Произошла неизвестная ошибка"
L.ERROR_INVALID_IMPORT_STRING =			"Недопустимая строка импорта"
L.ERROR_DECODE =						"Неудачное декодирование #"	-- Followed by a number
-- L.FLAG_ERROR_LUA =						"Watchtower flag [%s] caused an error on '%s':"	-- The %s's are variale flag title and event name

-- General
L.NEW_VERSION_AVAILABLE =				"Доступна новая версия " .. app.NameLong .. ":"
L.SETTINGS_TOOLTIP =					app.NameLong .. "\n|cffFFFFFF"
 										.. app:ShowIcon(app.IconLMB) .. ": " .. L.SLASH_TOGGLE_EDITPANEL .. "\n"
 										.. app:ShowIcon(app.IconRMB) .. ": " .. L.SLASH_OPEN_SETTINGS

L.INVALID_COMMAND =						"Неверная команда"
L.OR =									"или"
