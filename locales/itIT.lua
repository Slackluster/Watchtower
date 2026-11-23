--------------------------
-- Watchtower: itIT.lua --
--------------------------
-- Italian (Italy) localisation
-- Translator(s):

if GetLocale() ~= "itIT" then return end
local appName, app = ...
local L = app.locales

-- Core
L.NEW_VERSION_AVAILABLE =                "È disponibile una nuova versione di %s:" -- %s becomes the addon name

L.INVALID_COMMAND =                      "Comando non valido"

-- Settings
L.VERSION =                              GAME_VERSION_LABEL .. ":" -- "Version"
L.SUPPORT_TEXTLONG1 =                    "Lo sviluppo di questo addon richiede molto tempo e impegno."
L.SUPPORT_TEXTLONG2 =                    "Ti invitiamo a sostenere economicamente lo sviluppatore."
L.SUPPORT =                              "Supporto"
L.BUY_ME_A_COFFEE =                      "Buy Me a Coffee" -- Brand name, if there isn't a localised version, keep it the way it is
L.THANK_YOU =                            "Grazie!"
L.FEEDBACK_AND_HELP =                    "Feedback e aiuto"
L.DISCORD =                              "Discord" -- Brand name, if there isn't a localised version, keep it the way it is
L.JOIN_DISCORD_SERVER =                  "Entra nel server Discord."
L.CTRL_C_COPY =                          "Ctrl+C per copiare:"
L.LINK_COPIED =                          "Collegamento copiato negli appunti"

L.KEYBINDINGS_AND_SLASH_COMMANDS =       SETTINGS_KEYBINDINGS_LABEL .. " e comandi slash" -- "Keybindings"
_G["BINDING_NAME_WATCHTOWER_TOGGLE"] =   app.NameShort .. ": Mostra/nascondi pannello modifica"
L.OR =                                   "o"
L.TOGGLE_EDIT_PANEL =                    "Mostra/nascondi pannello di modifica"
L.OPEN_SETTINGS =                        "Apri le impostazioni"

L.GENERAL =                              GENERAL -- "General"
L.SHOW_MINIMAP_ICON =                    "Mostra icona minimappa"
L.SHOW_MINIMAP_ICON_DESC =               "Mostra l'icona sulla minimappa. Se disattivata, %s rimane disponibile dal Comparto addon." -- %s becomes the addon name

-- Edit Panel
L.NEW_FLAG =                             "Nuovo segnale"
L.NEW_GROUP =                            "Nuovo gruppo"
L.INACTIVE =                             FACTION_INACTIVE -- "Inactive"
L.DELETE_FLAG =                          "Elimina segnale"
L.DELETE_GROUP =                         "Elimina gruppo"
L.IMPORT =                               HUD_EDIT_MODE_IMPORT_LAYOUT -- "Import"
L.EXPORT_FLAG =                          "Esporta segnale"
L.EXPORT_GROUP =                         "Esporta gruppo"
L.EXPORT_COPIED =                        "Stringa di esportazione copiata negli appunti"
L.DELETE_FLAG_Q =                        "Eliminare questo segnale?"
L.DELETE_GROUP_Q =                       "Eliminare questo gruppo?"
L.HOLD_SKIP =                            "Tieni premuto Maiusc per saltare questa conferma."
L.CANTDELETE_GROUP =                     "Impossibile eliminare un gruppo che contiene segnali"
L.CANTMOVE_GROUP =                       "Impossibile spostare questo gruppo"

