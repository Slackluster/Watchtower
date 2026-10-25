--------------------------
-- Watchtower: ruRU.lua --
--------------------------
-- Russian (Russia) localisation
-- Translator(s): ZamestoTV

if GetLocale() ~= "ruRU" then return end
local appName, app = ...
local L = app.locales

-- Core
L.NEW_VERSION_AVAILABLE =                "Доступна новая версия %s:" -- %s becomes the addon name

L.INVALID_COMMAND =                      "Неверная команда"

-- Settings
L.VERSION =                              GAME_VERSION_LABEL .. ":" -- "Version"
L.SUPPORT_TEXTLONG1 =                    "Разработка этого аддона требует значительного времени и усилий."
L.SUPPORT_TEXTLONG2 =                    "Пожалуйста, рассмотрите возможность финансовой поддержки разработчика."
L.SUPPORT =                              "Поддержать"
L.BUY_ME_A_COFFEE =                      "Buy Me a Coffee" -- Brand name, if there isn't a localised version, keep it the way it is
L.THANK_YOU =                            "Спасибо!"
L.FEEDBACK_AND_HELP =                    "Обратная связь и помощь"
L.DISCORD =                              "Discord" -- Brand name, if there isn't a localised version, keep it the way it is
L.JOIN_DISCORD_SERVER =                  "Присоединиться к серверу Discord."
L.CTRL_C_COPY =                          "Ctrl+C - скопировать:"
L.LINK_COPIED =                          "Ссылка скопирована в буфер обмена"

L.KEYBINDINGS_AND_SLASH_COMMANDS =       SETTINGS_KEYBINDINGS_LABEL .. " & Слэш-команды" -- "Keybindings"
_G["BINDING_NAME_WATCHTOWER_TOGGLE"] =   app.NameShort .. ": Включить панель редактирования"
L.OR =                                   "или"
L.TOGGLE_EDIT_PANEL =                    "Включить панель редактирования"
L.OPEN_SETTINGS =                        "Откройте настройки"

L.GENERAL =                              GENERAL -- "General"
L.SHOW_MINIMAP_ICON =                    "Показывать иконку на миникарте"
L.SHOW_MINIMAP_ICON_DESC =               "Показывать иконку на миникарте. Если вы отключите это, %s все еще доступен из отсека аддонов." -- %s becomes the addon name

-- Edit Panel
L.NEW_FLAG =                             "Новый флаг"
L.NEW_GROUP =                            "Новая группа"
L.INACTIVE =                             FACTION_INACTIVE -- "Inactive"
L.DELETE_FLAG =                          "Удалить флаг"
L.DELETE_GROUP =                         "Удалить группу"
L.IMPORT =                               HUD_EDIT_MODE_IMPORT_LAYOUT -- "Import"
L.EXPORT_FLAG =                          "Экспортировать флаг"
L.EXPORT_GROUP =                         "Экспортировать группу"
L.EXPORT_COPIED =                        "Экспортная строка скопирована в буфер обмена"
L.DELETE_FLAG_Q =                        "Удалить этот флаг?"
L.DELETE_GROUP_Q =                       "Удалить эту группу?"
L.HOLD_SKIP =                            "Удерживайте Shift, чтобы не спрашивать подтверждение."
L.CANTDELETE_GROUP =                     "Нельзя удалить группу с флагами внутри"
L.CANTMOVE_GROUP =                       "Невозможно переместить эту группу"

L.TUTORIAL_HEADER =                      "Readme.txt"
L.TUTORIAL_EXPLAIN1 =                    "Флаги запускают код при возникновении событий и могут быть отображены с помощью значка и заголовка."
L.TUTORIAL_EXPLAIN2 =                    "Флаги в группе Неактивные не отображаются и не запускаются (за исключением случаев редактирования)."
L.TUTORIAL_TRIGGER =                     "Код запуска"
L.TUTORIAL_TRIGGER1 =                    "Вы можете получить имя и аргументы сработавшего события, используя:"
L.TUTORIAL_TRIGGER2 =                    "Код выполняется независимо от видимости флага."
L.TUTORIAL_VISIBILITY =                  "Видимость"
L.TUTORIAL_VISIBILITY1 =                 "Код, возвращающий ложное значение, скрывает флаг:"
L.TUTORIAL_VISIBILITY2 =                 "Код, возвращающий истинное значение, отображает флаг:"
-- L.TEST =                                 TEST_STRING_IGNORE_1 -- "Test"
L.TUTORIAL_TITLE =                       "Название флага"
L.TUTORIAL_TITLE1 =                      "Код, возвращающий число или строку, установит заголовок флага в это значение."
L.TUTORIAL_WHAT =                        "Я ничего из этого не понимаю! D:"
L.TUTORIAL_WHAT1 =                       "Вы можете не беспокоиться и просто импортировать нужные вам флаги."
L.TUTORIAL_GETFLAGS =                    "Флаги можно приобрести здесь!"
L.TUTORIAL_EXAMPLE_TITLE1 =              "Неактивный флаг"
L.TUTORIAL_EXAMPLE_TITLE2 =              "Скрыть флаг"
L.TUTORIAL_EXAMPLE_SETTINGS =            "Открыть настройки Watchtower"
L.TUTORIAL_EXAMPLE_INACTIVE =            "Вы можете перетащить этот флаг в любую другую группу, чтобы активировать его."
L.TUTORIAL_EXAMPLE_MOVE =                "Перемещать группы можно, когда открыта эта панель редактирования."

