--------------------------
-- Watchtower: zhTW.lua --
--------------------------
-- Chinese (Traditional, Taiwan) localisation
-- Translator(s):

if GetLocale() ~= "zhTW" then return end
local appName, app = ...
local L = app.locales

-- Core
L.NEW_VERSION_AVAILABLE =                "%s 有新版本可用：" -- %s becomes the addon name

L.INVALID_COMMAND =                      "指令無效"

-- Settings
L.VERSION =                              GAME_VERSION_LABEL .. "：" -- "Version"
L.SUPPORT_TEXTLONG1 =                    "開發這個插件需要投入大量的時間與心力。"
L.SUPPORT_TEXTLONG2 =                    "歡迎考慮以金錢支持開發者。"
L.SUPPORT =                              "支持"
L.BUY_ME_A_COFFEE =                      "Buy Me a Coffee" -- Brand name, if there isn't a localised version, keep it the way it is
L.THANK_YOU =                            "謝謝！"
L.FEEDBACK_AND_HELP =                    "意見回饋與協助"
L.DISCORD =                              "Discord" -- Brand name, if there isn't a localised version, keep it the way it is
L.JOIN_DISCORD_SERVER =                  "加入 Discord 伺服器。"
L.CTRL_C_COPY =                          "按 Ctrl+C 複製："
L.LINK_COPIED =                          "連結已複製到剪貼簿"

L.KEYBINDINGS_AND_SLASH_COMMANDS =       SETTINGS_KEYBINDINGS_LABEL .. " & 斜線指令" -- "Keybindings"
_G["BINDING_NAME_WATCHTOWER_TOGGLE"] =   app.NameShort .. ": 切換編輯面板"
L.OR =                                   "或"
L.TOGGLE_EDIT_PANEL =                    "切換編輯面板"
L.OPEN_SETTINGS =                        "開啟設定"

L.GENERAL =                              GENERAL -- "General"
L.SHOW_MINIMAP_ICON =                    "顯示小地圖圖示"
L.SHOW_MINIMAP_ICON_DESC =               "顯示小地圖圖示。即使停用，仍可從插件選單開啟 %s。" -- %s becomes the addon name

-- Edit Panel
L.NEW_FLAG =                             "新旗標"
L.NEW_GROUP =                            "新群組"
L.INACTIVE =                             FACTION_INACTIVE -- "Inactive"
L.DELETE_FLAG =                          "刪除旗標"
L.DELETE_GROUP =                         "刪除群組"
L.IMPORT =                               HUD_EDIT_MODE_IMPORT_LAYOUT -- "Import"
L.EXPORT_FLAG =                          "匯出旗標"
L.EXPORT_GROUP =                         "匯出群組"
L.EXPORT_COPIED =                        "匯出字串已複製到剪貼簿"
L.DELETE_FLAG_Q =                        "要刪除此旗標嗎？"
L.DELETE_GROUP_Q =                       "要刪除此群組嗎？"
L.HOLD_SKIP =                            "按住 Shift 可略過此確認步驟。"
L.CANTDELETE_GROUP =                     "無法刪除包含旗標的群組"
L.CANTMOVE_GROUP =                       "無法移動此群組"

