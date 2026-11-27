--------------------------
-- Watchtower: koKR.lua --
--------------------------
-- Korean (Korea) localisation
-- Translator(s):

if GetLocale() ~= "koKR" then return end
local appName, app = ...
local L = app.locales

-- Core
L.NEW_VERSION_AVAILABLE =                "%s의 새 버전이 출시되었습니다:" -- %s becomes the addon name

L.INVALID_COMMAND =                      "잘못된 명령어"

-- Settings
L.VERSION =                              GAME_VERSION_LABEL .. ":" -- "Version"
L.SUPPORT_TEXTLONG1 =                    "이 애드온을 개발하는 데에는 많은 시간과 노력이 필요합니다."
L.SUPPORT_TEXTLONG2 =                    "개발자를 금전적으로 후원하는 것을 고려해 주세요."
L.SUPPORT =                              "후원"
L.BUY_ME_A_COFFEE =                      "Buy Me a Coffee" -- Brand name, if there isn't a localised version, keep it the way it is
L.THANK_YOU =                            "감사합니다!"
L.FEEDBACK_AND_HELP =                    "피드백 및 도움말"
L.DISCORD =                              "Discord" -- Brand name, if there isn't a localised version, keep it the way it is
L.JOIN_DISCORD_SERVER =                  "Discord 서버에 참여하세요."
L.CTRL_C_COPY =                          "Ctrl+C를 눌러 복사:"
L.LINK_COPIED =                          "링크를 클립보드에 복사했습니다"

L.KEYBINDINGS_AND_SLASH_COMMANDS =       SETTINGS_KEYBINDINGS_LABEL .. " 및 슬래시 명령어" -- "Keybindings"
_G["BINDING_NAME_WATCHTOWER_TOGGLE"] =   app.NameShort .. ": 편집 창 열기/닫기"
L.OR =                                   "또는"
L.TOGGLE_EDIT_PANEL =                    "편집 창 열기/닫기"
L.OPEN_SETTINGS =                        "설정 열기"

L.GENERAL =                              GENERAL -- "General"
L.SHOW_MINIMAP_ICON =                    "미니맵 아이콘 표시"
L.SHOW_MINIMAP_ICON_DESC =               "미니맵 아이콘을 표시합니다. 비활성화해도 애드온 메뉴에서 %s을(를) 사용할 수 있습니다." -- %s becomes the addon name

-- Edit Panel
L.NEW =                                  NEW -- "New"
L.FLAG =                                 "플래그"
L.GROUP =                                "그룹"
L.NEW_FLAG =                             "새 플래그"
L.NEW_GROUP =                            "새 그룹"
L.INACTIVE =                             FACTION_INACTIVE -- "Inactive"
L.DELETE =                               DELETE -- "Delete"
L.IMPORT =                               HUD_EDIT_MODE_IMPORT_LAYOUT -- "Import"
L.EXPORT =                               "내보내기"
L.EXPORT_COPIED =                        "내보내기 문자열을 클립보드에 복사했습니다"
L.DELETE_FLAG_Q =                        "이 플래그를 삭제하시겠습니까?"
L.DELETE_GROUP_Q =                       "이 그룹을 삭제하시겠습니까?"
L.HOLD_SKIP =                            "Shift 키를 누르면 이 확인 단계를 건너뜁니다."
L.CANTDELETE_GROUP =                     "플래그가 포함된 그룹은 삭제할 수 없습니다"
L.CANTMOVE_GROUP =                       "이 그룹을 이동할 수 없습니다"

