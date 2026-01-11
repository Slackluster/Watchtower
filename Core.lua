--------------------------
-- Watchtower: Core.lua --
--------------------------

local appName, app = ...
app.locales = {}
app.api = {}
Watchtower = app.api
local api = app.api
local L = app.locales

---------------------------
-- WOW API EVENT HANDLER --
---------------------------

app.Event = CreateFrame("Frame")
app.Event.handlers = {}
app.Event.nextId = 0

function app.Event:Register(eventName, func)
	self.nextId = self.nextId + 1
	local id = self.nextId

	if not self.handlers[eventName] then
		self.handlers[eventName] = {}
		self:RegisterEvent(eventName)
	end

	self.handlers[eventName][id] = func
	return { event = eventName, id = id }
end

app.Event:SetScript("OnEvent", function(self, event, ...)
	local handlers = self.handlers[event]
	if not handlers then return end

	for _, handler in pairs(handlers) do
		handler(...)
	end
end)

function app.Event:Unregister(handle)
	local event = handle.event
	local id = handle.id

	local handlers = self.handlers[event]
	if not handlers then return end

	handlers[id] = nil

	if not next(handlers) then
		self.handlers[event] = nil
		self:UnregisterEvent(event)
	end
end

-------------
-- ON LOAD --
-------------

app.Event:Register("ADDON_LOADED", function(addOnName, containsBindings)
	if addOnName == appName then
		app.Flag = {}

		C_ChatInfo.RegisterAddonMessagePrefix(app.NamePrefix)
		app:CreateSlashCommands()
	end
end)

-------------------
-- VERSION COMMS --
-------------------

function app:SendAddonMessage(message)
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
	app:SendAddonMessage(message)
end)

app.Event:Register("CHAT_MSG_ADDON", function(prefix, text, channel, sender, target, zoneChannelID, localID, name, instanceID)
	if prefix == app.NamePrefix then
		local version = text:match("version:(.+)")
		if version and not app.Flag.VersionCheck then
			local expansion, major, minor, iteration = version:match("v(%d+)%.(%d+)%.(%d+)%-(%d+)")
			if expansion then
				expansion = string.format("%02d", expansion)
				major = string.format("%02d", major)
				minor = string.format("%02d", minor)
				local otherGameVersion = tonumber(expansion .. major .. minor)
				local otherAddonVersion = tonumber(iteration)

				local localVersion = C_AddOns.GetAddOnMetadata(appName, "Version")
				local expansion2, major2, minor2, iteration2 = localVersion:match("v(%d+)%.(%d+)%.(%d+)%-(%d+)")
				if expansion2 then
					expansion2 = string.format("%02d", expansion2)
					major2 = string.format("%02d", major2)
					minor2 = string.format("%02d", minor2)
					local localGameVersion = tonumber(expansion2 .. major2 .. minor2)
					local localAddonVersion = tonumber(iteration2)

					if otherGameVersion > localGameVersion or (otherGameVersion == localGameVersion and otherAddonVersion > localAddonVersion) then
						app:Print(L.NEW_VERSION_AVAILABLE, version)
						app.Flag.VersionCheck = true
					end
				end
			end
		end
	end
end)

--------------------
-- SLASH COMMANDS --
--------------------

function app:CreateSlashCommands()
	SLASH_RELOADUI1 = "/rl"
	SlashCmdList.RELOADUI = ReloadUI

	SLASH_Watchtower1 = "/wt"
	SLASH_Watchtower2 = "/watch"
	function SlashCmdList.Watchtower(msg, editBox)
		local command, rest = msg:match("^(%S*)%s*(.-)$")

		if command == "settings" then
			app:OpenSettings()
		elseif command == "" then
			api:ToggleEditPanel()
		else
			app:Print(L.INVALID_COMMAND)
		end
	end
end

-----------------------
-- ADDON COMPARTMENT --
-----------------------

function Watchtower_Click(self, button)
	if button == "LeftButton" then
		api:ToggleEditPanel()
	elseif button == "RightButton" then
		app:OpenSettings()
	end
end

function Watchtower_Enter(self, button)
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(type(self) ~= "string" and self or button, "ANCHOR_LEFT")
	GameTooltip:AddLine(L.SETTINGS_TOOLTIP)
	GameTooltip:Show()
end

function Watchtower_Leave()
	GameTooltip:Hide()
end

----------------------
-- HELPER FUNCTIONS --
----------------------

function app:Colour(string)
	return "|cff3FC7EB" .. string .. "|r"
end

function app:ShowIcon(iconPath)
	return "|T" .. iconPath .. ":0|t"
end

function app:Print(...)
	print(app.NameShort .. ":", ...)
end

function app:SetBorder(parent, a, b, c, d)
	local border = CreateFrame("Frame", nil, parent, "BackdropTemplate")
	border:SetPoint("TOPLEFT", parent, a or 0, b or 0)
	border:SetPoint("BOTTOMRIGHT", parent, c or 0, d or 0)
	border:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 14,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	border:SetBackdropColor(0, 0, 0, 0)
	border:SetBackdropBorderColor(0.25, 0.78, 0.92)
end

function app:MakeButton(parent, text)
	local frame = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	frame:SetText(text)
	frame:SetWidth(frame:GetTextWidth()+20)

	app:SetBorder(frame, 0, 0, 0, -1)
	return frame
end
