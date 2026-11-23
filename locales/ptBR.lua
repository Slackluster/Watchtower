--------------------------
-- Watchtower: ptBR.lua --
--------------------------
-- Portuguese (Brazil) localisation
-- Translator(s):

if GetLocale() ~= "ptBR" then return end
local appName, app = ...
local L = app.locales

-- Core
-- L.NEW_VERSION_AVAILABLE =                "There is a newer version of %s available:" -- %s becomes the addon name

-- L.INVALID_COMMAND =                      "Invalid command"

-- Settings
-- L.VERSION =                              GAME_VERSION_LABEL .. ":" -- "Version"
-- L.SUPPORT_TEXTLONG1 =                    "Developing this addon takes a significant amount of time and effort."
-- L.SUPPORT_TEXTLONG2 =                    "Please consider financially supporting the developer."
-- L.SUPPORT =                              "Support"
-- L.BUY_ME_A_COFFEE =                      "Buy Me a Coffee" -- Brand name, if there isn't a localised version, keep it the way it is
-- L.THANK_YOU =                            "Thank you!"
-- L.FEEDBACK_AND_HELP =                    "Feedback & Help"
-- L.DISCORD =                              "Discord" -- Brand name, if there isn't a localised version, keep it the way it is
-- L.JOIN_DISCORD_SERVER =                  "Join the Discord server."
-- L.CTRL_C_COPY =                          "Ctrl+C to copy:"
-- L.LINK_COPIED =                          "Link copied to clipboard"

-- L.KEYBINDINGS_AND_SLASH_COMMANDS =       SETTINGS_KEYBINDINGS_LABEL .. " & Slash Commands" -- "Keybindings"
-- _G["BINDING_NAME_WATCHTOWER_TOGGLE"] =   app.NameShort .. ": Toggle Edit Panel"
-- L.OR =                                   "or"
-- L.TOGGLE_EDIT_PANEL =                    "Toggle the edit panel"
-- L.OPEN_SETTINGS =                        "Open the settings"

-- L.GENERAL =                              GENERAL -- "General"
-- L.SHOW_MINIMAP_ICON =                    "Show Minimap Icon"
-- L.SHOW_MINIMAP_ICON_DESC =               "Show the minimap icon. If you disable this, %s is still available from the Addon Compartment." -- %s becomes the addon name

-- Edit Panel
-- L.NEW_FLAG =                             "New Flag"
-- L.NEW_GROUP =                            "New Group"
-- L.INACTIVE =                             FACTION_INACTIVE -- "Inactive"
-- L.DELETE_FLAG =                          "Delete Flag"
-- L.DELETE_GROUP =                         "Delete Group"
-- L.IMPORT =                               HUD_EDIT_MODE_IMPORT_LAYOUT -- "Import"
-- L.EXPORT_FLAG =                          "Export Flag"
-- L.EXPORT_GROUP =                         "Export Group"
-- L.EXPORT_COPIED =                        "Export string copied to clipboard"
-- L.DELETE_FLAG_Q =                        "Delete this flag?"
-- L.DELETE_GROUP_Q =                       "Delete this group?"
-- L.HOLD_SKIP =                            "Hold Shift to skip this confirmation."
-- L.CANTDELETE_GROUP =                     "Can't delete a group with flags"
-- L.CANTMOVE_GROUP =                       "Can't move this group"

-- L.TUTORIAL_HEADER =                      "Readme.txt"
-- L.TUTORIAL_EXPLAIN1 =                    "Flags run code on events and can be made visible via an icon and title."
-- L.TUTORIAL_EXPLAIN2 =                    "Flags in the Inactive group don't show or run (except when edited)."
-- L.TUTORIAL_TRIGGER =                     "Trigger code"
-- L.TUTORIAL_TRIGGER1 =                    "You can grab the triggered event's name and arguments using:"
-- L.TUTORIAL_TRIGGER2 =                    "Code runs regardless of the flag's visibility."
-- L.TUTORIAL_VISIBILITY =                  "Visibility"
-- L.TUTORIAL_VISIBILITY1 =                 "Code that returns falsy hides the flag:"
-- L.TUTORIAL_VISIBILITY2 =                 "Code that returns truthy shows the flag:"
-- L.TEST =                                 TEST_STRING_IGNORE_1 -- "Test"
-- L.TUTORIAL_TITLE =                       "Flag title"
-- L.TUTORIAL_TITLE1 =                      "Code returning a number or string will set the flag's title to that value."
-- L.TUTORIAL_WHAT =                        "I don't know what any of this means! D:"
-- L.TUTORIAL_WHAT1 =                       "You can take it easy and just import the flags you want to use."
-- L.TUTORIAL_GETFLAGS =                    "Get flags here!"
-- L.TUTORIAL_EXAMPLE_TITLE1 =              "Inactive flag"
-- L.TUTORIAL_EXAMPLE_TITLE2 =              "Hidden flag"
-- L.TUTORIAL_EXAMPLE_SETTINGS =            "Open Watchtower settings"
-- L.TUTORIAL_EXAMPLE_INACTIVE =            "You can drag this flag to any other group to make it active."
-- L.TUTORIAL_EXAMPLE_MOVE =                "Groups can be moved when this edit panel is open."

