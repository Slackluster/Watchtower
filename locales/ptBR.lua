--------------------------
-- Watchtower: ptBR.lua --
--------------------------
-- Portuguese (Brazil) localisation
-- Translator(s):

if GetLocale() ~= "ptBR" then return end
local appName, app = ...
local L = app.locales

-- Core
L.NEW_VERSION_AVAILABLE =                "Há uma versão mais recente de %s disponível:" -- %s becomes the addon name

L.INVALID_COMMAND =                      "Comando inválido"

-- Settings
L.VERSION =                              GAME_VERSION_LABEL .. ":" -- "Version"
L.SUPPORT_TEXTLONG1 =                    "Desenvolver este addon exige muito tempo e dedicação."
L.SUPPORT_TEXTLONG2 =                    "Considere apoiar financeiramente o desenvolvedor."
L.SUPPORT =                              "Apoiar"
L.BUY_ME_A_COFFEE =                      "Buy Me a Coffee" -- Brand name, if there isn't a localised version, keep it the way it is
L.THANK_YOU =                            "Obrigado!"
L.FEEDBACK_AND_HELP =                    "Comentários e Ajuda"
L.DISCORD =                              "Discord" -- Brand name, if there isn't a localised version, keep it the way it is
L.JOIN_DISCORD_SERVER =                  "Entre no servidor do Discord."
L.CTRL_C_COPY =                          "Ctrl+C para copiar:"
L.LINK_COPIED =                          "Link copiado para a área de transferência"

L.KEYBINDINGS_AND_SLASH_COMMANDS =       SETTINGS_KEYBINDINGS_LABEL .. " e comandos de barra" -- "Keybindings"
_G["BINDING_NAME_WATCHTOWER_TOGGLE"] =   app.NameShort .. ": Alternar painel de edição"
L.OR =                                   "ou"
L.TOGGLE_EDIT_PANEL =                    "Alternar painel de edição"
L.OPEN_SETTINGS =                        "Abrir as configurações"

L.GENERAL =                              GENERAL -- "General"
L.SHOW_MINIMAP_ICON =                    "Mostrar ícone no minimapa"
L.SHOW_MINIMAP_ICON_DESC =               "Mostra o ícone no minimapa. Se desativado, %s continuará disponível no Compartimento de Addons." -- %s becomes the addon name

-- Edit Panel
L.NEW_FLAG =                             "Novo sinalizador"
L.NEW_GROUP =                            "Novo grupo"
L.INACTIVE =                             FACTION_INACTIVE -- "Inactive"
L.DELETE =                               DELETE -- "Delete"
L.IMPORT =                               HUD_EDIT_MODE_IMPORT_LAYOUT -- "Import"
L.EXPORT =                               "Exportar"
L.EXPORT_COPIED =                        "Texto de exportação copiado para a área de transferência"
L.DELETE_FLAG_Q =                        "Excluir este sinalizador?"
L.DELETE_GROUP_Q =                       "Excluir este grupo?"
L.HOLD_SKIP =                            "Segure Shift para pular esta confirmação."
L.CANTDELETE_GROUP =                     "Não é possível excluir um grupo com sinalizadores"
L.CANTMOVE_GROUP =                       "Não é possível mover este grupo"

L.TUTORIAL_HEADER =                      "Readme.txt"
L.TUTORIAL_EXPLAIN1 =                    "Os sinalizadores executam código em eventos e podem ser exibidos com um ícone e um título."
L.TUTORIAL_EXPLAIN2 =                    "Sinalizadores no grupo Inativo não são exibidos nem executados (exceto durante a edição)."
L.TUTORIAL_TRIGGER =                     "Código de acionamento"
L.TUTORIAL_TRIGGER1 =                    "Você pode obter o nome e os argumentos do evento acionado usando:"
L.TUTORIAL_TRIGGER2 =                    "O código é executado independentemente da visibilidade do sinalizador."
L.TUTORIAL_VISIBILITY =                  "Visibilidade"
L.TUTORIAL_VISIBILITY1 =                 "O código que retorna um valor falso oculta o sinalizador:"
L.TUTORIAL_VISIBILITY2 =                 "O código que retorna um valor verdadeiro exibe o sinalizador:"
L.TEST =                                 TEST_STRING_IGNORE_1 -- "Test"
L.TUTORIAL_TITLE =                       "Título do sinalizador"
L.TUTORIAL_TITLE1 =                      "Se o código retornar um número ou texto, esse valor será usado como título do sinalizador."
L.TUTORIAL_WHAT =                        "Não faço ideia do que isso significa! D:"
L.TUTORIAL_WHAT1 =                       "Você pode facilitar as coisas importando apenas os sinalizadores que deseja usar."
L.TUTORIAL_GETFLAGS =                    "Encontre sinalizadores aqui!"
L.TUTORIAL_EXAMPLE_TITLE1 =              "Sinalizador inativo"
L.TUTORIAL_EXAMPLE_TITLE2 =              "Sinalizador oculto"
L.TUTORIAL_EXAMPLE_SETTINGS =            "Abrir configurações do Watchtower"
L.TUTORIAL_EXAMPLE_INACTIVE =            "Você pode arrastar este sinalizador para outro grupo para ativá-lo."
L.TUTORIAL_EXAMPLE_MOVE =                "Os grupos podem ser movidos enquanto este painel de edição estiver aberto."

