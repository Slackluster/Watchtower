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

	return { event = eventName, func = func, }
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
	local function triggerErrorHandler(err, flg)
		--local stack = debugstack(err, 2, 5)
		return string.format(L.FLAG_ERROR_LUA .. " '%s'\n", flg.title or UNKNOWN, err)
	end

	local debug = not not flag
	local function handleEvents(flg)
		if not flg.trigger then return end

		local valid, func, result = app:IsTriggerValid(flg, debug)
		if not valid then return end

		flg.lastResult = result

		for _, event in ipairs(flg.events) do
			local wrapper = function(...)
				local ok, result = xpcall(func, function(err) return triggerErrorHandler(err, flg) end, ...)
				if not ok then
					flg.lastResult = false
					error(result, 0)
				end

				flg.lastResult = result
				RunNextFrame(function() app:UpdateAllTrackers() end)
			end

			local handle = app.UserEvent:Register(event, wrapper)
			table.insert(flg.handles, handle)
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

	local function blockedError(msg)
		error({ blocked = true, message = msg }, 2)
	end

	local safeG = setmetatable({}, {
		__index = function(_, key)
			if app.Blocked[key] then
				blockedError((L.ERROR_BLOCKED1):format(tostring(key)))
			end
			return _G[key]
		end,
		__newindex = function(_, key, value)
			if app.Blocked[key] then
				blockedError((L.ERROR_BLOCKED1):format(tostring(key)))
			end
			_G[key] = value
		end,
	})
	env._G = safeG

	setmetatable(env, {
		__index = function(tbl, key)
			if app.Blocked[key] then
				blockedError((L.ERROR_BLOCKED1):format(tostring(key)))
			end
			local v = rawget(tbl, key)
			if v ~= nil then return v end
			return _G[key]
		end,
		__newindex = function(tbl, key, value)
			if app.Blocked[key] then
				blockedError((L.ERROR_BLOCKED1):format(tostring(key)))
			end
			rawset(tbl, key, value)
		end,
	})

	return env
end

function app:IsTriggerSafe(flag)
	if not flag.trigger then
		return true
	end

	local func, err = loadstring(flag.trigger)
	if not func then
		return true
	end

	local env = app:CreateTriggerEnv()
	setfenv(func, env)

	local ok, result = pcall(func)
	if not ok then
		if type(result) == "table" and result.blocked then
			return false, result.message
		end
	end

	return true
end

function app:IsTriggerValid(flag, debug)
	if not flag.trigger then
		return false
	end

	local safe, blockedErr = app:IsTriggerSafe(flag)
	if not safe then
		if debug then
			app:Print(L.FUNCTION_ERROR .. " " .. tostring(blockedErr))
		end
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
