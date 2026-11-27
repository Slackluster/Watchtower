--------------------------
-- Watchtower: zhCN.lua --
--------------------------
-- Chinese (Simplified, PRC) localisation
-- Translator(s): cikichen

if GetLocale() ~= "zhCN" then return end
local appName, app = ...
local L = app.locales

-- Core
L.NEW_VERSION_AVAILABLE =                "%s 有新版本可用：" -- %s becomes the addon name

L.INVALID_COMMAND =                      "无效指令"

-- Settings
L.VERSION =                              GAME_VERSION_LABEL .. "：" -- "Version"
L.SUPPORT_TEXTLONG1 =                    "开发这个插件需要大量的时间和精力。"
L.SUPPORT_TEXTLONG2 =                    "请考虑在经济上支持开发者。"
L.SUPPORT =                              "支持"
L.BUY_ME_A_COFFEE =                      "Buy Me a Coffee" -- Brand name, if there isn't a localised version, keep it the way it is
L.THANK_YOU =                            "谢谢！"
L.FEEDBACK_AND_HELP =                    "反馈与帮助"
L.DISCORD =                              "Discord" -- Brand name, if there isn't a localised version, keep it the way it is
L.JOIN_DISCORD_SERVER =                  "加入 Discord 服务器。"
L.CTRL_C_COPY =                          "按 Ctrl+C 复制："
L.LINK_COPIED =                          "链接已复制到剪贴板"

L.KEYBINDINGS_AND_SLASH_COMMANDS =       SETTINGS_KEYBINDINGS_LABEL .. " & 斜杠命令" -- "Keybindings"
_G["BINDING_NAME_WATCHTOWER_TOGGLE"] =   app.NameShort .. ": 切换编辑面板"
L.OR =                                   "或"
L.TOGGLE_EDIT_PANEL =                    "切换编辑面板"
L.OPEN_SETTINGS =                        "打开设置"

L.GENERAL =                              GENERAL -- "General"
L.SHOW_MINIMAP_ICON =                    "显示小地图图标"
L.SHOW_MINIMAP_ICON_DESC =               "显示小地图图标。如果您禁用此选项，仍可通过插件目录访问 %s。" -- %s becomes the addon name

-- Edit Panel
L.NEW =                                  NEW -- "New"
L.FLAG =                                 "标记"
L.GROUP =                                "分组"
L.NEW_FLAG =                             "新建标记"
L.NEW_GROUP =                            "新建分组"
L.INACTIVE =                             FACTION_INACTIVE -- "Inactive"
L.DELETE =                               DELETE -- "Delete"
L.IMPORT =                               HUD_EDIT_MODE_IMPORT_LAYOUT -- "Import"
L.EXPORT =                               "导出"
L.EXPORT_COPIED =                        "导出字符串已复制到剪贴板"
L.DELETE_FLAG_Q =                        "删除此标记？"
L.DELETE_GROUP_Q =                       "删除此分组？"
L.HOLD_SKIP =                            "按住 Shift 可跳过此确认步骤。"
L.CANTDELETE_GROUP =                     "无法删除包含标记的分组"
L.CANTMOVE_GROUP =                       "无法移动该分组"