L.TITLE =                                LFG_LIST_TITLE -- "Title"
L.ICON =                                 EMBLEM_SYMBOL -- "Icon"
L.TRIGGER =                              "Acionador"
L.EVENTS =                               EVENTS_LABEL -- "Events"
L.DESCRIPTION =                          DESCRIPTION -- "Description"
L.URL =                                  "URL"
L.TEMPLATES =                            "Modelos"
L.OVERWRITE_FLAG =                       "Sobrescrever este sinalizador com o modelo?"

L.STYLE =                                "Estilo"
L.GROUP_STYLE = {}
L.GROUP_STYLE[1] =                       "Ícones e texto"
L.GROUP_STYLE[2] =                       "|cff9D9D9DSomente ícones (em breve™)"
L.ANCHOR =                               "Âncora"
L.GROUP_ANCHOR = {}
L.GROUP_ANCHOR[1] =                      "Superior esquerdo"
L.GROUP_ANCHOR[2] =                      "Superior direito"
L.GROUP_ANCHOR[3] =                      "Inferior esquerdo"
L.GROUP_ANCHOR[4] =                      "Inferior direito"
L.FONT =                                 "Fonte"
L.SCALE =                                HOUSING_EXPERT_DECOR_SUBMODE_SCALE -- "Scale"

L.LOAD =                                 "Carregar"

L.LOADCONDITION_MATCH1 =                 "Corresponder" -- followed by an any/all dropdown
L.LOADCONDITION_MATCH2 =                 "destas condições para %s:" -- preceded by an any/all dropdown, %s becomes a flag or group name
L.LOADCONDITION_VALID =                  "A condição de carregamento é válida."
L.LOADCONDITION_INCOMPLETE =             "A condição de carregamento está incompleta."
L.LOADCONDITION_GROUP_HELP =             "Carregar este grupo somente quando atender a estas condições:"
L.LOADCONDITION_FLAG_HELP =              "Carregar este sinalizador somente quando atender a estas condições:"
L.LOADCONDITION_GROUP_OVERRIDE =         "Condições de carregamento controladas pelo grupo."
L.REVERT =                               COOLDOWN_VIEWER_SETTINGS_BUTTON_REVERT_CHANGES -- "Revert"
L.APPLY_CHANGES =                        TRANSMOG_SITUATIONS_APPLY -- "Apply Changes"

L.CONDITION = {}
L.CONDITION[1] =                         CHARACTER -- "Character"
L.CONDITION[2] =                         NAME -- "Name"
L.CONDITION[3] =                         LEVEL -- "Level"
L.CONDITION[4] =                         "Reino"
L.CONDITION[5] =                         TRANSMOG_SOURCE_6 -- "Profession"
L.CONDITION[6] =                         CLASS -- "Class"
L.CONDITION[7] =                         "Conjunto de regras"
L.CONDITIONSTATE = {}
L.CONDITIONSTATE[1] =                    "qualquer"
L.CONDITIONSTATE[2] =                    "todas"
L.CONDITIONSTATE[3] =                    "é menor que"
L.CONDITIONSTATE[4] =                    "é"
L.CONDITIONSTATE[5] =                    "é um de"
L.CONDITIONSTATE[6] =                    "é maior que"
L.CONDITIONSTATE[7] =                    "não é"
L.CONDITIONSTATE[8] =                    "não é nenhum de"
L.CONDITIONSTATE[9] =                    "começa com"
L.CONDITIONSTATE[10] =                   "termina com"
L.CONDITIONSTATE[11] =                   "contém"
L.CONDITIONSTATE[12] =                   "não contém"
L.RULESET = {}
L.RULESET[1] =                           GDAPI_REALMTYPE_NORMAL -- "Normal"
L.RULESET[2] =                           GDAPI_REALMTYPE_PVP -- "PvP"
L.RULESET[3] =                           "Interpretação de Papel"
L.RULESET[4] =                           "RP PvP"
L.RULESET[5] =                           GUILD_PLAYSTYLE_HARDCORE -- "Hardcore"