-- L.TITLE =                                LFG_LIST_TITLE -- "Title"
-- L.ICON =                                 EMBLEM_SYMBOL -- "Icon"
-- L.TRIGGER =                              "Trigger"
-- L.EVENTS =                               EVENTS_LABEL -- "Events"
-- L.DESCRIPTION =                          DESCRIPTION -- "Description"
-- L.URL =                                  "URL"
-- L.TEMPLATES =                            "Templates"
-- L.OVERWRITE_FLAG =                       "Overwrite this flag with this template?"

-- L.STYLE =                                "Style"
-- L.GROUP_STYLE = {}
-- L.GROUP_STYLE[1] =                       "Icons and Text"
-- L.GROUP_STYLE[2] =                       "|cff9D9D9DIcons Only (Soon™)"
-- L.ANCHOR =                               "Anchor"
-- L.GROUP_ANCHOR = {}
-- L.GROUP_ANCHOR[1] =                      "Top Left"
-- L.GROUP_ANCHOR[2] =                      "Top Right"
-- L.GROUP_ANCHOR[3] =                      "Bottom Left"
-- L.GROUP_ANCHOR[4] =                      "Bottom Right"
-- L.FONT =                                 "Font"
-- L.SCALE =                                HOUSING_EXPERT_DECOR_SUBMODE_SCALE -- "Scale"

-- L.LOAD =                                 "Load"

-- L.LOADCONDITION_MATCH1 =                 "Match" -- followed by an any/all dropdown
-- L.LOADCONDITION_MATCH2 =                 "of these conditions for %s:" -- preceded by an any/all dropdown, %s becomes a flag or group name
-- L.LOADCONDITION_VALID =                  "Load condition is valid."
-- L.LOADCONDITION_INCOMPLETE =             "Load condition is incomplete."
-- L.LOADCONDITION_GROUP_HELP =             "Only load this group when it matches these conditions:"
-- L.LOADCONDITION_FLAG_HELP =              "Only load this flag when it matches these conditions:"
-- L.LOADCONDITION_GROUP_OVERRIDE =         "Load conditions controlled by group."
-- L.REVERT =                               COOLDOWN_VIEWER_SETTINGS_BUTTON_REVERT_CHANGES -- "Revert"
-- L.APPLY_CHANGES =                        TRANSMOG_SITUATIONS_APPLY -- "Apply Changes"

-- L.CONDITION = {}
-- L.CONDITION[1] =                         CHARACTER -- "Character"
-- L.CONDITION[2] =                         NAME -- "Name"
-- L.CONDITION[3] =                         LEVEL -- "Level"
-- L.CONDITION[4] =                         "Realm"
-- L.CONDITION[5] =                         TRANSMOG_SOURCE_6 -- "Profession"
-- L.CONDITION[6] =                         CLASS -- "Class"
-- L.CONDITION[7] =                         "Ruleset"
-- L.CONDITIONSTATE = {}
-- L.CONDITIONSTATE[1] =                    "any"
-- L.CONDITIONSTATE[2] =                    "all"
-- L.CONDITIONSTATE[3] =                    "is less than"
-- L.CONDITIONSTATE[4] =                    "is"
-- L.CONDITIONSTATE[5] =                    "is any of"
-- L.CONDITIONSTATE[6] =                    "is greater than"
-- L.CONDITIONSTATE[7] =                    "is not"
-- L.CONDITIONSTATE[8] =                    "is not any of"
-- L.CONDITIONSTATE[9] =                    "starts with"
-- L.CONDITIONSTATE[10] =                   "ends with"
-- L.CONDITIONSTATE[11] =                   "contains"
-- L.CONDITIONSTATE[12] =                   "does not contain"
-- L.RULESET = {}
-- L.RULESET[1] =                           GDAPI_REALMTYPE_NORMAL -- "Normal"
-- L.RULESET[2] =                           GDAPI_REALMTYPE_PVP -- "PvP"
-- L.RULESET[3] =                           "Roleplay"
-- L.RULESET[4] =                           "Roleplay PvP"
-- L.RULESET[5] =                           GUILD_PLAYSTYLE_HARDCORE -- "Hardcore"

