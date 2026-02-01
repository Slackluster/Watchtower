------------------------------
-- Watchtower: Database.lua --
------------------------------

local appName, app = ...
local L = app.locales

-- Strings
app.Name = "Watchtower"
app.NameLong = app:Colour(app.Name)
app.NameShort = app:Colour("WT")
app.NamePrefix = "Watchtower"
_G["BINDING_NAME_WATCHTOWER"] = app.Name
_G["BINDING_NAME_SLACKWARE"] = "Slackware"

-- Textures
app.Texture = 236351
app.Icon = "Interface\\AddOns\\Watchtower\\assets\\icon.png"
app.IconReady = "Interface\\RaidFrame\\ReadyCheck-Ready"
app.IconNotReady = "Interface\\RaidFrame\\ReadyCheck-NotReady"
app.IconLMB = "Interface\\TutorialFrame\\UI-Tutorial-Frame:12:12:0:0:512:512:10:65:228:283"
app.IconRMB = "Interface\\TutorialFrame\\UI-Tutorial-Frame:12:12:0:0:512:512:10:65:330:385"
app.IconNew = "|TInterface\\AddOns\\Watchtower\\assets\\new.png:20:28|t"

app.Blocked = {
	AcceptTrade = true,
	AddTradeMoney = true,
	ChatEdit_ActivateChat = true,
	ChatEdit_OnEnterPressed = true,
	ChatEdit_ParseText = true,
	ChatEdit_SendText = true,
	CreateMacro = true,
	debug = true,
	DeleteCursorItem = true,
	DevTools_DumpCommand = true,
	EditMacro = true,
	EnumerateFrames = true,
	GetButtonMetatable = true,
	GetEditBoxMetatable = true,
	getfenv = true,
	GetFontStringMetatable = true,
	GetFrameMetatable = true,
	GuildDisband = true,
	GuildUninvite = true,
	hash_SlashCmdList = true,
	ItemRackEvents = true,
	ItemRackUser = true,
	loadstring = true,
	MailFrame = true,
	MailFrameTab2 = true,
	pcall = true,
	PickupPlayerMoney = true,
	PickupTradeMoney = true,
	RegisterNewSlashCommand = true,
	RunScript = true,
	securecall = true,
	SendMail = true,
	SendMailMailButton = true,
	SendMailMoneyGold = true,
	SetBindingMacro = true,
	setfenv = true,
	SetSendMailMoney = true,
	SetTradeMoney = true,
	SlashCmdList = true,
	TradeFrame = true,
	Watchtower_Flags = true,
	xpcall = true,
}

app.Templates = {
	[1] = { icon = 1322720, trigger = "local honor = C_CurrencyInfo.GetCurrencyInfo(1792).quantity\nif honor >= 2000 then return true\nelse return false\nend", events = { "PLAYER_ENTERING_WORLD", "CHAT_MSG_CURRENCY", "MERCHANT_CLOSED" } },
	[2] = { icon = 1030914, trigger = "return not(C_QuestLog.IsQuestFlaggedCompletedOnAccount(38482))", events = { "PLAYER_ENTERING_WORLD", "QUEST_TURNED_IN", "QUEST_AUTOCOMPLETE", "QUEST_REMOVED" } },
	[3] = { icon = 136014, trigger = "return not(C_QuestLog.IsQuestFlaggedCompleted(32680) or C_QuestLog.IsQuestFlaggedCompleted(32681))", events = { "PLAYER_ENTERING_WORLD", "QUEST_TURNED_IN", "QUEST_AUTOCOMPLETE", "QUEST_REMOVED" } },
	[4] = { icon = 237388, trigger = "C_Calendar.OpenCalendar()\nlocal dmf = false\nlocal date = C_DateAndTime.GetCurrentCalendarTime()\nlocal numEvents = C_Calendar.GetNumDayEvents(0, date.monthDay)\nfor i=1,numEvents do\n   local event = C_Calendar.GetDayEvent(0,date.monthDay,i)\n   if event ~= nil then\n      if event.eventID == 479 then\n         dmf = true\n         break\n      end\n   end\nend\nif dmf and not(C_QuestLog.IsQuestFlaggedCompleted(38934)) then\n   return true\nelse\n   return false\nend", events = { "PLAYER_ENTERING_WORLD", "QUEST_TURNED_IN", "QUEST_AUTOCOMPLETE", "QUEST_REMOVED" } },
	[5] = { icon = 354435, trigger = "C_Calendar.OpenCalendar()\nlocal dmf = false\nlocal date = C_DateAndTime.GetCurrentCalendarTime()\nlocal numEvents = C_Calendar.GetNumDayEvents(0, date.monthDay)\nfor i=1,numEvents do\n   local event = C_Calendar.GetDayEvent(0,date.monthDay,i)\n   if event ~= nil then\n      if event.eventID == 479 then\n         dmf = true\n         break\n      end\n   end\nend\nif dmf and C_Item.GetItemCount(71634, true) == 0 then\n   return true\nelse\n   return false\nend", events = { "PLAYER_ENTERING_WORLD", "QUEST_TURNED_IN", "QUEST_AUTOCOMPLETE", "QUEST_REMOVED" } },
	[6] = { icon = 4719557, trigger = "return C_PlayerInfo.IsPlayerInChromieTime()", events = { "PLAYER_ENTERING_WORLD", "GOSSIP_SHOW", "GOSSIP_CLOSED", "QUEST_LOG_UPDATE" } },
	[7] = { icon = 134943, trigger = "if C_Item.GetItemCount(181163, true) == 0 then\n   for i = 1, GetMerchantNumItems() do\n      if GetMerchantItemID(i) == 181163 then\n         BuyMerchantItem(i, 1)\n      end\n   end\nend\nreturn false", events = { "MERCHANT_SHOW" } }
}