L.TUTORIAL_HEADER =                      "Readme.txt"
L.TUTORIAL_EXPLAIN1 =                    "I segnali eseguono codice in risposta agli eventi e possono essere visibili tramite un'icona e un titolo."
L.TUTORIAL_EXPLAIN2 =                    "I segnali nel gruppo Inattivo non vengono mostrati né eseguiti (tranne quando vengono modificati)."
L.TUTORIAL_TRIGGER =                     "Codice di attivazione"
L.TUTORIAL_TRIGGER1 =                    "Puoi ottenere il nome e gli argomenti dell'evento attivato usando:"
L.TUTORIAL_TRIGGER2 =                    "Il codice viene eseguito indipendentemente dalla visibilità del segnale."
L.TUTORIAL_VISIBILITY =                  "Visibilità"
L.TUTORIAL_VISIBILITY1 =                 "Il codice che restituisce un valore falso nasconde il segnale:"
L.TUTORIAL_VISIBILITY2 =                 "Il codice che restituisce un valore verdadeiro mostra il segnale:"
L.TEST =                                 TEST_STRING_IGNORE_1 -- "Test"
L.TUTORIAL_TITLE =                       "Titolo del segnale"
L.TUTORIAL_TITLE1 =                      "Se il codice restituisce un numero o una stringa, questi diventano il titolo del segnale."
L.TUTORIAL_WHAT =                        "Non ho idea di cosa significhi tutto questo! D:"
L.TUTORIAL_WHAT1 =                       "Puoi semplificarti la vita importando solo i segnali che vuoi usare."
L.TUTORIAL_GETFLAGS =                    "Trova qui i segnali!"
L.TUTORIAL_EXAMPLE_TITLE1 =              "Segnale inattivo"
L.TUTORIAL_EXAMPLE_TITLE2 =              "Segnale nascosto"
L.TUTORIAL_EXAMPLE_SETTINGS =            "Apri impostazioni di Watchtower"
L.TUTORIAL_EXAMPLE_INACTIVE =            "Puoi trascinare questo segnale in un altro gruppo per attivarlo."
L.TUTORIAL_EXAMPLE_MOVE =                "I gruppi possono essere spostati quando il pannello di modifica è aperto."

L.TITLE =                                LFG_LIST_TITLE -- "Title"
L.ICON =                                 EMBLEM_SYMBOL -- "Icon"
L.TRIGGER =                              "Attivazione"
L.EVENTS =                               EVENTS_LABEL -- "Events"
L.DESCRIPTION =                          DESCRIPTION -- "Description"
L.URL =                                  "URL"
L.TEMPLATES =                            "Modelli"
L.OVERWRITE_FLAG =                       "Sovrascrivere questo segnale con il modello?"

L.STYLE =                                "Stile"
L.GROUP_STYLE = {}
L.GROUP_STYLE[1] =                       "Icone e testo"
L.GROUP_STYLE[2] =                       "|cff9D9D9DSolo icone (presto™)"
L.ANCHOR =                               "Ancoraggio"
L.GROUP_ANCHOR = {}
L.GROUP_ANCHOR[1] =                      "In alto a sinistra"
L.GROUP_ANCHOR[2] =                      "In alto a destra"
L.GROUP_ANCHOR[3] =                      "In basso a sinistra"
L.GROUP_ANCHOR[4] =                      "In basso a destra"
L.FONT =                                 "Carattere"
L.SCALE =                                HOUSING_EXPERT_DECOR_SUBMODE_SCALE -- "Scale"

L.LOAD =                                 "Carica"

L.LOADCONDITION_MATCH1 =                 "Corrispondenza" -- followed by an any/all dropdown
L.LOADCONDITION_MATCH2 =                 "di queste condizioni per %s:" -- preceded by an any/all dropdown, %s becomes a flag or group name
L.LOADCONDITION_VALID =                  "La condizione di caricamento è valida."
L.LOADCONDITION_INCOMPLETE =             "La condizione di caricamento è incompleta."
L.LOADCONDITION_GROUP_HELP =             "Carica questo gruppo solo se soddisfa queste condizioni:"
L.LOADCONDITION_FLAG_HELP =              "Carica questo segnale solo se soddisfa queste condizioni:"
L.LOADCONDITION_GROUP_OVERRIDE =         "Condizioni di caricamento controllate dal gruppo."
L.REVERT =                               COOLDOWN_VIEWER_SETTINGS_BUTTON_REVERT_CHANGES -- "Revert"
L.APPLY_CHANGES =                        TRANSMOG_SITUATIONS_APPLY -- "Apply Changes"

L.CONDITION = {}
L.CONDITION[1] =                         CHARACTER -- "Character"
L.CONDITION[2] =                         NAME -- "Name"
L.CONDITION[3] =                         LEVEL -- "Level"
L.CONDITION[4] =                         "Reame"
L.CONDITION[5] =                         TRANSMOG_SOURCE_6 -- "Profession"
L.CONDITION[6] =                         CLASS -- "Class"
L.CONDITION[7] =                         "Regole"
L.CONDITIONSTATE = {}
L.CONDITIONSTATE[1] =                    "qualsiasi"
L.CONDITIONSTATE[2] =                    "tutte"
L.CONDITIONSTATE[3] =                    "è minore di"
L.CONDITIONSTATE[4] =                    "è"
L.CONDITIONSTATE[5] =                    "è uno di"
L.CONDITIONSTATE[6] =                    "è maggiore di"
L.CONDITIONSTATE[7] =                    "non è"
L.CONDITIONSTATE[8] =                    "non è nessuno di"
L.CONDITIONSTATE[9] =                    "inizia con"
L.CONDITIONSTATE[10] =                   "termina con"
L.CONDITIONSTATE[11] =                   "contiene"
L.CONDITIONSTATE[12] =                   "non contiene"
L.RULESET = {}
L.RULESET[1] =                           GDAPI_REALMTYPE_NORMAL -- "Normal"
L.RULESET[2] =                           GDAPI_REALMTYPE_PVP -- "PvP"
L.RULESET[3] =                           "Gioco di ruolo"
L.RULESET[4] =                           "Gioco di ruolo PvP"
L.RULESET[5] =                           GUILD_PLAYSTYLE_HARDCORE -- "Hardcore"

