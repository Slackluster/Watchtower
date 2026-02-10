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

------------
-- IMPORT --
------------

function app:CreateImportPopup()
	StaticPopupDialogs["WATCHTOWER_IMPORT"] = {
		text = app.NameLong .. ": " .. L.IMPORT,
		button1 = CONTINUE,
		button2 = CANCEL,
		whileDead = true,
		hasEditBox = true,
		editBoxWidth = 240,
		OnShow = function(dialog)
			dialog:ClearAllPoints()
			dialog:SetPoint("CENTER", UIParent)

			local editBox = dialog.GetEditBox and dialog:GetEditBox() or dialog.editBox
			editBox:SetText("")
			editBox:SetAutoFocus(true)
			editBox:SetScript("OnEditFocusLost", function()
				editBox:SetFocus()
			end)
			editBox:SetScript("OnEscapePressed", function()
				dialog:Hide()
			end)
		end,
		OnAccept = function(dialog)
			local editBox = dialog.GetEditBox and dialog:GetEditBox() or dialog.editBox
			local importString = editBox:GetText()
			api:Import(importString)
		end,
		OnHide = function(dialog)
			local editBox = dialog.GetEditBox and dialog:GetEditBox() or dialog.editBox
			editBox:SetScript("OnEditFocusLost", nil)
			editBox:SetScript("OnEscapePressed", nil)
			editBox:SetText("")
		end,
	}
end