L.ACTIONS =                              DAMAGE_METER_CATEGORY_ACTIONS -- "Actions"

L.HIDE_AFTER =                           "Ocultar após X segundos "

L.FLAG_TEMPLATE = {}
L.FLAG_TEMPLATE[1] = {}
L.FLAG_TEMPLATE[1].title =               "Comprar Marcas de Honra"
L.FLAG_TEMPLATE[1].description =         "Fica visível quando este personagem tem 2.000 ou mais de Honra, para lembrar de comprar o baú com 5 Marcas de Honra."
L.FLAG_TEMPLATE[2] = {}
L.FLAG_TEMPLATE[2].title =               "Invasão da Guarnição"
L.FLAG_TEMPLATE[2].description =         "Fica visível se nenhum personagem da sua conta tiver concluído uma invasão de guarnição (Platina) nesta semana."
L.FLAG_TEMPLATE[3] = {}
L.FLAG_TEMPLATE[3].title =               "Portal: Ilha do Trovão"
L.FLAG_TEMPLATE[3].description =         "Fica visível quando este personagem ainda não desbloqueou o portal das Estepes de Taolong para a Ilha do Trovão."
L.FLAG_TEMPLATE[4] = {}
L.FLAG_TEMPLATE[4].title =               "Mapa do Tesouro Desbotado"
L.FLAG_TEMPLATE[4].description =         "Fica visível quando a Feira de Negraluna está ativa e este personagem ainda não concluiu a missão do Mapa do Tesouro Desbotado que concede 100 Cupons Premiados de Negraluna."
L.FLAG_TEMPLATE[5] = {}
L.FLAG_TEMPLATE[5].title =               "Guia do Aventureiro de Negraluna"
L.FLAG_TEMPLATE[5].description =         "Fica visível quando a Feira de Negraluna está ativa e este personagem não possui o Guia do Aventureiro de Negraluna."
L.FLAG_TEMPLATE[6] = {}
L.FLAG_TEMPLATE[6].title =               "Tempo de Crona"
L.FLAG_TEMPLATE[6].description =         "Fica visível quando este personagem está no Tempo de Crona."
L.FLAG_TEMPLATE[7] = {}
L.FLAG_TEMPLATE[7].title =               "Comprar Pergaminho de Teleporte"
L.FLAG_TEMPLATE[7].description =         "Compra automaticamente um Pergaminho de Teleporte: Teatro da Dor com Joby Caolho se você ainda não tiver um. Este sinalizador fica sempre oculto."

-- Debugging
L.ERROR_UNKNOWN_EVENT =                  "Evento desconhecido:"
L.ERROR_BLOCKED1 =                       "O acesso a \"%s\" está bloqueado" -- %s becomes a function name
L.ERROR_BLOCKED2 =                       "A atribuição a \"%s\" está bloqueada" -- %s becomes a function name
L.FUNCTION_ERROR =                       "Erro de função:"
L.FUNCTION_OUTPUT =                      "Saída da função:"
L.IMPORT_ERROR =                         "Erro ao importar:"
L.EXPORT_ERROR =                         "Erro ao exportar:"
L.ERROR_BLOCKED =                        "%s foi bloqueado" -- %s becomes a flag name
L.ERROR_UNKNOWN =                        "Ocorreu um erro desconhecido"
L.ERROR_INVALID_IMPORT_STRING =          "Texto de importação inválido"
L.ERROR_DECODE =                         "Falha na decodificação #%d" -- %d becomes a number
L.FLAG_ERROR_LUA =                       "O sinalizador [%s] do Watchtower causou um erro em '%s':" -- %s becomes a flag name and event name
