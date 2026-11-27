--------------------------
-- Watchtower: esMX.lua --
--------------------------
-- Spanish (Mexico) localisation
-- Translator(s): Ferran Carril

if GetLocale() ~= "esMX" then return end
local appName, app = ...
local L = app.locales

-- Core
L.NEW_VERSION_AVAILABLE =                "Hay una versión más nueva de %s disponible:" -- %s becomes the addon name

L.INVALID_COMMAND =                      "Comando no válido"

-- Settings
L.VERSION =                              GAME_VERSION_LABEL .. ":" -- "Version"
L.SUPPORT_TEXTLONG1 =                    "Desarrollar este addon requiere una cantidad significativa de tiempo y esfuerzo."
L.SUPPORT_TEXTLONG2 =                    "Por favor, considera apoyar financieramente al desarrollador."
L.SUPPORT =                              "Apoyar"
L.BUY_ME_A_COFFEE =                      "Buy Me a Coffee" -- Brand name, if there isn't a localised version, keep it the way it is
L.THANK_YOU =                            "¡Gracias!"
L.FEEDBACK_AND_HELP =                    "Comentarios y Ayuda"
L.DISCORD =                              "Discord" -- Brand name, if there isn't a localised version, keep it the way it is
L.JOIN_DISCORD_SERVER =                  "Únete al servidor de Discord."
L.CTRL_C_COPY =                          "Ctrl+C para copiar:"
L.LINK_COPIED =                          "Enlace copiado al portapapeles"

L.KEYBINDINGS_AND_SLASH_COMMANDS =       SETTINGS_KEYBINDINGS_LABEL .. " y Comandos" -- "Keybindings"
_G["BINDING_NAME_WATCHTOWER_TOGGLE"] =   app.NameShort .. ": Mostrar/ocultar panel de edición"
L.OR =                                   "o"
L.TOGGLE_EDIT_PANEL =                    "Mostrar/ocultar panel de edición"
L.OPEN_SETTINGS =                        "Abrir opciones"

L.GENERAL =                              GENERAL -- "General"
L.SHOW_MINIMAP_ICON =                    "Mostrar icono de minimapa"
L.SHOW_MINIMAP_ICON_DESC =               "Muestra el icono del minimapa. Si desactivas esto, %s sigue disponible en el apartado de Addons." -- %s becomes the addon name

-- Edit Panel
L.NEW_FLAG =                             "Nueva bandera"
L.NEW_GROUP =                            "Nuevo grupo"
L.INACTIVE =                             FACTION_INACTIVE -- "Inactive"
L.DELETE =                               DELETE -- "Delete"
L.IMPORT =                               HUD_EDIT_MODE_IMPORT_LAYOUT -- "Import"
L.EXPORT =                               "Exportar"
L.EXPORT_COPIED =                        "Cadena de exportación copiada al portapapeles"
L.DELETE_FLAG_Q =                        "¿Eliminar esta bandera?"
L.DELETE_GROUP_Q =                       "¿Eliminar este grupo?"
L.HOLD_SKIP =                            "Mantén pulsada Mayús para omitir esta confirmación."
L.CANTDELETE_GROUP =                     "No se puede eliminar un grupo que contiene banderas"
L.CANTMOVE_GROUP =                       "No se puede mover este grupo"

L.TUTORIAL_HEADER =                      "Readme.txt"
L.TUTORIAL_EXPLAIN1 =                    "Las banderas ejecutan código al producirse eventos y pueden mostrarse con un icono y un título."
L.TUTORIAL_EXPLAIN2 =                    "Las banderas del grupo Inactivo no se muestran ni se ejecutan (salvo durante la edición)."
L.TUTORIAL_TRIGGER =                     "Código del activador"
L.TUTORIAL_TRIGGER1 =                    "Puedes obtener el nombre y los argumentos del evento activado mediante:"
L.TUTORIAL_TRIGGER2 =                    "El código se ejecuta independientemente de la visibilidad de la bandera."
L.TUTORIAL_VISIBILITY =                  "Visibilidad"
L.TUTORIAL_VISIBILITY1 =                 "El código que devuelve un valor falso oculta la bandera:"
L.TUTORIAL_VISIBILITY2 =                 "El código que devuelve un valor verdadero muestra la bandera:"
L.TEST =                                 TEST_STRING_IGNORE_1 -- "Test"
L.TUTORIAL_TITLE =                       "Título de la bandera"
L.TUTORIAL_TITLE1 =                      "Si el código devuelve un número o una cadena de texto, ese valor se utilizará como título de la bandera."
L.TUTORIAL_WHAT =                        "¡No entiendo nada de esto! D:"
L.TUTORIAL_WHAT1 =                       "Puedes simplificarlo importando solo las banderas que quieras usar."
L.TUTORIAL_GETFLAGS =                    "¡Consigue banderas aquí!"
L.TUTORIAL_EXAMPLE_TITLE1 =              "Bandera inactiva"
L.TUTORIAL_EXAMPLE_TITLE2 =              "Bandera oculta"
L.TUTORIAL_EXAMPLE_SETTINGS =            "Abrir los ajustes de Watchtower"
L.TUTORIAL_EXAMPLE_INACTIVE =            "Puedes arrastrar esta bandera a otro grupo para activarla."
L.TUTORIAL_EXAMPLE_MOVE =                "Puedes mover grupos mientras este panel de edición esté abierto."