L.TUTORIAL_HEADER =                      "Readme.txt"
L.TUTORIAL_EXPLAIN1 =                    "플래그는 이벤트 발생 시 코드를 실행하며 아이콘과 제목으로 표시할 수 있습니다."
L.TUTORIAL_EXPLAIN2 =                    "비활성 그룹의 플래그는 편집 중이 아닐 때 표시되거나 실행되지 않습니다."
L.TUTORIAL_TRIGGER =                     "발동 코드"
L.TUTORIAL_TRIGGER1 =                    "다음과 같이 이벤트 이름과 인수를 가져올 수 있습니다:"
L.TUTORIAL_TRIGGER2 =                    "코드는 플래그의 표시 여부와 관계없이 실행됩니다."
L.TUTORIAL_VISIBILITY =                  "표시 여부"
L.TUTORIAL_VISIBILITY1 =                 "거짓으로 평가되는 값을 반환하는 코드는 플래그를 숨깁니다:"
L.TUTORIAL_VISIBILITY2 =                 "참으로 평가되는 값을 반환하는 코드는 플래그를 표시합니다:"
L.TEST =                                 TEST_STRING_IGNORE_1 -- "Test"
L.TUTORIAL_TITLE =                       "플래그 제목"
L.TUTORIAL_TITLE1 =                      "코드가 숫자 또는 문자열을 반환하면 해당 값이 플래그 제목이 됩니다."
L.TUTORIAL_WHAT =                        "무슨 뜻인지 하나도 모르겠어요! D:"
L.TUTORIAL_WHAT1 =                       "원하는 플래그만 가져와 간편하게 사용할 수도 있습니다."
L.TUTORIAL_GETFLAGS =                    "여기에서 플래그를 받으세요!"
L.TUTORIAL_EXAMPLE_TITLE1 =              "비활성 플래그"
L.TUTORIAL_EXAMPLE_TITLE2 =              "숨겨진 플래그"
L.TUTORIAL_EXAMPLE_SETTINGS =            "Watchtower 설정 열기"
L.TUTORIAL_EXAMPLE_INACTIVE =            "이 플래그를 다른 그룹으로 끌어 옮기면 활성화할 수 있습니다."
L.TUTORIAL_EXAMPLE_MOVE =                "이 편집 창이 열려 있을 때 그룹을 이동할 수 있습니다."

L.TITLE =                                LFG_LIST_TITLE -- "Title"
L.ICON =                                 EMBLEM_SYMBOL -- "Icon"
L.TRIGGER =                              "발동 조건"
L.EVENTS =                               EVENTS_LABEL -- "Events"
L.DESCRIPTION =                          DESCRIPTION -- "Description"
L.URL =                                  "URL"
L.TEMPLATES =                            "템플릿"
L.OVERWRITE_FLAG =                       "이 템플릿으로 플래그를 덮어쓰시겠습니까?"

L.STYLE =                                "스타일"
L.GROUP_STYLE = {}
L.GROUP_STYLE[1] =                       "아이콘과 텍스트"
L.GROUP_STYLE[2] =                       "|cff9D9D9D아이콘만 (곧™)"
L.ANCHOR =                               "고정 위치"
L.GROUP_ANCHOR = {}
L.GROUP_ANCHOR[1] =                      "왼쪽 위"
L.GROUP_ANCHOR[2] =                      "오른쪽 위"
L.GROUP_ANCHOR[3] =                      "왼쪽 아래"
L.GROUP_ANCHOR[4] =                      "오른쪽 아래"
L.FONT =                                 "글꼴"
L.SCALE =                                HOUSING_EXPERT_DECOR_SUBMODE_SCALE -- "Scale"

L.LOAD =                                 "불러오기"

L.LOADCONDITION_MATCH1 =                 "조건 일치" -- followed by an any/all dropdown
L.LOADCONDITION_MATCH2 =                 "%s에 대한 다음 조건:" -- preceded by an any/all dropdown, %s becomes a flag or group name
L.LOADCONDITION_VALID =                  "불러오기 조건이 유효합니다."
L.LOADCONDITION_INCOMPLETE =             "불러오기 조건이 완전하지 않습니다."
L.LOADCONDITION_GROUP_HELP =             "다음 조건을 충족할 때만 이 그룹을 불러옵니다:"
L.LOADCONDITION_FLAG_HELP =              "다음 조건을 충족할 때만 이 플래그를 불러옵니다:"
L.LOADCONDITION_GROUP_OVERRIDE =         "그룹에서 불러오기 조건을 제어합니다."
L.REVERT =                               COOLDOWN_VIEWER_SETTINGS_BUTTON_REVERT_CHANGES -- "Revert"
L.APPLY_CHANGES =                        TRANSMOG_SITUATIONS_APPLY -- "Apply Changes"

L.CONDITION = {}
L.CONDITION[1] =                         CHARACTER -- "Character"
L.CONDITION[2] =                         NAME -- "Name"
L.CONDITION[3] =                         LEVEL -- "Level"
L.CONDITION[4] =                         "서버"
L.CONDITION[5] =                         TRANSMOG_SOURCE_6 -- "Profession"
L.CONDITION[6] =                         CLASS -- "Class"
L.CONDITION[7] =                         "규칙 유형"
L.CONDITIONSTATE = {}
L.CONDITIONSTATE[1] =                    "일부"
L.CONDITIONSTATE[2] =                    "모두"
L.CONDITIONSTATE[3] =                    "보다 작음"
L.CONDITIONSTATE[4] =                    "같음"
L.CONDITIONSTATE[5] =                    "다음 중 하나임"
L.CONDITIONSTATE[6] =                    "보다 큼"
L.CONDITIONSTATE[7] =                    "같지 않음"
L.CONDITIONSTATE[8] =                    "다음 중 어느 것도 아님"
L.CONDITIONSTATE[9] =                    "다음으로 시작함"
L.CONDITIONSTATE[10] =                   "다음으로 끝남"
L.CONDITIONSTATE[11] =                   "포함함"
L.CONDITIONSTATE[12] =                   "포함하지 않음"
L.RULESET = {}
L.RULESET[1] =                           GDAPI_REALMTYPE_NORMAL -- "Normal"
L.RULESET[2] =                           GDAPI_REALMTYPE_PVP -- "PvP"
L.RULESET[3] =                           "역할수행"
L.RULESET[4] =                           "역할수행 PvP"
L.RULESET[5] =                           GUILD_PLAYSTYLE_HARDCORE -- "Hardcore"

