--------------------------
-- Watchtower: deDE.lua --
--------------------------
-- German (Germany) localisation
-- Translator(s):

if GetLocale() ~= "deDE" then return end
local appName, app = ...
local L = app.locales

-- Core
L.NEW_VERSION_AVAILABLE =                "Eine neuere Version von %s ist verfügbar:" -- %s becomes the addon name

L.INVALID_COMMAND =                      "Ungültiger Befehl"

-- Settings
L.VERSION =                              GAME_VERSION_LABEL .. ":" -- "Version"
L.SUPPORT_TEXTLONG1 =                    "Die Entwicklung dieses Addons erfordert viel Zeit und Mühe."
L.SUPPORT_TEXTLONG2 =                    "Bitte erwäge, die Entwicklung finanziell zu unterstützen."
L.SUPPORT =                              "Unterstützen"
L.BUY_ME_A_COFFEE =                      "Buy Me a Coffee" -- Brand name, if there isn't a localised version, keep it the way it is
L.THANK_YOU =                            "Vielen Dank!"
L.FEEDBACK_AND_HELP =                    "Feedback und Hilfe"
L.DISCORD =                              "Discord" -- Brand name, if there isn't a localised version, keep it the way it is
L.JOIN_DISCORD_SERVER =                  "Discord-Server beitreten."
L.CTRL_C_COPY =                          "Strg+C zum Kopieren:"
L.LINK_COPIED =                          "Link in die Zwischenablage kopiert"

L.KEYBINDINGS_AND_SLASH_COMMANDS =       SETTINGS_KEYBINDINGS_LABEL .. " & Slash-Befehle" -- "Keybindings"
_G["BINDING_NAME_WATCHTOWER_TOGGLE"] =   app.NameShort .. ": Bearbeitungsfenster ein-/ausblenden"
L.OR =                                   "oder"
L.TOGGLE_EDIT_PANEL =                    "Bearbeitungsfenster ein-/ausblenden"
L.OPEN_SETTINGS =                        "Einstellungen öffnen"

L.GENERAL =                              GENERAL -- "General"
L.SHOW_MINIMAP_ICON =                    "Minikartensymbol anzeigen"
L.SHOW_MINIMAP_ICON_DESC =               "Zeigt das Minikartensymbol an. Wenn du dies deaktivierst, bleibt %s über das Addon-Fach erreichbar." -- %s becomes the addon name

-- Edit Panel
L.NEW_FLAG =                             "Neue Flag"
L.NEW_GROUP =                            "Neue Gruppe"
L.INACTIVE =                             FACTION_INACTIVE -- "Inactive"
L.DELETE_FLAG =                          "Flag löschen"
L.DELETE_GROUP =                         "Gruppe löschen"
L.IMPORT =                               HUD_EDIT_MODE_IMPORT_LAYOUT -- "Import"
L.EXPORT_FLAG =                          "Flag exportieren"
L.EXPORT_GROUP =                         "Gruppe exportieren"
L.EXPORT_COPIED =                        "Exportzeichenfolge in die Zwischenablage kopiert"
L.DELETE_FLAG_Q =                        "Diese Flag löschen?"
L.DELETE_GROUP_Q =                       "Diese Gruppe löschen?"
L.HOLD_SKIP =                            "Halte Umschalt gedrückt, um diese Bestätigung zu überspringen."
L.CANTDELETE_GROUP =                     "Gruppe mit Flags kann nicht gelöscht werden"
L.CANTMOVE_GROUP =                       "Diese Gruppe kann nicht verschoben werden"

