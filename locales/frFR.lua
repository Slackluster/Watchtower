--------------------------
-- Watchtower: frFR.lua --
--------------------------
-- French (France) localisation
-- Translator(s): Klep-Ysondre

if GetLocale() ~= "frFR" then return end
local appName, app = ...
local L = app.locales

-- Core
L.NEW_VERSION_AVAILABLE =                "Une nouvelle version de %s est disponible :" -- %s becomes the addon name

L.INVALID_COMMAND =                      "Commande non valide"

-- Settings
L.VERSION =                              GAME_VERSION_LABEL .. " :" -- "Version"
L.SUPPORT_TEXTLONG1 =                    "Le développement de cette extension demande beaucoup de temps et d’efforts."
L.SUPPORT_TEXTLONG2 =                    "Veuillez envisager de soutenir financièrement le développeur."
L.SUPPORT =                              "Soutien"
L.BUY_ME_A_COFFEE =                      "Buy Me a Coffee" -- Brand name, if there isn't a localised version, keep it the way it is
L.THANK_YOU =                            "Merci !"
L.FEEDBACK_AND_HELP =                    "Commentaires et aide"
L.DISCORD =                              "Discord" -- Brand name, if there isn't a localised version, keep it the way it is
L.JOIN_DISCORD_SERVER =                  "Rejoignez le serveur Discord."
L.CTRL_C_COPY =                          "Ctrl + C pour copier :"
L.LINK_COPIED =                          "Lien copié dans le presse-papiers"

L.KEYBINDINGS_AND_SLASH_COMMANDS =       SETTINGS_KEYBINDINGS_LABEL .. " & Commandes « Slash »" -- "Keybindings"
_G["BINDING_NAME_WATCHTOWER_TOGGLE"] =   app.NameShort .. ": Afficher/masquer le panneau de modification"
L.OR =                                   "ou"
L.TOGGLE_EDIT_PANEL =                    "Afficher/masquer le panneau de modification"
L.OPEN_SETTINGS =                        "Ouvrir les paramètres"

L.GENERAL =                              GENERAL -- "General"
L.SHOW_MINIMAP_ICON =                    "Afficher le bouton de la mini-carte"
L.SHOW_MINIMAP_ICON_DESC =               "Afficher le bouton de la mini-carte. Si vous désactivez cette fonction, %s sera toujours disponible dans le panneau des addons." -- %s becomes the addon name

-- Edit Panel
L.NEW_FLAG =                             "Nouvel indicateur"
L.NEW_GROUP =                            "Nouveau groupe"
L.INACTIVE =                             FACTION_INACTIVE -- "Inactive"
L.DELETE =                               DELETE -- "Delete"
L.IMPORT =                               HUD_EDIT_MODE_IMPORT_LAYOUT -- "Import"
L.EXPORT =                               "Exporter"
L.EXPORT_COPIED =                        "Chaîne d'exportation copiée dans le presse-papiers"
L.DELETE_FLAG_Q =                        "Supprimer cet indicateur ?"
L.DELETE_GROUP_Q =                       "Supprimer ce groupe ?"
L.HOLD_SKIP =                            "Maintenez Maj enfoncée pour ignorer cette confirmation."
L.CANTDELETE_GROUP =                     "Impossible de supprimer un groupe contenant des indicateurs"
L.CANTMOVE_GROUP =                       "Impossible de déplacer ce groupe"