L.TUTORIAL_HEADER =                      "Readme.txt"
L.TUTORIAL_EXPLAIN1 =                    "旗標會在事件發生時執行程式碼，並可透過圖示與標題顯示。"
L.TUTORIAL_EXPLAIN2 =                    "非啟用群組中的旗標不會顯示或執行（編輯時除外）。"
L.TUTORIAL_TRIGGER =                     "觸發程式碼"
L.TUTORIAL_TRIGGER1 =                    "你可以使用以下方法取得觸發事件的名稱及參數："
L.TUTORIAL_TRIGGER2 =                    "無論旗標是否可見，程式碼都會執行。"
L.TUTORIAL_VISIBILITY =                  "顯示狀態"
L.TUTORIAL_VISIBILITY1 =                 "傳回假值的程式碼會隱藏旗標："
L.TUTORIAL_VISIBILITY2 =                 "傳回真值的程式碼會顯示旗標："
L.TEST =                                 TEST_STRING_IGNORE_1 -- "Test"
L.TUTORIAL_TITLE =                       "旗標標題"
L.TUTORIAL_TITLE1 =                      "程式碼傳回數字或字串時，會將該值設為旗標標題。"
L.TUTORIAL_WHAT =                        "這些到底是什麼意思啊！D:"
L.TUTORIAL_WHAT1 =                       "你可以輕鬆地只匯入想使用的旗標。"
L.TUTORIAL_GETFLAGS =                    "來這裡取得旗標！"
L.TUTORIAL_EXAMPLE_TITLE1 =              "非啟用旗標"
L.TUTORIAL_EXAMPLE_TITLE2 =              "隱藏旗標"
L.TUTORIAL_EXAMPLE_SETTINGS =            "開啟 Watchtower 設定"
L.TUTORIAL_EXAMPLE_INACTIVE =            "你可以將此旗標拖曳到其他群組來啟用。"
L.TUTORIAL_EXAMPLE_MOVE =                "開啟編輯面板時可以移動群組。"

L.TITLE =                                LFG_LIST_TITLE -- "Title"
L.ICON =                                 EMBLEM_SYMBOL -- "Icon"
L.TRIGGER =                              "觸發器"
L.EVENTS =                               EVENTS_LABEL -- "Events"
L.DESCRIPTION =                          DESCRIPTION -- "Description"
L.URL =                                  "URL"
L.TEMPLATES =                            "範本"
L.OVERWRITE_FLAG =                       "要用此範本覆蓋旗標嗎？"

L.STYLE =                                "樣式"
L.GROUP_STYLE = {}
L.GROUP_STYLE[1] =                       "圖示與文字"
L.GROUP_STYLE[2] =                       "|cff9D9D9D僅圖示（即將推出™）"
L.ANCHOR =                               "錨點"
L.GROUP_ANCHOR = {}
L.GROUP_ANCHOR[1] =                      "左上"
L.GROUP_ANCHOR[2] =                      "右上"
L.GROUP_ANCHOR[3] =                      "左下"
L.GROUP_ANCHOR[4] =                      "右下"
L.FONT =                                 "字型"
L.SCALE =                                HOUSING_EXPERT_DECOR_SUBMODE_SCALE -- "Scale"

L.LOAD =                                 "載入"

L.LOADCONDITION_MATCH1 =                 "符合" -- followed by an any/all dropdown
L.LOADCONDITION_MATCH2 =                 "以下條件套用於 %s：" -- preceded by an any/all dropdown, %s becomes a flag or group name
L.LOADCONDITION_VALID =                  "載入條件有效。"
L.LOADCONDITION_INCOMPLETE =             "載入條件不完整。"
L.LOADCONDITION_GROUP_HELP =             "僅在符合以下條件時載入此群組："
L.LOADCONDITION_FLAG_HELP =              "僅在符合以下條件時載入此旗標："
L.LOADCONDITION_GROUP_OVERRIDE =         "載入條件由群組控制。"
L.REVERT =                               COOLDOWN_VIEWER_SETTINGS_BUTTON_REVERT_CHANGES -- "Revert"
L.APPLY_CHANGES =                        TRANSMOG_SITUATIONS_APPLY -- "Apply Changes"

L.CONDITION = {}
L.CONDITION[1] =                         CHARACTER -- "Character"
L.CONDITION[2] =                         NAME -- "Name"
L.CONDITION[3] =                         LEVEL -- "Level"
L.CONDITION[4] =                         "伺服器"
L.CONDITION[5] =                         TRANSMOG_SOURCE_6 -- "Profession"
L.CONDITION[6] =                         CLASS -- "Class"
L.CONDITION[7] =                         "規則集"
L.CONDITIONSTATE = {}
L.CONDITIONSTATE[1] =                    "任一"
L.CONDITIONSTATE[2] =                    "全部"
L.CONDITIONSTATE[3] =                    "小於"
L.CONDITIONSTATE[4] =                    "等於"
L.CONDITIONSTATE[5] =                    "屬於其中之一"
L.CONDITIONSTATE[6] =                    "大於"
L.CONDITIONSTATE[7] =                    "不等於"
L.CONDITIONSTATE[8] =                    "不屬於其中任何一個"
L.CONDITIONSTATE[9] =                    "開頭為"
L.CONDITIONSTATE[10] =                   "結尾為"
L.CONDITIONSTATE[11] =                   "包含"
L.CONDITIONSTATE[12] =                   "不包含"
L.RULESET = {}
L.RULESET[1] =                           GDAPI_REALMTYPE_NORMAL -- "Normal"
L.RULESET[2] =                           GDAPI_REALMTYPE_PVP -- "PvP"
L.RULESET[3] =                           "角色扮演"
L.RULESET[4] =                           "角色扮演 PvP"
L.RULESET[5] =                           GUILD_PLAYSTYLE_HARDCORE -- "Hardcore"

