------------------------------
-- Watchtower: Database.lua --
------------------------------

local appName, app = ...

app.Name = "Watchtower"
app.NameLong = app:Colour(app.Name)
app.NameShort = app:Colour("WT")
app.NamePrefix = "Watchtower"
_G["BINDING_NAME_WATCHTOWER"] = app.Name
_G["BINDING_NAME_SLACKWARE"] = "Slackware"

app.Icon = "Interface\\Icons\\achievement_bg_defendxtowers_av"
app.IconReady = CreateSimpleTextureMarkup("Interface\\RaidFrame\\ReadyCheck-Ready")
app.IconNotReady = CreateSimpleTextureMarkup("Interface\\RaidFrame\\ReadyCheck-NotReady")
app.IconLMB = CreateAtlasMarkup("housing-hotkey-icon-leftclick")
app.IconRMB = CreateAtlasMarkup("housing-hotkey-icon-rightclick")

app.Classes = {
	{ classFile = "MAGE", id = 8 },
	{ classFile = "PRIEST", id = 5 },
	{ classFile = "WARLOCK", id = 9 },
	{ classFile = "DEMONHUNTER", id = 12, retailOnly = true },
	{ classFile = "DRUID", id = 11 },
	{ classFile = "MONK", id = 10, retailOnly = true },
	{ classFile = "ROGUE", id = 4 },
	{ classFile = "EVOKER", id = 13, retailOnly = true },
	{ classFile = "HUNTER", id = 3 },
	{ classFile = "SHAMAN", id = 7 },
	{ classFile = "DEATHKNIGHT", id = 6, retailOnly = true },
	{ classFile = "PALADIN", id = 2 },
	{ classFile = "WARRIOR", id = 1 },
}

app.Professions = {
	{ tradeSkillLineID = 171, retailIcon = 4620669, foreverIcon = 136240 }, -- Alchemy
	{ tradeSkillLineID = 164, retailIcon = 4620670, foreverIcon = 136241 }, -- Blacksmithing
	{ tradeSkillLineID = 333, retailIcon = 4620672, foreverIcon = 136244 }, -- Enchanting
	{ tradeSkillLineID = 202, retailIcon = 4620673, foreverIcon = 136243 }, -- Engineering
	{ tradeSkillLineID = 773, retailIcon = 4620676 }, -- Inscription
	{ tradeSkillLineID = 755, retailIcon = 4620677 }, -- Jewelcrafting
	{ tradeSkillLineID = 165, retailIcon = 4620678, foreverIcon = 136247 }, -- Leatherworking
	{ tradeSkillLineID = 197, retailIcon = 4620681, foreverIcon = 136249 }, -- Tailoring
	{ tradeSkillLineID = 182, retailIcon = 4620675, foreverIcon = 136065 }, -- Herbalism
	{ tradeSkillLineID = 186, retailIcon = 4620679, foreverIcon = 136248 }, -- Mining
	{ tradeSkillLineID = 393, retailIcon = 4620680, foreverIcon = 134366 }, -- Skinning
	{ tradeSkillLineID = 185, retailIcon = 4620671, foreverIcon = 133971 }, -- Cooking
	{ tradeSkillLineID = 356, retailIcon = 4620674, foreverIcon = 136245 }, -- Fishing
	{ tradeSkillLineID = 794, retailIcon = 441139 }, -- Archaeology
	{ tradeSkillLineID = 129, foreverIcon = 135966 }, -- First Aid
}

app.Enum = {
	Condition = {
		Character = 1,
		Name = 2,
		Level = 3,
		Realm = 4,
		Profession = 5,
		Class = 6,
		Ruleset = 7,
	},
	ConditionState = {
		Any = 1,
		All = 2,
		IsLessThan = 3,
		Is = 4,
		IsAnyOf = 5,
		IsGreaterThan = 6,
		IsNot = 7,
		IsNotAnyOf = 8,
		StartsWith = 9,
		EndsWith = 10,
		Contains = 11,
		DoesNotContain = 12,
	},
	Ruleset = {
		Normal = 1,
		PvP = 2,
		Roleplay = 3,
		PvPRoleplay = 4,
		Hardcore = 5,
	}
}