L.TUTORIAL_HEADER =                      "Readme.txt"
L.TUTORIAL_EXPLAIN1 =                    "Les indicateurs exécutent du code lors d'événements et peuvent être affichés avec une icône et un titre."
L.TUTORIAL_EXPLAIN2 =                    "Les indicateurs du groupe Inactif ne sont ni affichés ni exécutés (sauf pendant la modification)."
L.TUTORIAL_TRIGGER =                     "Code de déclenchement"
L.TUTORIAL_TRIGGER1 =                    "Vous pouvez récupérer le nom et les arguments de l'événement déclencheur avec :"
L.TUTORIAL_TRIGGER2 =                    "Le code s'exécute que l'indicateur soit visible ou non."
L.TUTORIAL_VISIBILITY =                  "Visibilité"
L.TUTORIAL_VISIBILITY1 =                 "Le code qui renvoie une valeur fausse masque l'indicateur :"
L.TUTORIAL_VISIBILITY2 =                 "Le code qui renvoie une valeur vraie affiche l'indicateur :"
L.TEST =                                 TEST_STRING_IGNORE_1 -- "Test"
L.TUTORIAL_TITLE =                       "Titre de l'indicateur"
L.TUTORIAL_TITLE1 =                      "Si le code renvoie un nombre ou une chaîne, cette valeur devient le titre de l'indicateur."
L.TUTORIAL_WHAT =                        "Je ne comprends rien à tout ça ! D:"
L.TUTORIAL_WHAT1 =                       "Vous pouvez vous simplifier la tâche en important uniquement les indicateurs souhaités."
L.TUTORIAL_GETFLAGS =                    "Trouvez des indicateurs ici !"
L.TUTORIAL_EXAMPLE_TITLE1 =              "Indicateur inactif"
L.TUTORIAL_EXAMPLE_TITLE2 =              "Indicateur masqué"
L.TUTORIAL_EXAMPLE_SETTINGS =            "Ouvrir les paramètres de Watchtower"
L.TUTORIAL_EXAMPLE_INACTIVE =            "Vous pouvez faire glisser cet indicateur vers un autre groupe pour l'activer."
L.TUTORIAL_EXAMPLE_MOVE =                "Les groupes peuvent être déplacés lorsque cette fenêtre de modification est ouverte."

L.TITLE =                                LFG_LIST_TITLE -- "Title"
L.ICON =                                 EMBLEM_SYMBOL -- "Icon"
L.TRIGGER =                              "Déclencheur"
L.EVENTS =                               EVENTS_LABEL -- "Events"
L.DESCRIPTION =                          DESCRIPTION -- "Description"
L.URL =                                  "URL"
L.TEMPLATES =                            "Modèles"
L.OVERWRITE_FLAG =                       "Remplacer cet indicateur par ce modèle ?"

L.STYLE =                                "Style"
L.GROUP_STYLE = {}
L.GROUP_STYLE[1] =                       "Icônes et texte"
L.GROUP_STYLE[2] =                       "|cff9D9D9DIcônes uniquement (bientôt™)"
L.ANCHOR =                               "Point d'ancrage"
L.GROUP_ANCHOR = {}
L.GROUP_ANCHOR[1] =                      "Haut gauche"
L.GROUP_ANCHOR[2] =                      "Haut droite"
L.GROUP_ANCHOR[3] =                      "Bas gauche"
L.GROUP_ANCHOR[4] =                      "Bas droite"
L.FONT =                                 "Police"
L.SCALE =                                HOUSING_EXPERT_DECOR_SUBMODE_SCALE -- "Scale"

L.LOAD =                                 "Charger"

L.LOADCONDITION_MATCH1 =                 "Correspondance" -- followed by an any/all dropdown
L.LOADCONDITION_MATCH2 =                 "de ces conditions pour %s :" -- preceded by an any/all dropdown, %s becomes a flag or group name
L.LOADCONDITION_VALID =                  "La condition de chargement est valide."
L.LOADCONDITION_INCOMPLETE =             "La condition de chargement est incomplète."
L.LOADCONDITION_GROUP_HELP =             "Charger ce groupe uniquement s'il remplit ces conditions :"
L.LOADCONDITION_FLAG_HELP =              "Charger cet indicateur uniquement s'il remplit ces conditions :"
L.LOADCONDITION_GROUP_OVERRIDE =         "Conditions de chargement contrôlées par le groupe."
L.REVERT =                               COOLDOWN_VIEWER_SETTINGS_BUTTON_REVERT_CHANGES -- "Revert"
L.APPLY_CHANGES =                        TRANSMOG_SITUATIONS_APPLY -- "Apply Changes"

L.CONDITION = {}
L.CONDITION[1] =                         CHARACTER -- "Character"
L.CONDITION[2] =                         NAME -- "Name"
L.CONDITION[3] =                         LEVEL -- "Level"
L.CONDITION[4] =                         "Royaume"
L.CONDITION[5] =                         TRANSMOG_SOURCE_6 -- "Profession"
L.CONDITION[6] =                         CLASS -- "Class"
L.CONDITION[7] =                         "Ensemble de règles"
L.CONDITIONSTATE = {}
L.CONDITIONSTATE[1] =                    "n'importe lequel"
L.CONDITIONSTATE[2] =                    "toutes"
L.CONDITIONSTATE[3] =                    "est inférieur à"
L.CONDITIONSTATE[4] =                    "est"
L.CONDITIONSTATE[5] =                    "est l'un de"
L.CONDITIONSTATE[6] =                    "est supérieur à"
L.CONDITIONSTATE[7] =                    "n'est pas"
L.CONDITIONSTATE[8] =                    "n'est aucun de"
L.CONDITIONSTATE[9] =                    "commence par"
L.CONDITIONSTATE[10] =                   "se termine par"
L.CONDITIONSTATE[11] =                   "contient"
L.CONDITIONSTATE[12] =                   "ne contient pas"
L.RULESET = {}
L.RULESET[1] =                           GDAPI_REALMTYPE_NORMAL -- "Normal"
L.RULESET[2] =                           GDAPI_REALMTYPE_PVP -- "PvP"
L.RULESET[3] =                           "Jeu de rôle"
L.RULESET[4] =                           "Jeu de rôle JcJ"
L.RULESET[5] =                           GUILD_PLAYSTYLE_HARDCORE -- "Hardcore"

