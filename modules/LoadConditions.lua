------------------------------------
-- Watchtower: LoadConditions.lua --
------------------------------------

local appName, app = ...
local L = app.locales

--------------------
-- CHARACTER INFO --
--------------------

local function getProfessions()
	local profs = {}
	profs[1], profs[2], profs[3], profs[4], profs[5] = GetProfessions()
	local professions = {}
	for i = 1, 5 do
		if profs[i] then
			local _, _, _, _, _, _, skillLine = GetProfessionInfo(profs[i])
			professions[skillLine] = true
		end
	end
	return professions
end

function app:GetLoadConditionCharacter(refresh)
	if not refresh and app.LoadConditionCharacter then return app.LoadConditionCharacter end
	local guid = UnitGUID("player")
	if not guid then return end

	local _, englishClass, _, _, _, name = GetPlayerInfoByGUID(guid)
	local _, _, _, classColor = GetClassColor(englishClass)

	local ruleset
	if app.Forever then
		if C_GameRules.IsGameRuleActive(Enum.GameRule.HardcoreRuleset) then
			ruleset = app.Enum.Ruleset.Hardcore
		elseif C_GameRules.IsGameRuleActive(Enum.GameRule.RPRuleset) and C_GameRules.IsGameRuleActive(Enum.GameRule.PvPRuleset) then
			ruleset = app.Enum.Ruleset.PvPRoleplay
		elseif C_GameRules.IsGameRuleActive(Enum.GameRule.RPRuleset) then
			ruleset = app.Enum.Ruleset.Roleplay
		elseif C_GameRules.IsGameRuleActive(Enum.GameRule.PvPRuleset) then
			ruleset = app.Enum.Ruleset.PvP
		else
			ruleset = app.Enum.Ruleset.Normal
		end
	end

	app.Settings.characters = app.Settings.characters or {}
	local character = app.Settings.characters[guid] or {}
	character.guid = guid
	character.name = name or ""
	character.realm = GetRealmName() or ""
	character.realmNorm = GetNormalizedRealmName() or ""
	character.class = englishClass or ""
	character.classColor = classColor or "ffFFFFFF"
	character.ruleset = ruleset
	character.level = UnitLevel("player") or 0
	character.professions = getProfessions()
	app.Settings.characters[guid] = character
	app.LoadConditionCharacter = character
	return character
end

app.Event:Register("PLAYER_ENTERING_WORLD", function()
	app:GetLoadConditionCharacter(true)
	if app.EditPanel and app.EditPanel:IsShown() then
		app:UpdateStatusList()
	elseif app.Tracker then
		app:UpdateAllTrackers()
	end
end)
app.Event:Register("PLAYER_LEVEL_UP", function(level)
	local character = app:GetLoadConditionCharacter(true)
	if character and type(level) == "number" then character.level = level end
	if app.EditPanel and app.EditPanel:IsShown() then
		app:UpdateStatusList()
	elseif app.Tracker then
		app:UpdateAllTrackers()
	end
end)
app.Event:Register("SKILL_LINES_CHANGED", function()
	app:GetLoadConditionCharacter(true)
	if app.EditPanel and app.EditPanel:IsShown() then
		app:UpdateStatusList()
	elseif app.Tracker then
		app:UpdateAllTrackers()
	end
end)

---------------------
-- LOAD CONDITIONS --
---------------------

function app:IsLoadConditionValid(condition)
	if type(condition) ~= "table" or not app.ValidStates[condition.condition]
	or not app.ValidStates[condition.condition][condition.conditionState] then
		return false
	end

	if condition.condition == app.Enum.Condition.Name or condition.condition == app.Enum.Condition.Realm then
		return type(condition.conditionValue) == "string" and condition.conditionValue ~= ""
	elseif condition.condition == app.Enum.Condition.Level then
		return type(condition.conditionValue) == "number"
	end

	if type(condition.conditionValue) ~= "table" then return false end
	for _, selected in pairs(condition.conditionValue) do
		if selected == true then return true end
	end
	return false
end

function app:HasLoadConditions(load)
	if type(load) ~= "table" then return false end
	for _, condition in ipairs(load) do
		if app:IsLoadConditionValid(condition) then return true end
	end
	return false
end