app.ValidStates = {
	[app.Enum.Condition.Character] = {
		[app.Enum.ConditionState.IsAnyOf] = true,
		[app.Enum.ConditionState.IsNotAnyOf] = true,
	},
	[app.Enum.Condition.Name] = {
		[app.Enum.ConditionState.Is] = true,
		[app.Enum.ConditionState.IsNot] = true,
		[app.Enum.ConditionState.StartsWith] = true,
		[app.Enum.ConditionState.EndsWith] = true,
		[app.Enum.ConditionState.Contains] = true,
		[app.Enum.ConditionState.DoesNotContain] = true,
	},
	[app.Enum.Condition.Level] = {
		[app.Enum.ConditionState.IsLessThan] = true,
		[app.Enum.ConditionState.Is] = true,
		[app.Enum.ConditionState.IsGreaterThan] = true,
	},
	[app.Enum.Condition.Realm] = {
		[app.Enum.ConditionState.Is] = true,
		[app.Enum.ConditionState.IsNot] = true,
		[app.Enum.ConditionState.StartsWith] = true,
		[app.Enum.ConditionState.EndsWith] = true,
		[app.Enum.ConditionState.Contains] = true,
		[app.Enum.ConditionState.DoesNotContain] = true,
	},
	[app.Enum.Condition.Profession] = {
		[app.Enum.ConditionState.IsAnyOf] = true,
		[app.Enum.ConditionState.IsNotAnyOf] = true,
	},
	[app.Enum.Condition.Class] = {
		[app.Enum.ConditionState.IsAnyOf] = true,
		[app.Enum.ConditionState.IsNotAnyOf] = true,
	},
	[app.Enum.Condition.Ruleset] = {
		[app.Enum.ConditionState.IsAnyOf] = true,
		[app.Enum.ConditionState.IsNotAnyOf] = true,
	},
}

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
	[4] = { icon = 237388, trigger = "if InCombatLockdown() then return end\nC_Calendar.OpenCalendar()\nlocal dmf = false\nlocal date = C_DateAndTime.GetCurrentCalendarTime()\nlocal numEvents = C_Calendar.GetNumDayEvents(0, date.monthDay)\nfor i=1,numEvents do\n   local event = C_Calendar.GetDayEvent(0,date.monthDay,i)\n   if event ~= nil then\n      if event.eventID == 479 then\n         dmf = true\n         break\n      end\n   end\nend\nif dmf and not(C_QuestLog.IsQuestFlaggedCompleted(38934)) then\n   return true\nelse\n   return false\nend", events = { "PLAYER_ENTERING_WORLD", "QUEST_TURNED_IN", "QUEST_AUTOCOMPLETE", "QUEST_REMOVED" } },
	[5] = { icon = 354435, trigger = "if InCombatLockdown() then return end\nC_Calendar.OpenCalendar()\nlocal dmf = false\nlocal date = C_DateAndTime.GetCurrentCalendarTime()\nlocal numEvents = C_Calendar.GetNumDayEvents(0, date.monthDay)\nfor i=1,numEvents do\n   local event = C_Calendar.GetDayEvent(0,date.monthDay,i)\n   if event ~= nil then\n      if event.eventID == 479 then\n         dmf = true\n         break\n      end\n   end\nend\nif dmf and C_Item.GetItemCount(71634, true) == 0 then\n   return true\nelse\n   return false\nend", events = { "PLAYER_ENTERING_WORLD", "QUEST_TURNED_IN", "QUEST_AUTOCOMPLETE", "QUEST_REMOVED" } },
	[6] = { icon = 4719557, trigger = "return C_PlayerInfo.IsPlayerInChromieTime()", events = { "PLAYER_ENTERING_WORLD", "GOSSIP_SHOW", "GOSSIP_CLOSED", "QUEST_LOG_UPDATE" } },
	[7] = { icon = 134943, trigger = "if C_Item.GetItemCount(181163, true) == 0 then\n   for i = 1, GetMerchantNumItems() do\n      if GetMerchantItemID(i) == 181163 then\n         BuyMerchantItem(i, 1)\n      end\n   end\nend\nreturn false", events = { "MERCHANT_SHOW" } }
}