L.TITLE =                                LFG_LIST_TITLE -- "Title"
L.ICON =                                 EMBLEM_SYMBOL -- "Icon"
L.TRIGGER =                              "Триггер"
L.EVENTS =                               EVENTS_LABEL -- "Events"
L.DESCRIPTION =                          DESCRIPTION -- "Description"
L.URL =                                  "URL"
L.TEMPLATES =                            "Шаблоны"
L.OVERWRITE_FLAG =                       "Перезаписать текущий флаг этим шаблоном?"

L.STYLE =                                "Стиль"
L.GROUP_STYLE = {}
L.GROUP_STYLE[1] =                       "Иконки и текст"
L.GROUP_STYLE[2] =                       "|cff9D9D9DТолько иконки (в разработке™)"
L.ANCHOR =                               "Точка привязки"
L.GROUP_ANCHOR = {}
L.GROUP_ANCHOR[1] =                      "Верхний левый"
L.GROUP_ANCHOR[2] =                      "Верхний правый"
L.GROUP_ANCHOR[3] =                      "Нижний левый"
L.GROUP_ANCHOR[4] =                      "Нижний правый"
L.FONT =                                 "Шрифт"
L.SCALE =                                HOUSING_EXPERT_DECOR_SUBMODE_SCALE -- "Scale"

L.LOAD =                                 "Загрузка"

L.ACTIONS =                              DAMAGE_METER_CATEGORY_ACTIONS -- "Actions"

L.HIDE_AFTER =                           "Скрыться через X секунд "

L.FLAG_TEMPLATE = {}
L.FLAG_TEMPLATE[1] = {}
L.FLAG_TEMPLATE[1].title =               "Купить Почетные знаки"
L.FLAG_TEMPLATE[1].description =         "Становится видимым, когда у персонажа ≥ 2000 чести - напоминание купить ящик с 5 Почетными знаками."
L.FLAG_TEMPLATE[2] = {}
L.FLAG_TEMPLATE[2].title =               "Вторжение в гарнизон"
L.FLAG_TEMPLATE[2].description =         "Становится видимым, если на аккаунте ни один персонаж ещё не завершил (платиновое) вторжение в гарнизон на этой неделе."
L.FLAG_TEMPLATE[3] = {}
L.FLAG_TEMPLATE[3].title =               "Портал: Остров Грома"
L.FLAG_TEMPLATE[3].description =         "Становится видимым, если персонаж ещё не открыл портал из Танлунских степей на Остров Грома."
L.FLAG_TEMPLATE[4] = {}
L.FLAG_TEMPLATE[4].title =               "Выцветшая карта сокровищ"
L.FLAG_TEMPLATE[4].description =         "Становится видимым, когда работает Ярмарка Новолуния и персонаж не выполнил квест Выцветшая карта сокровищ на 100 билетов Ярмарки Новолуния."
L.FLAG_TEMPLATE[5] = {}
L.FLAG_TEMPLATE[5].title =               "Справочник ярмарки Новолуния"
L.FLAG_TEMPLATE[5].description =         "Становится видимым, когда работает Ярмарка Новолуния и у персонажа нет Справочника ярмарки Новолуния."
L.FLAG_TEMPLATE[6] = {}
L.FLAG_TEMPLATE[6].title =               "Время Хроми"
L.FLAG_TEMPLATE[6].description =         "Становится видимым, когда персонаж находится в режиме Времени Хроми."
L.FLAG_TEMPLATE[7] = {}
L.FLAG_TEMPLATE[7].title =               "Купить свиток телепорта"
L.FLAG_TEMPLATE[7].description =         "Автоматически покупает Свиток телепортации: Театр Боли у Одноглазого Джоби, если у вас его нет. Этот флаг всегда скрыт."

-- Debugging
L.ERROR_UNKNOWN_EVENT =                  "Неизвестное событие:"
L.ERROR_BLOCKED1 =                       "Доступ к \"%s\" заблокирован"
L.ERROR_BLOCKED2 =                       "Присваивание \"%s\" заблокировано"
L.FUNCTION_ERROR =                       "Ошибка функции:"
L.FUNCTION_OUTPUT =                      "Вывод функции:"
L.IMPORT_ERROR =                         "Ошибка импорта:"
L.EXPORT_ERROR =                         "Ошибка экспорта:"
L.ERROR_BLOCKED =                        "%s был заблокирован"
L.ERROR_UNKNOWN =                        "Произошла неизвестная ошибка"
L.ERROR_INVALID_IMPORT_STRING =          "Недопустимая строка импорта"
L.ERROR_DECODE =                         "Неудачное декодирование #%d" -- %d becomes a number
L.FLAG_ERROR_LUA =                       "Флаг Watchtower [%s] вызвал ошибку в '%s':" -- %s becomes a flag name and event name
