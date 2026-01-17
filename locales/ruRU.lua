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

Edit Panel
L.NEW_FLAG =							"Новый флаг"
L.NEW_GROUP =							"Новая группа"
L.INACTIVE =							FACTION_INACTIVE
L.DELETE_FLAG =							"Удалить флаг"
L.DELETE_GROUP =						"Удалить группу"
L.IMPORT =								HUD_EDIT_MODE_IMPORT_LAYOUT
L.EXPORT_FLAG =							"Экспортировать флаг"
L.EXPORT_GROUP =						"Экспортировать группу"
L.DELETE_FLAG_Q =						"Удалить этот флаг?"
L.DELETE_GROUP_Q =						"Удалить эту группу?"
L.HOLD_SKIP =							"Удерживайте Shift, чтобы не спрашивать подтверждение."
L.CANTDELETE_GROUP =					"Нельзя удалить группу с флагами внутри."
L.CANTMOVE_GROUP =						"Невозможно переместить эту группу"

L.TITLE =								LFG_LIST_TITLE
L.ICON =								EMBLEM_SYMBOL
L.TRIGGER =								"Триггер"
L.EVENTS =								EVENTS_LABEL
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
L.SCALE =								HOUSING_EXPERT_DECOR_SUBMODE_SCALE

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
L.ERROR_UNKNOWN_EVENT =					"Попытка зарегистрировать неизвестное событие"
L.ERROR_BLOCKED1 =						"Доступ к \"%s\" заблокирован"
L.ERROR_BLOCKED2 =						"Присваивание \"%s\" заблокировано"
L.ERROR_FUNCTION =						"Ошибка функции:"
L.RETURN_FUNCTION =						"Функция вернула:"

-- General
L.NEW_VERSION_AVAILABLE =				"Доступна новая версия " .. app.NameLong .. ":"
L.SETTINGS_TOOLTIP =					app.NameLong .. "\n|cffFFFFFF"
 										.. app:ShowIcon(app.IconLMB) .. ": " .. L.SLASH_TOGGLE_EDITPANEL .. "\n"
 										.. app:ShowIcon(app.IconRMB) .. ": " .. L.SLASH_OPEN_SETTINGS

L.INVALID_COMMAND =						"Неверная команда."
L.OR =									"или"