L.ACTIONS =                              DAMAGE_METER_CATEGORY_ACTIONS -- "Actions"

L.HIDE_AFTER =                           "Masquer après X secondes "

L.FLAG_TEMPLATE = {}
L.FLAG_TEMPLATE[1] = {}
L.FLAG_TEMPLATE[1].title =               "Acheter des Marques d'honneur"
L.FLAG_TEMPLATE[1].description =         "Devient visible lorsque ce personnage possède au moins 2 000 points d'honneur, pour rappeler d'acheter le coffre contenant 5 Marques d'honneur."
L.FLAG_TEMPLATE[2] = {}
L.FLAG_TEMPLATE[2].title =               "Invasion de fief"
L.FLAG_TEMPLATE[2].description =         "Devient visible si aucun personnage de votre compte n'a terminé une invasion de fief (Platine) cette semaine."
L.FLAG_TEMPLATE[3] = {}
L.FLAG_TEMPLATE[3].title =               "Portail : île du Tonnerre"
L.FLAG_TEMPLATE[3].description =         "Devient visible lorsque ce personnage n'a pas encore débloqué le portail des steppes de Tanglong vers l'île du Tonnerre."
L.FLAG_TEMPLATE[4] = {}
L.FLAG_TEMPLATE[4].title =               "Carte au trésor délavée"
L.FLAG_TEMPLATE[4].description =         "Devient visible lorsque la foire de Sombrelune est active et que ce personnage n'a pas encore terminé la quête de la Carte au trésor délavée pour 100 bons pour un prix de Sombrelune."
L.FLAG_TEMPLATE[5] = {}
L.FLAG_TEMPLATE[5].title =               "Guide de l'aventurier de Sombrelune"
L.FLAG_TEMPLATE[5].description =         "Devient visible lorsque la foire de Sombrelune est active et que ce personnage ne possède pas le Guide de l'aventurier de Sombrelune."
L.FLAG_TEMPLATE[6] = {}
L.FLAG_TEMPLATE[6].title =               "Temps de Chromie"
L.FLAG_TEMPLATE[6].description =         "Devient visible lorsque ce personnage est dans le Temps de Chromie."
L.FLAG_TEMPLATE[7] = {}
L.FLAG_TEMPLATE[7].title =               "Acheter un Parchemin de téléportation"
L.FLAG_TEMPLATE[7].description =         "Achète automatiquement un Parchemin de téléportation : Théâtre de la Souffrance auprès de Joby le Borgne si vous n'en avez pas. Cet indicateur reste toujours masqué."

-- Debugging
L.ERROR_UNKNOWN_EVENT =                  "Événement inconnu :"
L.ERROR_BLOCKED1 =                       "L'accès à \"%s\" est bloqué" -- %s becomes a function name
L.ERROR_BLOCKED2 =                       "L'attribution à \"%s\" est bloquée" -- %s becomes a function name
L.FUNCTION_ERROR =                       "Erreur de fonction :"
L.FUNCTION_OUTPUT =                      "Sortie de fonction :"
L.IMPORT_ERROR =                         "Erreur d'importation :"
L.EXPORT_ERROR =                         "Erreur d'exportation :"
L.ERROR_BLOCKED =                        "%s a été bloqué" -- %s becomes a flag name
L.ERROR_UNKNOWN =                        "Une erreur inconnue est survenue"
L.ERROR_INVALID_IMPORT_STRING =          "Chaîne d'importation invalide"
L.ERROR_DECODE =                         "Échec du décodage n° %d" -- %d becomes a number
L.FLAG_ERROR_LUA =                       "L'indicateur Watchtower [%s] a provoqué une erreur sur « %s » :" -- %s becomes a flag name and event name