L.TUTORIAL_HEADER =                      "Readme.txt"
L.TUTORIAL_EXPLAIN1 =                    "Flags führen bei Ereignissen Code aus und können über ein Symbol und einen Titel sichtbar gemacht werden."
L.TUTORIAL_EXPLAIN2 =                    "Flags in der inaktiven Gruppe werden weder angezeigt noch ausgeführt (außer beim Bearbeiten)."
L.TUTORIAL_TRIGGER =                     "Auslösercode"
L.TUTORIAL_TRIGGER1 =                    "Du kannst den Namen und die Argumente des auslösenden Ereignisses so abrufen:"
L.TUTORIAL_TRIGGER2 =                    "Code wird unabhängig von der Sichtbarkeit der Flag ausgeführt."
L.TUTORIAL_VISIBILITY =                  "Sichtbarkeit"
L.TUTORIAL_VISIBILITY1 =                 "Code, der einen falschen Wert zurückgibt, blendet die Flag aus:"
L.TUTORIAL_VISIBILITY2 =                 "Code, der einen wahren Wert zurückgibt, zeigt die Flag an:"
L.TEST =                                 TEST_STRING_IGNORE_1 -- "Test"
L.TUTORIAL_TITLE =                       "Flag-Titel"
L.TUTORIAL_TITLE1 =                      "Gibt der Code eine Zahl oder Zeichenfolge zurück, wird diese als Titel der Flag verwendet."
L.TUTORIAL_WHAT =                        "Ich verstehe kein Wort davon! D:"
L.TUTORIAL_WHAT1 =                       "Du kannst es dir leicht machen und einfach die gewünschten Flags importieren."
L.TUTORIAL_GETFLAGS =                    "Hier gibt es Flags!"
L.TUTORIAL_EXAMPLE_TITLE1 =              "Inaktive Flag"
L.TUTORIAL_EXAMPLE_TITLE2 =              "Ausgeblendete Flag"
L.TUTORIAL_EXAMPLE_SETTINGS =            "Watchtower-Einstellungen öffnen"
L.TUTORIAL_EXAMPLE_INACTIVE =            "Du kannst diese Flag in eine andere Gruppe ziehen, um sie zu aktivieren."
L.TUTORIAL_EXAMPLE_MOVE =                "Gruppen können verschoben werden, wenn dieses Bearbeitungsfenster geöffnet ist."

L.TITLE =                                LFG_LIST_TITLE -- "Title"
L.ICON =                                 EMBLEM_SYMBOL -- "Icon"
L.TRIGGER =                              "Auslöser"
L.EVENTS =                               EVENTS_LABEL -- "Events"
L.DESCRIPTION =                          DESCRIPTION -- "Description"
L.URL =                                  "URL"
L.TEMPLATES =                            "Vorlagen"
L.OVERWRITE_FLAG =                       "Diese Flag mit der Vorlage überschreiben?"

L.STYLE =                                "Stil"
L.GROUP_STYLE = {}
L.GROUP_STYLE[1] =                       "Symbole und Text"
L.GROUP_STYLE[2] =                       "|cff9D9D9DNur Symbole (bald™)"
L.ANCHOR =                               "Ankerpunkt"
L.GROUP_ANCHOR = {}
L.GROUP_ANCHOR[1] =                      "Oben links"
L.GROUP_ANCHOR[2] =                      "Oben rechts"
L.GROUP_ANCHOR[3] =                      "Unten links"
L.GROUP_ANCHOR[4] =                      "Unten rechts"
L.FONT =                                 "Schriftart"
L.SCALE =                                HOUSING_EXPERT_DECOR_SUBMODE_SCALE -- "Scale"

L.LOAD =                                 "Laden"

L.LOADCONDITION_MATCH1 =                 "Abgleichen" -- followed by an any/all dropdown
L.LOADCONDITION_MATCH2 =                 "dieser Bedingungen für %s:" -- preceded by an any/all dropdown, %s becomes a flag or group name
L.LOADCONDITION_VALID =                  "Ladebedingung ist gültig."
L.LOADCONDITION_INCOMPLETE =             "Ladebedingung ist unvollständig."
L.LOADCONDITION_GROUP_HELP =             "Diese Gruppe nur laden, wenn sie folgende Bedingungen erfüllt:"
L.LOADCONDITION_FLAG_HELP =              "Diese Flag nur laden, wenn sie folgende Bedingungen erfüllt:"
L.LOADCONDITION_GROUP_OVERRIDE =         "Ladebedingungen werden von der Gruppe verwaltet."
L.REVERT =                               COOLDOWN_VIEWER_SETTINGS_BUTTON_REVERT_CHANGES -- "Revert"
L.APPLY_CHANGES =                        TRANSMOG_SITUATIONS_APPLY -- "Apply Changes"

L.CONDITION = {}
L.CONDITION[1] =                         CHARACTER -- "Character"
L.CONDITION[2] =                         NAME -- "Name"
L.CONDITION[3] =                         LEVEL -- "Level"
L.CONDITION[4] =                         "Realm"
L.CONDITION[5] =                         TRANSMOG_SOURCE_6 -- "Profession"
L.CONDITION[6] =                         CLASS -- "Class"
L.CONDITION[7] =                         "Regelwerk"
L.CONDITIONSTATE = {}
L.CONDITIONSTATE[1] =                    "beliebig"
L.CONDITIONSTATE[2] =                    "alle"
L.CONDITIONSTATE[3] =                    "ist kleiner als"
L.CONDITIONSTATE[4] =                    "ist"
L.CONDITIONSTATE[5] =                    "ist eines von"
L.CONDITIONSTATE[6] =                    "ist größer als"
L.CONDITIONSTATE[7] =                    "ist nicht"
L.CONDITIONSTATE[8] =                    "ist keines von"
L.CONDITIONSTATE[9] =                    "beginnt mit"
L.CONDITIONSTATE[10] =                   "endet mit"
L.CONDITIONSTATE[11] =                   "enthält"
L.CONDITIONSTATE[12] =                   "enthält nicht"
L.RULESET = {}
L.RULESET[1] =                           GDAPI_REALMTYPE_NORMAL -- "Normal"
L.RULESET[2] =                           GDAPI_REALMTYPE_PVP -- "PvP"
L.RULESET[3] =                           "Rollenspiel"
L.RULESET[4] =                           "Rollenspiel-PvP"
L.RULESET[5] =                           GUILD_PLAYSTYLE_HARDCORE -- "Hardcore"