L.TUTORIAL_HEADER =                      "Readme.txt"
L.TUTORIAL_EXPLAIN1 =                    "标记会在事件触发时运行代码，并可通过图标和标题显示。"
L.TUTORIAL_EXPLAIN2 =                    "非激活分组中的标记不会显示或运行（编辑时除外）。"
L.TUTORIAL_TRIGGER =                     "触发代码"
L.TUTORIAL_TRIGGER1 =                    "你可以用以下方式获取触发事件的名称和参数："
L.TUTORIAL_TRIGGER2 =                    "无论标记是否可见，代码都会运行。"
L.TUTORIAL_VISIBILITY =                  "可见性"
L.TUTORIAL_VISIBILITY1 =                 "返回假值的代码会隐藏标记："
L.TUTORIAL_VISIBILITY2 =                 "返回真值的代码会显示标记："
L.TEST =                                 TEST_STRING_IGNORE_1 -- "Test"
L.TUTORIAL_TITLE =                       "标记标题"
L.TUTORIAL_TITLE1 =                      "如果代码返回数字或字符串，该值将作为标记的标题。"
L.TUTORIAL_WHAT =                        "这些都是什么意思啊！D:"
L.TUTORIAL_WHAT1 =                       "你也可以只导入想用的标记，轻松上手。"
L.TUTORIAL_GETFLAGS =                    "来这里获取标记！"
L.TUTORIAL_EXAMPLE_TITLE1 =              "非激活标记"
L.TUTORIAL_EXAMPLE_TITLE2 =              "隐藏标记"
L.TUTORIAL_EXAMPLE_SETTINGS =            "打开 Watchtower 设置"
L.TUTORIAL_EXAMPLE_INACTIVE =            "你可以将此标记拖入其他分组以启用它。"
L.TUTORIAL_EXAMPLE_MOVE =                "打开编辑面板时可以移动分组。"

L.TITLE =                                LFG_LIST_TITLE -- "Title"
L.ICON =                                 EMBLEM_SYMBOL -- "Icon"
L.TRIGGER =                              "触发器"
L.EVENTS =                               EVENTS_LABEL -- "Events"
L.DESCRIPTION =                          DESCRIPTION -- "Description"
L.URL =                                  "URL"
L.TEMPLATES =                            "模板"
L.OVERWRITE_FLAG =                       "用此模板覆盖这个标记？"

L.STYLE =                                "样式"
L.GROUP_STYLE = {}
L.GROUP_STYLE[1] =                       "图标和文字"
L.GROUP_STYLE[2] =                       "|cff9D9D9D仅图标（即将推出™）"
L.ANCHOR =                               "锚点"
L.GROUP_ANCHOR = {}
L.GROUP_ANCHOR[1] =                      "左上"
L.GROUP_ANCHOR[2] =                      "右上"
L.GROUP_ANCHOR[3] =                      "左下"
L.GROUP_ANCHOR[4] =                      "右下"
L.FONT =                                 "字体"
L.SCALE =                                HOUSING_EXPERT_DECOR_SUBMODE_SCALE -- "Scale"

L.LOAD =                                 "加载"

L.LOADCONDITION_MATCH1 =                 "匹配" -- followed by an any/all dropdown
L.LOADCONDITION_MATCH2 =                 "以下条件用于 %s：" -- preceded by an any/all dropdown, %s becomes a flag or group name
L.LOADCONDITION_VALID =                  "加载条件有效。"
L.LOADCONDITION_INCOMPLETE =             "加载条件不完整。"
L.LOADCONDITION_GROUP_HELP =             "仅当满足以下条件时加载此分组："
L.LOADCONDITION_FLAG_HELP =              "仅当满足以下条件时加载此标记："
L.LOADCONDITION_GROUP_OVERRIDE =         "加载条件由分组控制。"
L.REVERT =                               COOLDOWN_VIEWER_SETTINGS_BUTTON_REVERT_CHANGES -- "Revert"
L.APPLY_CHANGES =                        TRANSMOG_SITUATIONS_APPLY -- "Apply Changes"

L.CONDITION = {}
L.CONDITION[1] =                         CHARACTER -- "Character"
L.CONDITION[2] =                         NAME -- "Name"
L.CONDITION[3] =                         LEVEL -- "Level"
L.CONDITION[4] =                         "服务器"
L.CONDITION[5] =                         TRANSMOG_SOURCE_6 -- "Profession"
L.CONDITION[6] =                         CLASS -- "Class"
L.CONDITION[7] =                         "规则集"
L.CONDITIONSTATE = {}
L.CONDITIONSTATE[1] =                    "任意"
L.CONDITIONSTATE[2] =                    "全部"
L.CONDITIONSTATE[3] =                    "小于"
L.CONDITIONSTATE[4] =                    "等于"
L.CONDITIONSTATE[5] =                    "属于其中之一"
L.CONDITIONSTATE[6] =                    "大于"
L.CONDITIONSTATE[7] =                    "不等于"
L.CONDITIONSTATE[8] =                    "不属于其中任何一个"
L.CONDITIONSTATE[9] =                    "开头为"
L.CONDITIONSTATE[10] =                   "结尾为"
L.CONDITIONSTATE[11] =                   "包含"
L.CONDITIONSTATE[12] =                   "不包含"
L.RULESET = {}
L.RULESET[1] =                           GDAPI_REALMTYPE_NORMAL -- "Normal"
L.RULESET[2] =                           GDAPI_REALMTYPE_PVP -- "PvP"
L.RULESET[3] =                           "角色扮演"
L.RULESET[4] =                           "角色扮演 PvP"
L.RULESET[5] =                           GUILD_PLAYSTYLE_HARDCORE -- "Hardcore"