L.ACTIONS =                              DAMAGE_METER_CATEGORY_ACTIONS -- "Actions"

L.HIDE_AFTER =                           "X 秒後隱藏 "

L.FLAG_TEMPLATE = {}
L.FLAG_TEMPLATE[1] = {}
L.FLAG_TEMPLATE[1].title =               "購買榮譽印記"
L.FLAG_TEMPLATE[1].description =         "角色擁有至少 2000 點榮譽時會顯示，提醒你購買內含 5 枚榮譽印記的寶箱。"
L.FLAG_TEMPLATE[2] = {}
L.FLAG_TEMPLATE[2].title =               "要塞入侵"
L.FLAG_TEMPLATE[2].description =         "如果你的帳號沒有任何角色在本週完成（白金）要塞入侵，便會顯示。"
L.FLAG_TEMPLATE[3] = {}
L.FLAG_TEMPLATE[3].title =               "傳送門：雷王島"
L.FLAG_TEMPLATE[3].description =         "如果角色還沒解鎖從螳螂荒原通往雷王島的傳送門，便會顯示。"
L.FLAG_TEMPLATE[4] = {}
L.FLAG_TEMPLATE[4].title =               "褪色的藏寶圖"
L.FLAG_TEMPLATE[4].description =         "暗月馬戲團開放期間，如果角色還沒完成可獲得 100 張暗月獎券的褪色的藏寶圖任務，便會顯示。"
L.FLAG_TEMPLATE[5] = {}
L.FLAG_TEMPLATE[5].title =               "暗月冒險者指南"
L.FLAG_TEMPLATE[5].description =         "暗月馬戲團開放期間，如果角色沒有暗月冒險者指南，便會顯示。"
L.FLAG_TEMPLATE[6] = {}
L.FLAG_TEMPLATE[6].title =               "克羅米時間"
L.FLAG_TEMPLATE[6].description =         "角色處於克羅米時間時會顯示。"
L.FLAG_TEMPLATE[7] = {}
L.FLAG_TEMPLATE[7].title =               "購買傳送卷軸"
L.FLAG_TEMPLATE[7].description =         "如果你還沒有傳送卷軸：苦痛劇場，便自動向獨眼喬比購買。此旗標會始終隱藏。"

-- Debugging
L.ERROR_UNKNOWN_EVENT =                  "未知事件："
L.ERROR_BLOCKED1 =                       "已封鎖對「%s」的存取" -- %s becomes a function name
L.ERROR_BLOCKED2 =                       "已封鎖對「%s」的賦值" -- %s becomes a function name
L.FUNCTION_ERROR =                       "函式錯誤："
L.FUNCTION_OUTPUT =                      "函式輸出："
L.IMPORT_ERROR =                         "匯入錯誤："
L.EXPORT_ERROR =                         "匯出錯誤："
L.ERROR_BLOCKED =                        "%s 已遭封鎖" -- %s becomes a flag name
L.ERROR_UNKNOWN =                        "發生未知錯誤"
L.ERROR_INVALID_IMPORT_STRING =          "無效的匯入字串"
L.ERROR_DECODE =                         "解碼失敗 #%d" -- %d becomes a number
L.FLAG_ERROR_LUA =                       "Watchtower 旗標 [%s] 處理「%s」時發生錯誤：" -- %s becomes a flag name and event name
