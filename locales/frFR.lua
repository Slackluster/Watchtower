------------------------
-- My Addon: frFR.lua --
------------------------
-- French (France) localisation
-- Translator(s): Klep-Ysondre

if GetLocale() ~= "frFR" then return end
local appName, app = ...
local L = app.locales

-- Slash commands
-- L.INVALID_COMMAND =						"Invalid command."

-- Version comms
L.NEW_VERSION_AVAILABLE =				"Une nouvelle version de " .. app.NameLong .. " est disponible :"

-- Settings
-- L.SETTINGS_TOOLTIP =					app.NameLong .. "\n|cffFFFFFF" .. app.ShowIcon(app.IconLMB) .. ": ???\n" .. app.ShowIcon(app.IconRMB) .. ": Open the settings"
L.SETTINGS_SUPPORT_TEXTLONG =			"Le développement de cette extension demande beaucoup de temps et d’efforts.\nVeuillez envisager de soutenir financièrement le développeur."
L.SETTINGS_SUPPORT_TEXT =				"Soutien"
L.SETTINGS_SUPPORT_BUTTON =				"Buy Me a Coffee"	-- Brand name, if there isn't a localised version, keep it the way it is
L.SETTINGS_SUPPORT_DESC =				"Merci !"
L.SETTINGS_HELP_TEXT =					"Commentaires et aide"
L.SETTINGS_HELP_BUTTON =				"Discord"	-- Brand name, if there isn't a localised version, keep it the way it is
L.SETTINGS_HELP_DESC =					"Rejoignez le serveur Discord."
L.SETTINGS_ISSUES_TEXT =				"Suivi des problèmes"
L.SETTINGS_ISSUES_BUTTON =				"GitHub"	-- Brand name, if there isn't a localised version, keep it the way it is
L.SETTINGS_ISSUES_DESC =				"Consultez le système de suivi des problèmes (« Issues ») sur GitHub."
L.SETTINGS_URL_COPY =					"Ctrl + C pour copier :"
L.SETTINGS_URL_COPIED =					"Lien copié dans le presse-papiers"