L.ACTIONS =                              DAMAGE_METER_CATEGORY_ACTIONS -- "Actions"

L.HIDE_AFTER =                           "X 秒后隐藏 "

L.FLAG_TEMPLATE = {}
L.FLAG_TEMPLATE[1] = {}
L.FLAG_TEMPLATE[1].title =               "购买荣誉印记"
L.FLAG_TEMPLATE[1].description =         "当该角色拥有至少 2000 点荣誉时显示，提醒购买内含 5 枚荣誉印记的宝箱。"
L.FLAG_TEMPLATE[2] = {}
L.FLAG_TEMPLATE[2].title =               "要塞入侵"
L.FLAG_TEMPLATE[2].description =         "如果你的账号中没有角色在本周完成过（白金）要塞入侵，则显示此标记。"
L.FLAG_TEMPLATE[3] = {}
L.FLAG_TEMPLATE[3].title =               "传送门：雷神岛"
L.FLAG_TEMPLATE[3].description =         "如果该角色尚未解锁从螳螂高原前往雷神岛的传送门，则显示此标记。"
L.FLAG_TEMPLATE[4] = {}
L.FLAG_TEMPLATE[4].title =               "褪色藏宝图"
L.FLAG_TEMPLATE[4].description =         "暗月马戏团开放期间，如果该角色尚未完成奖励 100 张暗月奖券的褪色藏宝图任务，则显示此标记。"
L.FLAG_TEMPLATE[5] = {}
L.FLAG_TEMPLATE[5].title =               "暗月冒险者指南"
L.FLAG_TEMPLATE[5].description =         "暗月马戏团开放期间，如果该角色没有暗月冒险者指南，则显示此标记。"
L.FLAG_TEMPLATE[6] = {}
L.FLAG_TEMPLATE[6].title =               "克罗米时间"
L.FLAG_TEMPLATE[6].description =         "当该角色处于克罗米时间中时显示此标记。"
L.FLAG_TEMPLATE[7] = {}
L.FLAG_TEMPLATE[7].title =               "购买传送卷轴"
L.FLAG_TEMPLATE[7].description =         "如果你还没有传送卷轴：伤逝剧场，则自动从独眼乔比处购买。此标记始终隐藏。"

-- Debugging
L.ERROR_UNKNOWN_EVENT =                  "未知事件："
L.ERROR_BLOCKED1 =                       "已阻止访问“%s”" -- %s becomes a function name
L.ERROR_BLOCKED2 =                       "已阻止向“%s”赋值" -- %s becomes a function name
L.FUNCTION_ERROR =                       "函数错误："
L.FUNCTION_OUTPUT =                      "函数输出："
L.IMPORT_ERROR =                         "导入错误："
L.EXPORT_ERROR =                         "导出错误："
L.ERROR_BLOCKED =                        "%s 已被阻止" -- %s becomes a flag name
L.ERROR_UNKNOWN =                        "发生未知错误"
L.ERROR_INVALID_IMPORT_STRING =          "无效的导入字符串"
L.ERROR_DECODE =                         "解码失败 #%d" -- %d becomes a number
L.FLAG_ERROR_LUA =                       "Watchtower 标记 [%s] 在处理“%s”时出错：" -- %s becomes a flag name and event name