L.TITLE =                                LFG_LIST_TITLE -- "Title"
L.ICON =                                 EMBLEM_SYMBOL -- "Icon"
L.TRIGGER =                              "Activador"
L.EVENTS =                               EVENTS_LABEL -- "Events"
L.DESCRIPTION =                          DESCRIPTION -- "Description"
L.URL =                                  "URL"
L.TEMPLATES =                            "Plantillas"
L.OVERWRITE_FLAG =                       "¿Sobrescribir esta bandera con esta plantilla?"

L.STYLE =                                "Estilo"
L.GROUP_STYLE = {}
L.GROUP_STYLE[1] =                       "Iconos y texto"
L.GROUP_STYLE[2] =                       "|cff9D9D9DSolo iconos (próximamente™)"
L.ANCHOR =                               "Anclaje"
L.GROUP_ANCHOR = {}
L.GROUP_ANCHOR[1] =                      "Arriba izquierda"
L.GROUP_ANCHOR[2] =                      "Arriba derecha"
L.GROUP_ANCHOR[3] =                      "Abajo izquierda"
L.GROUP_ANCHOR[4] =                      "Abajo derecha"
L.FONT =                                 "Fuente"
L.SCALE =                                HOUSING_EXPERT_DECOR_SUBMODE_SCALE -- "Scale"

L.LOAD =                                 "Cargar"

L.LOADCONDITION_MATCH1 =                 "Coincidencia" -- followed by an any/all dropdown
L.LOADCONDITION_MATCH2 =                 "de estas condiciones para %s:" -- preceded by an any/all dropdown, %s becomes a flag or group name
L.LOADCONDITION_VALID =                  "La condición de carga es válida."
L.LOADCONDITION_INCOMPLETE =             "La condición de carga está incompleta."
L.LOADCONDITION_GROUP_HELP =             "Cargar este grupo solo cuando cumpla estas condiciones:"
L.LOADCONDITION_FLAG_HELP =              "Cargar esta bandera solo cuando cumpla estas condiciones:"
L.LOADCONDITION_GROUP_OVERRIDE =         "Las condiciones de carga están controladas por el grupo."
L.REVERT =                               COOLDOWN_VIEWER_SETTINGS_BUTTON_REVERT_CHANGES -- "Revert"
L.APPLY_CHANGES =                        TRANSMOG_SITUATIONS_APPLY -- "Apply Changes"

L.CONDITION = {}
L.CONDITION[1] =                         CHARACTER -- "Character"
L.CONDITION[2] =                         NAME -- "Name"
L.CONDITION[3] =                         LEVEL -- "Level"
L.CONDITION[4] =                         "Reino"
L.CONDITION[5] =                         TRANSMOG_SOURCE_6 -- "Profession"
L.CONDITION[6] =                         CLASS -- "Class"
L.CONDITION[7] =                         "Conjunto de reglas"
L.CONDITIONSTATE = {}
L.CONDITIONSTATE[1] =                    "cualquiera"
L.CONDITIONSTATE[2] =                    "todas"
L.CONDITIONSTATE[3] =                    "es menor que"
L.CONDITIONSTATE[4] =                    "es"
L.CONDITIONSTATE[5] =                    "es uno de"
L.CONDITIONSTATE[6] =                    "es mayor que"
L.CONDITIONSTATE[7] =                    "no es"
L.CONDITIONSTATE[8] =                    "no es ninguno de"
L.CONDITIONSTATE[9] =                    "empieza por"
L.CONDITIONSTATE[10] =                   "termina en"
L.CONDITIONSTATE[11] =                   "contiene"
L.CONDITIONSTATE[12] =                   "no contiene"
L.RULESET = {}
L.RULESET[1] =                           GDAPI_REALMTYPE_NORMAL -- "Normal"
L.RULESET[2] =                           GDAPI_REALMTYPE_PVP -- "PvP"
L.RULESET[3] =                           "Rol"
L.RULESET[4] =                           "Rol PvP"
L.RULESET[5] =                           GUILD_PLAYSTYLE_HARDCORE -- "Hardcore"

