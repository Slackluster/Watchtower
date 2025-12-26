----------------------------
-- My Addon: Database.lua --
----------------------------

local appName, app = ...

-- Strings
app.Name = "My Addon"
app.NameLong = app.Colour(app.Name)
app.NameShort = app.Colour("???")
app.NamePrefix = "MyAddon"

-- Textures
app.Icon = "Interface\\AddOns\\???\\assets\\???_icon.blp"
app.IconReady = "Interface\\RaidFrame\\ReadyCheck-Ready"
app.IconNotReady = "Interface\\RaidFrame\\ReadyCheck-NotReady"
app.IconLMB = "Interface\\TutorialFrame\\UI-Tutorial-Frame:12:12:0:0:512:512:10:65:228:283"
app.IconRMB = "Interface\\TutorialFrame\\UI-Tutorial-Frame:12:12:0:0:512:512:10:65:330:385"