-- L.ACTIONS =                              DAMAGE_METER_CATEGORY_ACTIONS -- "Actions"

-- L.HIDE_AFTER =                           "Hide after X seconds "

-- L.FLAG_TEMPLATE = {}
-- L.FLAG_TEMPLATE[1] = {}
-- L.FLAG_TEMPLATE[1].title =               "Buy Marks of Honor"
-- L.FLAG_TEMPLATE[1].description =         "Becomes visible when this character has 2000 or more Honor, as a reminder to buy the cache that contains 5 Marks of Honor."
-- L.FLAG_TEMPLATE[2] = {}
-- L.FLAG_TEMPLATE[2].title =               "Garrison Invasion"
-- L.FLAG_TEMPLATE[2].description =         "Becomes visible when no character on your account has completed a (Platinum) Garrison invasion yet this week."
-- L.FLAG_TEMPLATE[3] = {}
-- L.FLAG_TEMPLATE[3].title =               "Portal: Isle of Thunder"
-- L.FLAG_TEMPLATE[3].description =         "Becomes visible when this character has not yet unlocked the portal from Townlong Steppes to the Isle of Thunder."
-- L.FLAG_TEMPLATE[4] = {}
-- L.FLAG_TEMPLATE[4].title =               "Faded Treasure Map"
-- L.FLAG_TEMPLATE[4].description =         "Becomes visible if the Darkmoon Faire is up, and this character has not completed the Faded Treasure Map quest for 100 Darkmoon Prize Tickets."
-- L.FLAG_TEMPLATE[5] = {}
-- L.FLAG_TEMPLATE[5].title =               "Darkmoon Adventurer's Guide"
-- L.FLAG_TEMPLATE[5].description =         "Becomes visible if the Darkmoon Faire is up, and this character does not own the Darkmoon Adventurer's Guide."
-- L.FLAG_TEMPLATE[6] = {}
-- L.FLAG_TEMPLATE[6].title =               "Chromie Time"
-- L.FLAG_TEMPLATE[6].description =         "Becomes visible when this character is in Chromie Time."
-- L.FLAG_TEMPLATE[7] = {}
-- L.FLAG_TEMPLATE[7].title =               "Buy Scroll of Teleport"
-- L.FLAG_TEMPLATE[7].description =         "Automatically buy a Scroll of Teleport: Theater of Pain from One-Eyed Joby if you don't have one already. This flag is always hidden."

-- Debugging
-- L.ERROR_UNKNOWN_EVENT =                  "Unknown event:"
-- L.ERROR_BLOCKED1 =                       "Access to \"%s\" is blocked" -- %s becomes a function name
-- L.ERROR_BLOCKED2 =                       "Assignment to \"%s\" is blocked" -- %s becomes a function name
-- L.FUNCTION_ERROR =                       "Function error:"
-- L.FUNCTION_OUTPUT =                      "Function output:"
-- L.IMPORT_ERROR =                         "Import error:"
-- L.EXPORT_ERROR =                         "Export error:"
-- L.ERROR_BLOCKED =                        "%s was blocked" -- %s becomes a flag name
-- L.ERROR_UNKNOWN =                        "An unknown error occurred"
-- L.ERROR_INVALID_IMPORT_STRING =          "Invalid import string"
-- L.ERROR_DECODE =                         "Failed decode #%d" -- %d becomes a number
-- L.FLAG_ERROR_LUA =                       "Watchtower flag [%s] caused an error on '%s':" -- %s becomes a flag name and event name
