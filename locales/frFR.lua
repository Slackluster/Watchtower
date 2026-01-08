--------------------------
-- Watchtower: frFR.lua --
--------------------------
-- French (France) localisation
-- Translator(s): Klep-Ysondre

if GetLocale() ~= "frFR" then return end
local appName, app = ...
local L = app.locales

-- Settings
-- L.SETTINGS_VERSION =					GAME_VERSION_LABEL .. ":"	-- "Version"
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

L.SETTINGS_KEYSLASH_TITLE =				SETTINGS_KEYBINDINGS_LABEL .. " & Commandes « Slash »"	-- "Keybindings"
-- _G["BINDING_NAME_WATCHTOWER_TOGGLE"] =	"Toggle Edit Panel"
L.INVALID_COMMAND =						"Commande non valide."
-- L.SLASH_OPEN_SETTINGS =					"Ouvrir les paramètres"
-- L.SLASH_TOGGLE_EDITPANEL =				"Toggle the edit panel"

-- L.GENERAL =								GENERAL	-- "General"

-- General
L.NEW_VERSION_AVAILABLE =				"Une nouvelle version de " .. app.NameLong .. " est disponible :"
-- L.SETTINGS_TOOLTIP =					app.NameLong .. "\n|cffFFFFFF"
-- 										.. app:ShowIcon(app.IconLMB) .. ": " .. L.SLASH_TOGGLE_EDITPANEL .. "\n"
-- 										.. app:ShowIcon(app.IconRMB) .. ": " .. L.SLASH_OPEN_SETTINGS

-- L.OR =									"or"