L.ACTIONS =                              DAMAGE_METER_CATEGORY_ACTIONS -- "Actions"

L.HIDE_AFTER =                           "Nascondi dopo X secondi "

L.FLAG_TEMPLATE = {}
L.FLAG_TEMPLATE[1] = {}
L.FLAG_TEMPLATE[1].title =               "Compra Distintivi d'Onore"
L.FLAG_TEMPLATE[1].description =         "Diventa visibile quando questo personaggio ha almeno 2000 Onore, per ricordarti di comprare il contenitore con 5 Distintivi d'Onore."
L.FLAG_TEMPLATE[2] = {}
L.FLAG_TEMPLATE[2].title =               "Invasione della guarnigione"
L.FLAG_TEMPLATE[2].description =         "Diventa visibile se nessun personaggio del tuo account ha ancora completato un'invasione della guarnigione (Platino) questa settimana."
L.FLAG_TEMPLATE[3] = {}
L.FLAG_TEMPLATE[3].title =               "Portale: Isola del Tuono"
L.FLAG_TEMPLATE[3].description =         "Diventa visibile se questo personaggio non ha ancora sbloccato il portale dalle Steppe di Tong Long all'Isola del Tuono."
L.FLAG_TEMPLATE[4] = {}
L.FLAG_TEMPLATE[4].title =               "Mappa del Tesoro Sbiadita"
L.FLAG_TEMPLATE[4].description =         "Diventa visibile quando la Fiera di Lunacupa è attiva e questo personaggio non ha ancora completato la missione della Mappa del Tesoro Sbiadita per 100 Buoni Premio di Lunacupa."
L.FLAG_TEMPLATE[5] = {}
L.FLAG_TEMPLATE[5].title =               "Guida dell'Avventuriero di Lunacupa"
L.FLAG_TEMPLATE[5].description =         "Diventa visibile quando la Fiera di Lunacupa è attiva e questo personaggio non possiede la Guida dell'Avventuriero di Lunacupa."
L.FLAG_TEMPLATE[6] = {}
L.FLAG_TEMPLATE[6].title =               "Tempo di Cromie"
L.FLAG_TEMPLATE[6].description =         "Diventa visibile quando questo personaggio è nel Tempo di Cromie."
L.FLAG_TEMPLATE[7] = {}
L.FLAG_TEMPLATE[7].title =               "Compra Pergamena di Teletrasporto"
L.FLAG_TEMPLATE[7].description =         "Acquista automaticamente una Pergamena di Teletrasporto: Teatro del Dolore da Joby l'Occisolo se non ne possiedi già una. Questo segnale rimane sempre nascosto."

-- Debugging
L.ERROR_UNKNOWN_EVENT =                  "Evento sconosciuto:"
L.ERROR_BLOCKED1 =                       "L'accesso a \"%s\" è bloccato" -- %s becomes a function name
L.ERROR_BLOCKED2 =                       "L'assegnazione a \"%s\" è bloccata" -- %s becomes a function name
L.FUNCTION_ERROR =                       "Errore di funzione:"
L.FUNCTION_OUTPUT =                      "Output della funzione:"
L.IMPORT_ERROR =                         "Errore di importazione:"
L.EXPORT_ERROR =                         "Errore di esportazione:"
L.ERROR_BLOCKED =                        "%s è stato bloccato" -- %s becomes a flag name
L.ERROR_UNKNOWN =                        "Si è verificato un errore sconosciuto"
L.ERROR_INVALID_IMPORT_STRING =          "Stringa di importazione non valida"
L.ERROR_DECODE =                         "Decodifica non riuscita #%d" -- %d becomes a number
L.FLAG_ERROR_LUA =                       "Il segnale Watchtower [%s] ha causato un errore su '%s':" -- %s becomes a flag name and event name
