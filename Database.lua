------------------------------
-- Watchtower: Database.lua --
------------------------------

local appName, app = ...

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