L.ACTIONS =                              DAMAGE_METER_CATEGORY_ACTIONS -- "Actions"

L.HIDE_AFTER =                           "X초 후 숨기기 "

L.FLAG_TEMPLATE = {}
L.FLAG_TEMPLATE[1] = {}
L.FLAG_TEMPLATE[1].title =               "명예 훈장 구매"
L.FLAG_TEMPLATE[1].description =         "캐릭터의 명예가 2,000 이상이면 명예 훈장 5개가 든 보관함 구매를 알려주기 위해 표시됩니다."
L.FLAG_TEMPLATE[2] = {}
L.FLAG_TEMPLATE[2].title =               "주둔지 침략"
L.FLAG_TEMPLATE[2].description =         "계정 내 어떤 캐릭터도 이번 주에 (백금) 주둔지 침략을 완료하지 않았으면 표시됩니다."
L.FLAG_TEMPLATE[3] = {}
L.FLAG_TEMPLATE[3].title =               "차원문: 천둥의 섬"
L.FLAG_TEMPLATE[3].description =         "이 캐릭터가 탕랑 평원에서 천둥의 섬으로 가는 차원문을 아직 열지 않았다면 표시됩니다."
L.FLAG_TEMPLATE[4] = {}
L.FLAG_TEMPLATE[4].title =               "빛바랜 보물지도"
L.FLAG_TEMPLATE[4].description =         "다크문 축제가 열렸고 이 캐릭터가 다크문 상품권 100장을 주는 빛바랜 보물지도 퀘스트를 완료하지 않았으면 표시됩니다."
L.FLAG_TEMPLATE[5] = {}
L.FLAG_TEMPLATE[5].title =               "다크문 모험가 안내서"
L.FLAG_TEMPLATE[5].description =         "다크문 축제가 열렸고 이 캐릭터가 다크문 모험가 안내서를 소유하고 있지 않으면 표시됩니다."
L.FLAG_TEMPLATE[6] = {}
L.FLAG_TEMPLATE[6].title =               "크로미 시간"
L.FLAG_TEMPLATE[6].description =         "이 캐릭터가 크로미 시간에 있으면 표시됩니다."
L.FLAG_TEMPLATE[7] = {}
L.FLAG_TEMPLATE[7].title =               "순간이동 두루마리 구매"
L.FLAG_TEMPLATE[7].description =         "아직 가지고 있지 않다면 외눈박이 조비에게서 순간이동 두루마리: 고통의 투기장을 자동으로 구매합니다. 이 플래그는 항상 숨겨집니다."

-- Debugging
L.ERROR_UNKNOWN_EVENT =                  "알 수 없는 이벤트:"
L.ERROR_BLOCKED1 =                       "\"%s\"에 대한 접근이 차단되었습니다" -- %s becomes a function name
L.ERROR_BLOCKED2 =                       "\"%s\"에 대한 값 할당이 차단되었습니다" -- %s becomes a function name
L.FUNCTION_ERROR =                       "함수 오류:"
L.FUNCTION_OUTPUT =                      "함수 출력:"
L.IMPORT_ERROR =                         "가져오기 오류:"
L.EXPORT_ERROR =                         "내보내기 오류:"
L.ERROR_BLOCKED =                        "%s이(가) 차단되었습니다" -- %s becomes a flag name
L.ERROR_UNKNOWN =                        "알 수 없는 오류가 발생했습니다"
L.ERROR_INVALID_IMPORT_STRING =          "잘못된 가져오기 문자열"
L.ERROR_DECODE =                         "디코딩 실패 #%d" -- %d becomes a number
L.FLAG_ERROR_LUA =                       "Watchtower 플래그 [%s]에서 '%s' 이벤트 처리 중 오류가 발생했습니다:" -- %s becomes a flag name and event name