L.ACTIONS =                              DAMAGE_METER_CATEGORY_ACTIONS -- "Actions"

L.HIDE_AFTER =                           "Ocultar tras X segundos "

L.FLAG_TEMPLATE = {}
L.FLAG_TEMPLATE[1] = {}
L.FLAG_TEMPLATE[1].title =               "Comprar Marcas de honor"
L.FLAG_TEMPLATE[1].description =         "Se muestra cuando este personaje tiene 2000 puntos de honor o más, para recordarte que compres el cofre con 5 Marcas de honor."
L.FLAG_TEMPLATE[2] = {}
L.FLAG_TEMPLATE[2].title =               "Invasión de ciudadela"
L.FLAG_TEMPLATE[2].description =         "Se muestra si ningún personaje de tu cuenta ha completado una invasión de ciudadela (platino) esta semana."
L.FLAG_TEMPLATE[3] = {}
L.FLAG_TEMPLATE[3].title =               "Portal: Isla del Trueno"
L.FLAG_TEMPLATE[3].description =         "Se muestra si este personaje aún no ha desbloqueado el portal de las Estepas de Tong Long a la Isla del Trueno."
L.FLAG_TEMPLATE[4] = {}
L.FLAG_TEMPLATE[4].title =               "Mapa del tesoro descolorido"
L.FLAG_TEMPLATE[4].description =         "Se muestra si la Feria de la Luna Negra está activa y este personaje aún no ha completado la misión del Mapa del tesoro descolorido que otorga 100 vales de la Luna Negra."
L.FLAG_TEMPLATE[5] = {}
L.FLAG_TEMPLATE[5].title =               "Guía del aventurero de la Luna Negra"
L.FLAG_TEMPLATE[5].description =         "Se muestra si la Feria de la Luna Negra está activa y este personaje no tiene la Guía del aventurero de la Luna Negra."
L.FLAG_TEMPLATE[6] = {}
L.FLAG_TEMPLATE[6].title =               "Tiempo de Cromi"
L.FLAG_TEMPLATE[6].description =         "Se muestra cuando este personaje está en el Tiempo de Cromi."
L.FLAG_TEMPLATE[7] = {}
L.FLAG_TEMPLATE[7].title =               "Comprar Pergamino de teletransporte"
L.FLAG_TEMPLATE[7].description =         "Compra automáticamente un Pergamino de teletransporte: Teatro del Dolor a Joby Tuerto si aún no tienes uno. Esta bandera permanece siempre oculta."

-- Debugging
L.ERROR_UNKNOWN_EVENT =                  "Evento desconocido:"
L.ERROR_BLOCKED1 =                       "Se ha bloqueado el acceso a \"%s\"" -- %s becomes a function name
L.ERROR_BLOCKED2 =                       "Se ha bloqueado la asignación a \"%s\"" -- %s becomes a function name
L.FUNCTION_ERROR =                       "Error de función:"
L.FUNCTION_OUTPUT =                      "Salida de la función:"
L.IMPORT_ERROR =                         "Error de importación:"
L.EXPORT_ERROR =                         "Error de exportación:"
L.ERROR_BLOCKED =                        "Se ha bloqueado %s" -- %s becomes a flag name
L.ERROR_UNKNOWN =                        "Se ha producido un error desconocido"
L.ERROR_INVALID_IMPORT_STRING =          "Cadena de importación no válida"
L.ERROR_DECODE =                         "Error de decodificación #%d" -- %d becomes a number
L.FLAG_ERROR_LUA =                       "La bandera [%s] de Watchtower provocó un error en '%s':" -- %s becomes a flag name and event name
