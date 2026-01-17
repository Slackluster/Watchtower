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

-- Textures
app.Texture = 236351
app.Icon = "Interface\\AddOns\\Watchtower\\assets\\icon.png"
app.IconReady = "Interface\\RaidFrame\\ReadyCheck-Ready"
app.IconNotReady = "Interface\\RaidFrame\\ReadyCheck-NotReady"
app.IconLMB = "Interface\\TutorialFrame\\UI-Tutorial-Frame:12:12:0:0:512:512:10:65:228:283"
app.IconRMB = "Interface\\TutorialFrame\\UI-Tutorial-Frame:12:12:0:0:512:512:10:65:330:385"

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
	[1] = { title = "Buy Marks of Honor", icon = 1322720, trigger = "local honor = C_CurrencyInfo.GetCurrencyInfo(1792).quantity\nif honor >= 2000 then return true\nelse return false\nend", events = { "PLAYER_ENTERING_WORLD", "CHAT_MSG_CURRENCY" }, description = "Becomes visible when this character has 2000 or more Honor, as a reminder to buy the cache that contains 5 Marks of Honor." },

	[2] = { title = "Garrison Invasion", icon = 1030914, trigger = "return not(C_QuestLog.IsQuestFlaggedCompletedOnAccount(38482))", events = { "PLAYER_ENTERING_WORLD", "QUEST_TURNED_IN", "QUEST_AUTOCOMPLETE", "QUEST_REMOVED" }, description = "Becomes visible when no character on your account has completed a (Platinum) Garrison invasion yet this week." },

	[3] = { title = "Portal: Isle of Thunder", icon = 136014, trigger = "return not(C_QuestLog.IsQuestFlaggedCompleted(32680) or C_QuestLog.IsQuestFlaggedCompleted(32681))", events = { "PLAYER_ENTERING_WORLD", "QUEST_TURNED_IN", "QUEST_AUTOCOMPLETE", "QUEST_REMOVED" }, description = "Becomes visible when this character has not yet unlocked the portal from Townlong Steppes to the Isle of Thunder." },

	[4] = { title = "Faded Treasure Map", icon = 237388, trigger = "C_Calendar.OpenCalendar()\nlocal dmf = false\nlocal date = C_DateAndTime.GetCurrentCalendarTime()\nlocal numEvents = C_Calendar.GetNumDayEvents(0, date.monthDay)\nfor i=1,numEvents do\n   local event = C_Calendar.GetHolidayInfo(0,date.monthDay,i)\n   if event ~= nil then\n      if event.name == \"Darkmoon Faire\" then\n         dmf = true\n      end\n   end\nend\nif dmf and not(C_QuestLog.IsQuestFlaggedCompleted(38934)) then return true\nelse return false\nend", events = { "PLAYER_ENTERING_WORLD", "QUEST_TURNED_IN", "QUEST_AUTOCOMPLETE", "QUEST_REMOVED" }, description = "Becomes visible if the Darkmoon Faire is up, and this character has not yet completed the Faded Treasure Map quest which grants 100 Darkmoon Prize Tickets." },

	[5] = { title = "Darkmoon Adventurer's Guide", icon = 354435, trigger = "C_Calendar.OpenCalendar()\nlocal dmf = false\nlocal date = C_DateAndTime.GetCurrentCalendarTime()\nlocal numEvents = C_Calendar.GetNumDayEvents(0, date.monthDay)\nfor i=1,numEvents do\n   local event = C_Calendar.GetHolidayInfo(0,date.monthDay,i)\n   if event ~= nil then\n      if event.name == \"Darkmoon Faire\" then\n         dmf = true\n      end\n   end\nend\nif dmf and C_Item.GetItemCount(181163, true) == 0 then return true\nelse return false\nend", events = { "PLAYER_ENTERING_WORLD", "QUEST_TURNED_IN", "QUEST_AUTOCOMPLETE", "QUEST_REMOVED" }, description = "Becomes visible if the Darkmoon Faire is up, and this character does not own the Darkmoon Adventurer's Guide." },

	[6] = { title = "Chromie Time", icon = 4719557, trigger = "return C_PlayerInfo.IsPlayerInChromieTime()", events = { "PLAYER_ENTERING_WORLD", "GOSSIP_SHOW", "GOSSIP_CLOSED", "QUEST_LOG_UPDATE" }, description = "Becomes visible when this character is in Chromie Time." },

	[7] = { title = "Buy Scroll of Teleport", icon = 134943, trigger = "if C_Item.GetItemCount(181163, true) == 0 then\n   for i = 1, GetMerchantNumItems() do\n      if GetMerchantItemID(i) == 181163 then\n         BuyMerchantItem(i, 1)\n      end\n   end\nend\nreturn false", events = { "MERCHANT_SHOW" }, description = "Automatically buy a Scroll of Teleport: Theater of Pain from One-Eyed Joby if you don't have one already. This flag is always hidden." }
}
