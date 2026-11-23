--------------------------------
-- Watchtower: UserEvents.lua --
--------------------------------

local appName, app = ...
local L = app.locales

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
		handler(event, ...)
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

function app:RegisterEvents(flag, silent)
	local function triggerErrorHandler(err, flg, event)
		return string.format(L.FLAG_ERROR_LUA .. " %s\n", flg.title or UNKNOWN, event or UNKNOWN, err)
	end

	local function runWhenTruthy(flg, result)
		flg.lastResult = result

		if flg.actions then
			if flg.actions.hideAfter and type(flg.actions.hideAfter) == "number" and flg.actions.hideAfter > 0 then
				C_Timer.After(flg.actions.hideAfter, function()
					flg.lastResult = false
					app:UpdateAllTrackers()
				end)
			end
		end
	end

	local debug = not not flag and not silent
	local function handleEvents(flg, group)
		if not flg.trigger then return end

		local matches = app:FlagMatchesLoadConditions(flg, group)
		local valid, func, result = app:IsTriggerValid(flg, debug, not matches)
		if not valid then return end

		if matches and result then
			runWhenTruthy(flg, result)
		else
			flg.lastResult = false
		end

		local wrapper = function(event, ...)
			if not app:FlagMatchesLoadConditions(flg, group) then
				if flg.lastResult then
					flg.lastResult = false
					RunNextFrame(function() app:UpdateAllTrackers() end)
				end
				return
			end
			local ok, result = xpcall(func, function(err) return triggerErrorHandler(err, flg, event) end, event, ...)
			if not ok then
				flg.lastResult = false
				error(result, 0)
			end

			if result then
				runWhenTruthy(flg, result)
			else
				flg.lastResult = false
			end
			RunNextFrame(function() app:UpdateAllTrackers() end)
		end

		for _, event in ipairs(flg.events) do
			local handle = app.UserEvent:Register(event, wrapper)
			table.insert(flg.handles, handle)
		end
	end

	if flag then
		app:DeRegisterEvents(flag)
		for i = 2, #app.Flags do
			for _, flg in ipairs(app.Flags[i].flags) do
				if flg == flag then handleEvents(flag, app.Flags[i]); return end
			end
		end
	else
		local allFlags = {}
		for i = 2, #app.Flags do
			for _, flg in ipairs(app.Flags[i].flags) do
				table.insert(allFlags, { flag = flg, group = app.Flags[i] })
			end
		end

		local addonCount = C_AddOns.GetNumAddOns()
		local loadedCount = 0
		for i = 1, addonCount do
			if C_AddOns.IsAddOnLoaded(i) then
				loadedCount = loadedCount + 1
			end
		end

		local flagsPerSecond = math.max(1, 10 - math.floor(loadedCount / 50)) -- Throttle proportionally
		C_Timer.After(#allFlags/flagsPerSecond + 1, function() -- Delay execution proportionally
			app.Flag.UpdatingAll = true
			C_Timer.After(#allFlags/flagsPerSecond + 1, function()
				app.Flag.UpdatingAll = false
				app:UpdateAllTrackers()
			end)

			for i = 1, #allFlags do
				C_Timer.After(i/flagsPerSecond, function()
					app:DeRegisterEvents(allFlags[i].flag)
					handleEvents(allFlags[i].flag, allFlags[i].group)
				end)
			end
		end)
	end
end

-------------
-- SANDBOX --
-------------

function app:CreateTriggerEnv() -- Vibecoded, feedback appreciated
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

function app:IsTriggerSafe(flag, skipExecution)
	if not flag.trigger then
		return true
	end

	local func = loadstring(flag.trigger)
	if not func then
		return true
	end

	setfenv(func, app:CreateTriggerEnv())

	if skipExecution then return true, func, nil, true end
	local ok, result = pcall(func)
	if not ok then
		if type(result) == "table" and result.blocked then
			return false, nil, result.message
		end
	end

	return true, func, result, ok
end

function app:IsTriggerValid(flag, debug, skipExecution)
	if not flag.trigger then
		return false
	end

	local safe, func, result, ok = app:IsTriggerSafe(flag, skipExecution)
	if not safe then
		if debug then
			app:Print(L.FUNCTION_ERROR, tostring(result))
		end
		return false
	elseif not func then
		return false
	end

	if not ok then
		if debug then app:Print(L.FUNCTION_ERROR, tostring(result)) end
		return false
	end

	if debug and not skipExecution then app:Print(L.FUNCTION_OUTPUT, tostring(result)) end
	return true, func, result
end
