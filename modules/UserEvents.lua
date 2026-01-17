-------------------------------
-- Watchtower: EditPanel.lua --
-------------------------------

local appName, app = ...
local api = app.api
local L = app.locales

-------------
-- ON LOAD --
-------------

app.Event:Register("ADDON_LOADED", function(addOnName, containsBindings)
	if addOnName == appName then
		app:CreateImportPopup()
		app:CreateExportPopup()
	end
end)

------------------------
-- USER EVENT HANDLER --
------------------------

app.UserEvent = CreateFrame("Frame")
app.UserEvent.handlers = {}

function app.UserEvent:Register(eventName, func)
	if not self.handlers[eventName] then
		self.handlers[eventName] = {}
		self:RegisterEvent(eventName)
	end

	table.insert(self.handlers[eventName], func)

	return { event = eventName, func  = func, }
end

app.UserEvent:SetScript("OnEvent", function(self, event, ...)
	local handlers = self.handlers[event]
	if not handlers then return end

	for _, handler in ipairs(handlers) do
		handler(...)
	end
end)

function app.UserEvent:Unregister(handle)
	local handlers = self.handlers[handle.event]
	if not handlers then return end

	for i, fn in ipairs(handlers) do
		if fn == handle.func then
			table.remove(handlers, i)
			break
		end
	end

	if #handlers == 0 then
		self.handlers[handle.event] = nil
		self:UnregisterEvent(handle.event)
	end
end

-----------------------------
-- USER EVENT REGISTRATION --
-----------------------------

function app:DeRegisterEvents(flag)
	if flag.handles then
		for _, handle in ipairs(flag.handles) do
			app.UserEvent:Unregister(handle)
		end
	end
	flag.handles = {}
end

function app:RegisterEvents(flag)
	if flag then debug = true end
	local function handleEvents(flag)
		if not flag.trigger then return end

		local valid, func, result = app:TestTrigger(flag, debug)
		if not valid then return end

		flag.lastResult = result

		for _, event in ipairs(flag.events) do
			local wrapper = function(...)
				local ok, r = pcall(func, ...)
				flag.lastResult = ok and r or false
				RunNextFrame(function() app:UpdateAllTrackers() end)
			end

			local handle = app.UserEvent:Register(event, wrapper)
			table.insert(flag.handles, handle)
		end
	end

	if flag then
		app:DeRegisterEvents(flag)
		handleEvents(flag)
	else
		for i = 2, #Watchtower_Flags do
			for _, flg in ipairs(Watchtower_Flags[i].flags) do
				app:DeRegisterEvents(flg)
				handleEvents(flg)
			end
		end
	end
end

-------------
-- SANDBOX --
-------------

function app:CreateTriggerEnv()	-- Vibecoded, feedback appreciated
	local env = {}

	local safeG = setmetatable({}, {
		__index = function(_, key)
			if app.Blocked[key] then
				error((L.ERROR_BLOCKED1):format(tostring(key)), 2)
			end
			return _G[key]
		end,
			__newindex = function(_, key, value)
			if app.Blocked[key] then
				error((L.ERROR_BLOCKED2):format(tostring(key)), 2)
			end
			_G[key] = value
		end,
	})
	env._G = safeG

	setmetatable(env, {
		__index = function(tbl, key)
			if app.Blocked[key] then
				error((L.ERROR_BLOCKED1):format(tostring(key)), 2)
			end
			local v = rawget(tbl, key)
			if v ~= nil then return v end
			return _G[key]
		end,
		__newindex = function(tbl, key, value)
			if app.Blocked[key] then
				error((L.ERROR_BLOCKED2):format(tostring(key)), 2)
			end
			rawset(tbl, key, value)
		end,
	})

	return env
end

function app:TestTrigger(flag, debug)
	if not flag.trigger then
		return false
	end

	local func, error = loadstring(flag.trigger)
	if error then
		if debug then app:Print(L.FUNCTION_ERROR .. " " .. tostring(error)) end
		return false
	end

	local env = app:CreateTriggerEnv()
	setfenv(func, env)

	local ok, result = pcall(func)
	if not ok then
		if debug then app:Print(L.FUNCTION_ERROR .. " " .. tostring(result)) end
		return false
	end

	if debug then app:Print(L.FUNCTION_OUTPUT .. " " .. tostring(result)) end
	return true, func, result
end