function app:CharacterMatchesLoadCondition(condition, character)
	local conditionValue = condition.conditionValue
	local charValue

	if condition.condition == app.Enum.Condition.Character then
		charValue = conditionValue[character.guid] == true
	elseif condition.condition == app.Enum.Condition.Name then
		charValue = character.name
	elseif condition.condition == app.Enum.Condition.Realm then
		charValue = character.realmNorm
		conditionValue = conditionValue:gsub("[ %-.]", "")
	elseif condition.condition == app.Enum.Condition.Level then
		charValue = character.level
	elseif condition.condition == app.Enum.Condition.Profession then
		local found = false
		for id, selected in pairs(conditionValue) do
			if selected and character.professions[id] then
				found = true
				break
			end
		end
		charValue = found
	elseif condition.condition == app.Enum.Condition.Class then
		charValue = conditionValue[character.class] == true
	elseif condition.condition == app.Enum.Condition.Ruleset then
		charValue = conditionValue[character.ruleset] == true
	end

	if condition.conditionState == app.Enum.ConditionState.IsAnyOf then
		return charValue == true
	elseif condition.conditionState == app.Enum.ConditionState.IsNotAnyOf then
		return charValue == false
	elseif condition.conditionState == app.Enum.ConditionState.Is then
		return charValue == conditionValue
	elseif condition.conditionState == app.Enum.ConditionState.IsNot then
		return charValue ~= conditionValue
	elseif condition.conditionState == app.Enum.ConditionState.IsLessThan then
		return charValue < conditionValue
	elseif condition.conditionState == app.Enum.ConditionState.IsGreaterThan then
		return charValue > conditionValue
	elseif condition.conditionState == app.Enum.ConditionState.StartsWith then
		return charValue:sub(1, #conditionValue) == conditionValue
	elseif condition.conditionState == app.Enum.ConditionState.EndsWith then
		return charValue:sub(-#conditionValue) == conditionValue
	elseif condition.conditionState == app.Enum.ConditionState.Contains then
		return charValue:find(conditionValue, 1, true) ~= nil
	elseif condition.conditionState == app.Enum.ConditionState.DoesNotContain then
		return charValue:find(conditionValue, 1, true) == nil
	end
	return false
end

function app:MatchesLoadConditions(load)
	if not app:HasLoadConditions(load) then return true end
	local character = app:GetLoadConditionCharacter()
	if not character then return false end
	local all = load.primary == app.Enum.ConditionState.All

	for _, condition in ipairs(load) do
		if app:IsLoadConditionValid(condition) then
			local matches = app:CharacterMatchesLoadCondition(condition, character)
			if not all and matches then return true end
			if all and not matches then return false end
		end
	end
	return all
end

function app:FlagMatchesLoadConditions(flag, group)
	if group and app:HasLoadConditions(group.load) then
		return app:MatchesLoadConditions(group.load)
	end
	return app:MatchesLoadConditions(flag.load)
end

----------------------------
-- LOAD CONDITIONS EDITOR --
----------------------------

function app:ShowLoadConditionsEditor()
	if app.LoadConditionsEditor.owner ~= app.FlagsList.Selected then
		app.LoadConditionsEditor.owner = app.FlagsList.Selected
		app.LoadConditionsEditor.working = CopyTable(type(app.FlagsList.Selected.load) == "table" and app.FlagsList.Selected.load or {}, false)
		if app.LoadConditionsEditor.working.primary ~= app.Enum.ConditionState.All then
			app.LoadConditionsEditor.working.primary = app.Enum.ConditionState.Any
		end
		if #app.LoadConditionsEditor.working == 0 then table.insert(app.LoadConditionsEditor.working, {}) end
	end
	app.LoadConditionsEditor.Help:SetText(app.FlagsList.SelFlag == 0 and L.LOADCONDITION_GROUP_HELP or L.LOADCONDITION_FLAG_HELP)
	app.LoadConditionsEditor.Subject:SetText(string.format(L.LOADCONDITION_MATCH2, "|cffFFFFFF" .. (app.FlagsList.Selected.title or "") .. "|r"))
	app:UpdateLoadConditionsEditor()
end

function app:UpdateLoadConditionsEditor()
	if not app.LoadConditionsEditor.working then return end
	app.LoadConditionsEditor.MatchDropdown:Update()

	local provider = CreateTreeDataProvider()
	for i = 1, #app.LoadConditionsEditor.working do
		provider:Insert({ id = i })
	end
	app.LoadConditionsEditor.list:SetDataProvider(provider, true)
end

function app:CreateLoadConditionsEditor()
	local page = CreateFrame("Frame", nil, app.EditPanel.Options)
	page:SetAllPoints(app.EditPanel.Options)
	app.EditPanel.Pages[21] = page
	app.EditPanel.Pages[22] = page
	app.LoadConditionsEditor = page
	page.working = { primary = app.Enum.ConditionState.Any }

	page.Help = page:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	page.Help:SetPoint("TOPLEFT", page, 12, -14)
	page.Help:SetWidth(470)
	page.Help:SetJustifyH("LEFT")
	page.Help:SetWordWrap(true)

	page.MatchText = page:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	page.MatchText:SetPoint("TOPLEFT", page.Help, "BOTTOMLEFT", 0, -20)
	page.MatchText:SetText(L.LOADCONDITION_MATCH1)

	page.MatchDropdown = CreateFrame("DropdownButton", nil, page, "WowStyle1DropdownTemplate")
	page.MatchDropdown:SetWidth(65)
	page.MatchDropdown:SetPoint("LEFT", page.MatchText, "RIGHT", 5, 0)
	page.MatchDropdown:SetupMenu(function(owner, root)
		for _, state in ipairs({ app.Enum.ConditionState.Any, app.Enum.ConditionState.All }) do
			root:CreateRadio(L.CONDITIONSTATE[state], function()
				return page.working.primary == state
			end, function()
				page.working.primary = state
				app:UpdateLoadConditionsEditor()
			end)
		end
	end)

	page.Subject = page:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	page.Subject:SetPoint("LEFT", page.MatchDropdown, "RIGHT", 6, 0)

	page.List = CreateFrame("Frame", nil, page)
	page.List:SetPoint("TOPLEFT", page.MatchText, "BOTTOMLEFT", -4, -10)
	page.List:SetPoint("BOTTOMRIGHT", page, -4, 36)

	local scrollBox = CreateFrame("Frame", nil, page.List, "WowScrollBoxList")
	scrollBox:SetPoint("TOPLEFT", page.List, 0, 0)
	scrollBox:SetPoint("BOTTOMRIGHT", page.List, -18, 0)
	local scrollBar = CreateFrame("EventFrame", nil, page.List, "MinimalScrollBar")
	scrollBar:SetPoint("TOPLEFT", scrollBox, "TOPRIGHT")
	scrollBar:SetPoint("BOTTOMLEFT", scrollBox, "BOTTOMRIGHT")

	page.list = CreateScrollBoxListTreeListView()
	ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, page.list)

	local function initializeRow(row, node)
		local id = node:GetData().id
		local condition = page.working[id]
		if not condition then return end

		row.Icon:SetText(app:IsLoadConditionValid(condition) and app.IconReady or app.IconNotReady)
		row.Icon:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_LEFT")
			GameTooltip:SetText(app:IsLoadConditionValid(condition) and L.LOADCONDITION_VALID or L.LOADCONDITION_INCOMPLETE)
			GameTooltip:Show()
		end)
		row.Icon:SetScript("OnLeave", function() GameTooltip:Hide() end)

		row.Dropdown1:SetupMenu(function(owner, root)
			local choices
			if app.Forever then
				choices = { app.Enum.Condition.Character, app.Enum.Condition.Name, app.Enum.Condition.Level, app.Enum.Condition.Ruleset, app.Enum.Condition.Profession, app.Enum.Condition.Class }
			else
				choices = { app.Enum.Condition.Character, app.Enum.Condition.Name, app.Enum.Condition.Level, app.Enum.Condition.Realm, app.Enum.Condition.Profession, app.Enum.Condition.Class }
			end
			for _, choice in ipairs(choices) do
				root:CreateRadio(L.CONDITION[choice], function()
					return condition.condition == choice
				end, function()
					condition.condition = choice
					condition.conditionState = nil
					if choice == app.Enum.Condition.Character or choice == app.Enum.Condition.Profession or choice == app.Enum.Condition.Class or choice == app.Enum.Condition.Ruleset then
						condition.conditionValue = {}
					else
						condition.conditionValue = ""
					end
					app:UpdateLoadConditionsEditor()
				end)
			end
		end)

		row.Dropdown2:SetupMenu(function(owner, root)
			for state = app.Enum.ConditionState.IsLessThan, app.Enum.ConditionState.DoesNotContain do
				if app.ValidStates[condition.condition] and app.ValidStates[condition.condition][state] then
					root:CreateRadio(L.CONDITIONSTATE[state], function()
						return condition.conditionState == state
					end, function()
						condition.conditionState = state
						app:UpdateLoadConditionsEditor()
					end)
				end
			end
		end)

		local isMulti = condition.condition == app.Enum.Condition.Character
		or condition.condition == app.Enum.Condition.Profession
		or condition.condition == app.Enum.Condition.Class
		or condition.condition == app.Enum.Condition.Ruleset
		row.Dropdown3:SetShown(isMulti)
		row.Editbox1:SetShown(condition.condition and not isMulti)
		if not isMulti then
			row.Editbox1:SetText(condition.conditionValue or "")
		end
		row.Editbox1:SetScript("OnEditFocusLost", function(self)
			local value = self:GetText() or ""
			value = value:match("^%s*(.-)%s*$") -- Trim trailing whitespaces
			if condition.condition == app.Enum.Condition.Level and value ~= "" then
				value = tonumber(value)
				if not value then value = 0 end
			elseif (condition.condition == app.Enum.Condition.Name or condition.condition == app.Enum.Condition.Realm) and value ~= "" then
				value = value:gsub("%d", "")
			end
			condition.conditionValue = value
			app:UpdateLoadConditionsEditor()
		end)

		row.Dropdown3:SetupMenu(function(owner, root)
			if type(condition.conditionValue) ~= "table" then return end
			local function isSelected(value)
				local current = page.working[id]
				return current and type(current.conditionValue) == "table" and current.conditionValue[value] == true
			end
			local function setSelected(value)
				local current = page.working[id]
				if not current or type(current.conditionValue) ~= "table" then return end
				if current.conditionValue[value] then
					current.conditionValue[value] = nil
				else
					current.conditionValue[value] = true
				end
				row.Icon:SetText(app:IsLoadConditionValid(current) and app.IconReady or app.IconNotReady)
			end
			local function addChoice(label, value)
				root:CreateCheckbox(label, isSelected, setSelected, value)
			end

			if condition.condition == app.Enum.Condition.Character then
				local characters = {}
				for _, char in pairs(app.Settings.characters or {}) do
					if char.guid and char.name and char.realmNorm then
						table.insert(characters, char)
					end
				end
				table.sort(characters, function(a, b)
					if a.name == b.name then
						return a.realmNorm < b.realmNorm
					end
					return a.name < b.name
				end)
				for _, char in ipairs(characters) do
					addChoice("|c" .. char.classColor .. char.name .. "-" .. char.realmNorm .. "|r", char.guid)
				end
			elseif condition.condition == app.Enum.Condition.Profession then
				for _, profession in ipairs(app.Professions) do
					local icon = (app.Retail and profession.retailIcon) or (app.Forever and profession.foreverIcon)
					if icon then
						local info = C_TradeSkillUI.GetProfessionInfoBySkillLineID(profession.tradeSkillLineID)
						if info and info.professionName then
							addChoice(CreateSimpleTextureMarkup(icon) .. " " .. info.professionName, profession.tradeSkillLineID)
						end
					end
				end
			elseif condition.condition == app.Enum.Condition.Class then
				for _, class in ipairs(app.Classes) do
					if app.Retail or not class.retailOnly then
						local name, file = GetClassInfo(class.id)
						if name and file then
							local _, _, _, color = GetClassColor(file)
							addChoice("|c" .. color .. name .. "|r", file)
						end
					end
				end
			elseif condition.condition == app.Enum.Condition.Ruleset then
				for id, label in ipairs(L.RULESET) do
					addChoice(label, id)
				end
			end
		end)

		row.AddButton:SetScript("OnClick", function()
			table.insert(page.working, id + 1, {})
			app:UpdateLoadConditionsEditor()
		end)
		row.RemoveButton:SetScript("OnClick", function()
			table.remove(page.working, id)
			if #page.working == 0 then table.insert(page.working, {}) end
			app:UpdateLoadConditionsEditor()
		end)
	end
	page.list:SetElementInitializer("Watchtower_LoadCondition", initializeRow)

	page.RevertButton = app:MakeButton(page, L.REVERT)
	page.RevertButton:SetPoint("BOTTOMRIGHT", page, -10, 10)
	page.RevertButton:SetScript("OnClick", function()
		page.working = CopyTable(type(page.owner.load) == "table" and page.owner.load or {}, false)
		if page.working.primary ~= app.Enum.ConditionState.All then page.working.primary = app.Enum.ConditionState.Any end
		if #page.working == 0 then table.insert(page.working, {}) end
		app:UpdateLoadConditionsEditor()
	end)

	page.ApplyButton = app:MakeButton(page, L.APPLY_CHANGES)
	page.ApplyButton:SetPoint("RIGHT", page.RevertButton, "LEFT", -4, 0)
	page.ApplyButton:SetScript("OnClick", function()
		page.owner.load = CopyTable(page.working, false)
		if app.FlagsList.SelFlag == 0 then
			for _, flag in ipairs(page.owner.flags) do app:RegisterEvents(flag, true) end
		else
			app:RegisterEvents(page.owner, true)
		end
		app:UpdateStatusList()
	end)
end