L.ACTIONS =                              DAMAGE_METER_CATEGORY_ACTIONS -- "Actions"

L.HIDE_AFTER =                           "Nach X Sekunden ausblenden "

L.FLAG_TEMPLATE = {}
L.FLAG_TEMPLATE[1] = {}
L.FLAG_TEMPLATE[1].title =               "Ehrenabzeichen kaufen"
L.FLAG_TEMPLATE[1].description =         "Wird sichtbar, wenn dieser Charakter mindestens 2000 Ehre hat, um an den Kauf des Behälters mit 5 Ehrenabzeichen zu erinnern."
L.FLAG_TEMPLATE[2] = {}
L.FLAG_TEMPLATE[2].title =               "Garnisonsinvasion"
L.FLAG_TEMPLATE[2].description =         "Wird sichtbar, wenn noch kein Charakter deines Accounts diese Woche eine (Platin-)Garnisonsinvasion abgeschlossen hat."
L.FLAG_TEMPLATE[3] = {}
L.FLAG_TEMPLATE[3].title =               "Portal: Insel des Donners"
L.FLAG_TEMPLATE[3].description =         "Wird sichtbar, wenn dieser Charakter das Portal von der Tonlongsteppe zur Insel des Donners noch nicht freigeschaltet hat."
L.FLAG_TEMPLATE[4] = {}
L.FLAG_TEMPLATE[4].title =               "Verblasste Schatzkarte"
L.FLAG_TEMPLATE[4].description =         "Wird sichtbar, wenn der Dunkelmond-Jahrmarkt stattfindet und dieser Charakter die Quest zur Verblassten Schatzkarte für 100 Dunkelmond-Gewinnlose noch nicht abgeschlossen hat."
L.FLAG_TEMPLATE[5] = {}
L.FLAG_TEMPLATE[5].title =               "Abenteurerführer des Dunkelmond-Jahrmarkts"
L.FLAG_TEMPLATE[5].description =         "Wird sichtbar, wenn der Dunkelmond-Jahrmarkt stattfindet und dieser Charakter keinen Abenteurerführer des Dunkelmond-Jahrmarkts besitzt."
L.FLAG_TEMPLATE[6] = {}
L.FLAG_TEMPLATE[6].title =               "Chromie-Zeit"
L.FLAG_TEMPLATE[6].description =         "Wird sichtbar, wenn dieser Charakter in der Chromie-Zeit ist."
L.FLAG_TEMPLATE[7] = {}
L.FLAG_TEMPLATE[7].title =               "Teleportationsschriftrolle kaufen"
L.FLAG_TEMPLATE[7].description =         "Kauft automatisch eine Teleportationsschriftrolle: Theater der Schmerzen bei Einäugiger Joby, wenn du noch keine hast. Diese Flagge bleibt immer ausgeblendet."

-- Debugging
L.ERROR_UNKNOWN_EVENT =                  "Unbekanntes Ereignis:"
L.ERROR_BLOCKED1 =                       "Zugriff auf \"%s\" ist blockiert" -- %s becomes a function name
L.ERROR_BLOCKED2 =                       "Zuweisung an \"%s\" ist blockiert" -- %s becomes a function name
L.FUNCTION_ERROR =                       "Funktionsfehler:"
L.FUNCTION_OUTPUT =                      "Funktionsausgabe:"
L.IMPORT_ERROR =                         "Importfehler:"
L.EXPORT_ERROR =                         "Exportfehler:"
L.ERROR_BLOCKED =                        "%s wurde blockiert" -- %s becomes a flag name
L.ERROR_UNKNOWN =                        "Ein unbekannter Fehler ist aufgetreten"
L.ERROR_INVALID_IMPORT_STRING =          "Ungültige Importzeichenfolge"
L.ERROR_DECODE =                         "Dekodierung fehlgeschlagen: #%d" -- %d becomes a number
L.FLAG_ERROR_LUA =                       "Watchtower-Flag [%s] hat bei '%s' einen Fehler verursacht:" -- %s becomes a flag name and event name
