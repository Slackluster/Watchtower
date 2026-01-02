--------------------------
-- Watchtower: Core.lua --
--------------------------

local appName, app = ...
app.locales = {}
app.api = {}
Watchtower = app.api
local L = app.locales
local api = app.api

---------------------------
-- WOW API EVENT HANDLER --
---------------------------

app.Event = CreateFrame("Frame")
app.Event.handlers = {}

function app.Event:Register(eventName, func)
	if not self.handlers[eventName] then
		self.handlers[eventName] = {}
		self:RegisterEvent(eventName)
	end
	table.insert(self.handlers[eventName], func)
end

app.Event:SetScript("OnEvent", function(self, event, ...)
	if self.handlers[event] then
		for _, handler in ipairs(self.handlers[event]) do
			handler(...)
		end
	end
end)

-------------
-- ON LOAD --
-------------

app.Event:Register("ADDON_LOADED", function(addOnName, containsBindings)
	if addOnName == appName then
		app.Flag = {}

		C_ChatInfo.RegisterAddonMessagePrefix(app.NamePrefix)
		app.CreateSlashCommands()
	end
end)

-------------------
-- VERSION COMMS --
-------------------

function app.SendAddonMessage(message)
	if IsInRaid(2) or IsInGroup(2) then
		ChatThrottleLib:SendAddonMessage("NORMAL", app.NamePrefix, message, "INSTANCE_CHAT")
	elseif IsInRaid() then
		ChatThrottleLib:SendAddonMessage("NORMAL", app.NamePrefix, message, "RAID")
	elseif IsInGroup() then
		ChatThrottleLib:SendAddonMessage("NORMAL", app.NamePrefix, message, "PARTY")
	end
end

app.Event:Register("GROUP_ROSTER_UPDATE", function(category, partyGUID)
	local message = "version:" .. C_AddOns.GetAddOnMetadata(appName, "Version")
	app.SendAddonMessage(message)
end)

app.Event:Register("CHAT_MSG_ADDON", function(prefix, text, channel, sender, target, zoneChannelID, localID, name, instanceID)
	if prefix == app.NamePrefix then
		if not app.Flag.VersionCheck then app.Flag.VersionCheck = 0 end

		local version = text:match("version:(.+)")
		if version then
			if version ~= "@project-version@" then
				local expansion, major, minor, iteration = version:match("v(%d+)%.(%d+)%.(%d+)%-(%d+)")
				expansion = string.format("%02d", expansion)
				major = string.format("%02d", major)
				minor = string.format("%02d", minor)
				local otherGameVersion = tonumber(expansion .. major .. minor)
				local otherAddonVersion = tonumber(iteration)

				local localVersion = C_AddOns.GetAddOnMetadata(appName, "Version")
				if localVersion ~= "@project-version@" then
					expansion, major, minor, iteration = localVersion:match("v(%d+)%.(%d+)%.(%d+)%-(%d+)")
					expansion = string.format("%02d", expansion)
					major = string.format("%02d", major)
					minor = string.format("%02d", minor)
					local localGameVersion = tonumber(expansion .. major .. minor)
					local localAddonVersion = tonumber(iteration)

					if otherGameVersion > localGameVersion or (otherGameVersion == localGameVersion and otherAddonVersion > localAddonVersion) then
						if GetServerTime() - app.Flag.VersionCheck > 600 then
							app.Print(L.NEW_VERSION_AVAILABLE, version)
							app.Flag.VersionCheck = GetServerTime()
						end
					end
				end
			end
		end
	end
end)

--------------------
-- SLASH COMMANDS --
--------------------

function app.CreateSlashCommands()
	SLASH_RELOADUI1 = "/rl"
	SlashCmdList.RELOADUI = ReloadUI

	SLASH_Watchtower1 = "/wst"
	SLASH_Watchtower2 = "/watch"
	function SlashCmdList.Watchtower(msg, editBox)
		local command, rest = msg:match("^(%S*)%s*(.-)$")

		if command == "settings" then
			app.OpenSettings()
		else
			app.Print(L.INVALID_COMMAND)
		end
	end
end

----------------------
-- HELPER FUNCTIONS --
----------------------

function app.Colour(string)
	return "|cff3FC7EB" .. string .. "|R"
end

function app.ShowIcon(iconPath)
	return "|T" .. iconPath .. ":0|t"
end

function app.Print(...)
	print(app.NameShort .. ":", ...)
end