function api:Import(importString)
	assert(self == api, "Call api:Import(), not api.Import()")

	if type(importString) ~= "string" or not importString:match("^WT1:") then
		app:Print(L.IMPORT_ERROR .. " " .. L.ERROR_INVALID_IMPORT_STRING)
		return false
	end

	local _, _, importType, payload = importString:find("^WT1:(%a+):(.+)$")

	local ok, compressed = pcall(C_EncodingUtil.DecodeBase64, payload, Enum.Base64Variant.Standard)
	if not ok or not compressed then
		app:Print(L.IMPORT_ERROR .. " " .. L.ERROR_DECODE .. 1)
		return false
	end

	local ok2, cbor = pcall(C_EncodingUtil.DecompressString, compressed, Enum.CompressionMethod.Deflate)
	if not ok2 or not cbor then
		app:Print(L.IMPORT_ERROR .. " " .. L.ERROR_DECODE .. 2)
		return false
	end

	local ok3, data = pcall(C_EncodingUtil.DeserializeCBOR, cbor)
	if not ok3 or type(data) ~= "table" then
		app:Print(L.IMPORT_ERROR .. " " .. L.ERROR_DECODE .. 3)
		return false
	end

	local error
	local function checkFlag(flg)
		local valid = app:TestTrigger(flg)
		if not valid then
			local err = L.IMPORT_ERROR .. " " .. string.format(L.ERROR_BLOCKED, flg.title)
			return false, err
		end
		return true
	end

	if importType == "flag" then
		_, error = checkFlag(data)
	elseif importType == "group" then
		for i, flag in ipairs(data.flags) do
			_, error = checkFlag(flag)
		end
	else
		app:Print(L.IMPORT_ERROR .. " " .. L.ERROR_INVALID_IMPORT_STRING)
		return false
	end

	if error then
		app:Print(error)
		return false
	end

	if importType == "flag" then
		table.insert(Watchtower_Flags[1].flags, data)
		Watchtower_Flags[1].flags[#Watchtower_Flags[1].flags].flagID = #Watchtower_Flags[1].flags
		app.FlagsList.SelGroup = 1
		app.FlagsList.SelFlag = #Watchtower_Flags[1].flags

		Watchtower_Flags[1].collapsed = false
	elseif importType == "group" then
		table.insert(Watchtower_Flags, data)
		Watchtower_Flags[#Watchtower_Flags].groupID = #Watchtower_Flags
		app.FlagsList.SelGroup = #Watchtower_Flags
		app.FlagsList.SelFlag = 0

		local id = #Watchtower_Flags
		app:CreateTracker(id)
		if app.EditPanel:IsShown() then
			app.Tracker[id].window:EnableMouse(true)
			app.Tracker[id].window.corner:Show()
			app.Tracker[id].window:SetBackdropColor(0, 0, 0, 0.5)
			app.Tracker[id].window:SetBackdropBorderColor(0.25, 0.78, 0.92, 0.5)
		end
	end

	app:RegisterEvents()
	app:UpdateStatusList()
end

------------
-- EXPORT --
------------

function app:CreateExportPopup()
	StaticPopupDialogs["WATCHTOWER_EXPORT"] = {
		text = app.NameLong,
		button1 = CLOSE,
		whileDead = true,
		hasEditBox = true,
		editBoxWidth = 240,
		OnShow = function(dialog)
			dialog:ClearAllPoints()
			dialog:SetPoint("CENTER", UIParent)
			StaticPopup1Text:SetText(app.NameLong .. ": " .. app.EditPanel.ExportButton:GetText())

			local exportType = (app.FlagsList.SelFlag == 0) and "group" or "flag"
			local exportString = api:Export(app.FlagsList.Selected, exportType)

			local editBox = dialog.GetEditBox and dialog:GetEditBox() or dialog.editBox
			editBox:SetText(exportString)
			editBox:SetAutoFocus(true)
			editBox:HighlightText()
			editBox:SetScript("OnEditFocusLost", function()
				editBox:SetFocus()
			end)
			editBox:SetScript("OnEscapePressed", function()
				dialog:Hide()
			end)
			editBox:SetScript("OnTextChanged", function()
				editBox:SetText(exportString)
				editBox:HighlightText()
			end)
			editBox:SetScript("OnKeyUp", function(self, key)
				if (IsControlKeyDown() and (key == "C" or key == "X")) then
					dialog:Hide()
					app.LinkCopiedFrame.Text:SetText(app:ShowIcon(app.IconReady) .. " " .. L.EXPORT_COPIED)
					app.LinkCopiedFrame:Show()
					app.LinkCopiedFrame:SetAlpha(1)
					app.LinkCopiedFrame.animation:Play()
				end
			end)
		end,
		OnHide = function(dialog)
			local editBox = dialog.GetEditBox and dialog:GetEditBox() or dialog.editBox
			editBox:SetScript("OnEditFocusLost", nil)
			editBox:SetScript("OnEscapePressed", nil)
			editBox:SetScript("OnTextChanged", nil)
			editBox:SetScript("OnKeyUp", nil)
			editBox:SetText("")
		end,
	}
end

function api:Export(table, exportType)
	assert(self == api, "Call api:Export(), not api.Export()")
	assert(exportType == "flag" or exportType == "group", "exportType for api:Export() must be \"flag\" or \"group\"")

	local function deepCopy(orig)
		if type(orig) ~= "table" then
			return orig
		end

		local copy = {}
		for k, v in pairs(orig) do
			copy[deepCopy(k)] = deepCopy(v)
		end
		return copy
	end
	local flagOrGroup = deepCopy(table)

	local _, error
	local function checkFlag(flg)
		flg.handles = nil
		local valid = app:TestTrigger(flg)
		if not valid then
			local err = L.EXPORT_ERROR .. " " .. string.format(L.ERROR_BLOCKED, flg.title)
			return false, err
		end
		return true
	end

	if exportType == "flag" then
		flagOrGroup.flagID = nil
		_, error = checkFlag(flagOrGroup)
	elseif exportType == "group" then
		flagOrGroup.groupID = nil
		for i, flag in ipairs(flagOrGroup.flags) do
			_, error = checkFlag(flag)
		end
	end

	if error then
		return error
	end
	local ok, cbor = pcall(C_EncodingUtil.SerializeCBOR, flagOrGroup)
	if not ok then
		return L.EXPORT_ERROR .. " " .. L.ERROR_UNKNOWN
	end

	local compressed = C_EncodingUtil.CompressString(cbor, Enum.CompressionMethod.Deflate, Enum.CompressionLevel.OptimizeForSize)
	local base64 = C_EncodingUtil.EncodeBase64(compressed, Enum.Base64Variant.Standard)
	local output = "WT1:" .. exportType .. ":" .. base64
	return output
end
