local E, L = select(2, ...):unpack()

E.moduleOptions = {}
E.optionsFrames = {}

function E.ConfirmAction()
	return L["All user set values will be lost. Do you want to proceed?"]
end

local fieldText = {}
do
	local localization = E.Localizations
	localization = localization:gsub("enUS", ENUS):gsub("deDE", DEDE)
	localization = localization:gsub("esES", ESES):gsub("esMX", ESMX)
	localization = localization:gsub("frFR", FRFR):gsub("koKR", KOKR)
	localization = localization:gsub("ruRU", RURU):gsub("zhCN", ZHCN)
	localization = localization:gsub("zhTW", ZHTW)
	localization = localization:gsub("itIT", LFG_LIST_LANGUAGE_ITIT)

	fieldText.localizations = localization

	local t = {}
	for i = 1, #E.unitFrameData do
		local uf = E.unitFrameData[i][1]
		if not strfind(uf, "-") then
			t[#t + 1] = uf
		end
	end
	fieldText.supportedUis = table.concat(t, ", ")
	fieldText.translations = format("%s (%s), %s (%s), %s (%s), %s (%s)", RURU, "Void_OW-\"The OG\"", ZHTW, "RainbowUI", DEDE, "drumz84", LFG_LIST_LANGUAGE_ITIT, "Grifo92")
end

local getFieldText = function(info)
	local label = info[#info]
	return E[label] or fieldText[label] or ""
end

local getGlobalOption = function(info) return E.global[ info[#info] ] end
local setGlobalOption = function(info, value) E.global[ info[#info] ] = value end


local function GetOptions()
	if not E.options then
		E.options = {
			name = E.AddOn,
			type = "group",
			args = {
				Home = {

					name = format("|T%s:18|t %s", E.Libs.OmniCDC.texture.logo, E.AddOn),
					order = 0,
					type = "group",
					childGroups = "tab",
					get = function(info) return E.profile[ info[#info] ] end,
					set = function(info, value) E.profile[ info[#info] ] = value end,
					args = {
						title = {
							image = E.Libs.OmniCDC.texture.logo,
							imageWidth = 64, imageHeight = 64, imageCoords = { 0, 1, 0, 1 },
							name = E.AddOn,
							order = 0,
							type = "description",
							fontSize = "large",
						},
						pd1 = {
							name = "\n\n\n", order = 1, type = "description",
						},
						Version = {
							name = L["Version"],
							order = 2,
							type = "input",
							dialogControl = "Info-OmniCDC",
							get = getFieldText,
						},
						Author = {
							name = L["Author"],
							order = 3,
							type = "input",
							dialogControl = "Info-OmniCDC",
							get = getFieldText,
						},
						supportedUis = {
							name = L["Supported UI"],
							order = 4,
							type = "input",
							dialogControl = "Info-OmniCDC",
							get = getFieldText,
						},
						localizations = {
							name = LANGUAGES_LABEL,
							order = 5,
							type = "input",
							dialogControl = "Info-OmniCDC",
							get = getFieldText,
						},
						translations = {
							name = BUG_CATEGORY15,
							order = 6,
							type = "input",
							dialogControl = "Info-OmniCDC",
							get = getFieldText,
						},
						pd2 = {
							name = "\n\n", order = 10, type = "description",
						},
						loginMessage = {
							name = L["Login Message"],
							order = 11,
							type = "toggle",
							get = getGlobalOption,
							set = setGlobalOption,
						},
						notifyNew = {
							disabled = not E.useVersionCheck,
							name = L["Notify Updates"],
							desc = L["Send a chat message when a newer version is found."],
							order = 12,
							type = "toggle",
							get = getGlobalOption,
							set = setGlobalOption,
						},

						minusScale = {
							disabled = function() return E.global.optionPanelScale < 0.84 end,
							image = E.Libs.OmniCDC.texture.minus, imageWidth = 18, imageHeight = 18,
							name = "",
							order = 13,
							type = "execute",
							func = function()
								local currScale = E.global.optionPanelScale
								if currScale > 0.84 then
									currScale = currScale - 0.05
									E.global.optionPanelScale = currScale
									E.Libs.ACD:SetDefaultSize(E.AddOn, nil,nil, currScale)
								end
							end,
							width = 0.15,
						},
						currScale = {
							name = function() return format("%s%%", E.global.optionPanelScale * 100) end,
							order = 14,
							type = "description",
							width = 0.3,
							justifyH = "CENTER",
						},
						plusScale = {
							disabled = function() return E.global.optionPanelScale == 1.5 end,
							image = E.Libs.OmniCDC.texture.plus, imageWidth = 18, imageHeight = 18,
							name = "",
							order = 15,
							type = "execute",
							func = function()
								local currScale = E.global.optionPanelScale
								if currScale < 1.46 then
									currScale = currScale + 0.05
									E.global.optionPanelScale = currScale
									E.Libs.ACD:SetDefaultSize(E.AddOn, nil,nil, currScale)
								end
							end,
							width = 0.15,
						},
						pd3 = {
							name = "\n", order = 16, type = "description",
						},
						notice = {
							image = E.Libs.OmniCDC.texture.recent, imageWidth = 32, imageHeight = 16, imageCoords = { 0.13, 1.13, 0.25, 0.75 },
							name = " ",
							order = 17,
							type = "description",
						},
						notice1 = {
							name = format("|cffff2020* %s",
							((E.isWOTLKC or E.isCata) and L["Group member must have OmniCD to detect cooldown reduction by Glyphs."])
							or (E.isSL and L["Group member must have OmniCD to detect cooldown reduction with a chance to proc and Soulbind Conduits."])
							or (E.postDF and L["Group member must have OmniCD to detect cooldown reduction with a chance to proc."])

							or ""),
							order = 18,
							type = "description",
						},
						pd4 = {
							name = "\n\n\n", order = 19, type = "description",
						},
						changelog = {
							name = L["Changelog"],
							order = 20,
							type = "group",
							args = {
								lb1 = {
									name = "\n", order = 0, type = "description",
								},
								changelog = {
									name = E.changelog,
									order = 1,
									type = "description",
								},
							}
						},
						slashCommands = {
							name = L["Slash Commands"],
							order = 30,
							type = "group",
							args = {
								lb1 = { name = L["Usage:"], order = 1, type = "description" },
								lb2 = { name = "/oc <command> <value:optional>", order = 2, type = "description"},
								lb3 = { name = "\n\n", order = 3, type = "description"},
								lb4 = { name = L["Commands:"], order = 4, type = "description"},
								test = {
									name = "/oc t:",
									order = 5,
									type = "input",
									dialogControl = "Info-OmniCDC",
									get = function() return L["Toggle test frames for current zone."] end,
								},
								reload = {
									name = "/oc rl:",
									order = 6,
									type = "input",
									dialogControl = "Info-OmniCDC",
									get = function() return L["Reload addon."] end,
								},
								resetTimers = {
									name = "/oc rt:",
									order = 7,
									type = "input",
									dialogControl = "Info-OmniCDC",
									get = function() return L["Reset all cooldown timers."] end,
								},
								resetDB = {
									name = "/oc rt db:",
									order = 8,
									type = "input",
									dialogControl = "Info-OmniCDC",
									get = function()
										return L["Clean wipe the savedvariable file. |cffff2020Warning|r: This can not be undone!"]
									end,
								},

							}
						},
						feedback = {
							name = L["Feedback"],
							order = 40,
							type = "group",
							args = {
								issues = {
									name = SUGGESTFRAME_TITLE,
									desc = L["Press Ctrl+C to copy URL"],
									order = 1,
									type = "input",
									dialogControl = "Link-OmniCDC",
									get = function() return "https://www.curseforge.com/wow/addons/omnicd/issues" end,
								},
								translate = {
									name = L["Help Translate"],
									desc = L["Press Ctrl+C to copy URL"],
									order = 2,
									type = "input",
									dialogControl = "Link-OmniCDC",
									get = function() return "https://www.curseforge.com/wow/addons/omnicd/localization" end,
								},
							}
						},
						plugins = E.postDF and {
							name = L["Plugins"],
							order = 50,
							type = "group",
							args = {
								battleres = {
									name = L["Battle Res"],
									desc = L["Press Ctrl+C to copy URL"],
									order = 1,
									type = "input",
									dialogControl = "Link-OmniCDC",
									get = function() return "https://www.curseforge.com/wow/addons/omnicd-battleres" end,
								},
								--[[
								enemyCD = {
									name = L["Enemy CD"],
									desc = L["Press Ctrl+C to copy URL"],
									order = 2,
									type = "input",
									dialogControl = "Link-OmniCDC",
									get = function() return "" end,
								},
								]]
							}
						} or nil,
						otherAddOns = E.postDF and {
							name = ADDONS,
							order = 60,
							type = "group",
							args = {
								omniauras = {
									name = "OmniAuras",
									desc = "Track important buffs and debuffs on any Blizzard frame",
									order = 1,
									type = "input",
									dialogControl = "Link-OmniCDC",
									get = function() return "https://www.curseforge.com/wow/addons/omniauras" end,
								},
							}
						} or nil,
					}
				},
			},
			plugins = {
				profiles = {
					profiles = E.optionsFrames.profiles
				},
			},
		}

		for moduleName, optionTbl in pairs(E.moduleOptions) do
			E.options.args[moduleName] = (type(optionTbl) == "function") and optionTbl() or optionTbl

			E.options.args[moduleName].args["title"] = E.options.args[moduleName].args["title"] or {
				name = "|cffffd200" .. E.options.args[moduleName].name,
				order = 0,
				type = "description",
				fontSize = "large",
			}

			E.options.args[moduleName].args.lb0 = {
				name = "\n",
				order = 1,
				type = "description",
			}

			E.options.args[moduleName].args["enable"] = E.options.args[moduleName].args["enable"] or {
				disabled = false,
				name = ENABLE,
				desc = L["Toggle module on and off"],
				order = 2,
				type = "toggle",
				get = function() return E:GetModuleEnabled(moduleName) end,
				set = function()
					local state = E:GetModuleEnabled(moduleName)
					E:SetModuleEnabled(moduleName, not state)
				end,
			}
		end

		E:AddGeneral()
		E:AddSpellEditor()
		E:AddProfileSharing()
	end

	E:AddSpellPickers()
	return E.options
end

function E:SetupOptions()
	self.Libs.OmniCDC.texture = self.Libs.OmniCDC.texture or {
		logo	= [[Interface\AddOns\OmniCD\Libs\LibOmniCDC\Media\omnicd-logo64]],
		recent	= [[Interface\AddOns\OmniCD\Libs\LibOmniCDC\Media\omnicd-recent]],
		resizer	= [[Interface\AddOns\OmniCD\Libs\LibOmniCDC\Media\omnicd-bullet-resizer]],
		plus	= [[Interface\AddOns\OmniCD\Libs\LibOmniCDC\Media\omnicd-bg-gnav2-plus]],
		minus	= [[Interface\AddOns\OmniCD\Libs\LibOmniCDC\Media\omnicd-bg-gnav2-minus]],
		arrow	= [[Interface\AddOns\OmniCD\Libs\LibOmniCDC\Media\omnicd-bg-gnav2-dn]],
		arrowb	= [[Interface\AddOns\OmniCD\Libs\LibOmniCDC\Media\omnicd-bg-gnav2-dn-b]],
	}
	self.Libs.OmniCDC.SetOptionFontDefaults(nil, nil)
	self.Libs.ACR:RegisterOptionsTable(self.AddOn, GetOptions, true)


	self.optionsFrames.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.DB)
	self.optionsFrames.profiles.order = 1000

	if self.postMoP then
		local LDS = LibStub("LibDualSpec-1.0")
		LDS:EnhanceDatabase(self.DB, "OmniCDDB")
		LDS:EnhanceOptions(self.optionsFrames.profiles, self.DB)
	end

	self.SetupOptions = nil
end

function E:RegisterModuleOptions(name, optionTbl, displayName, uproot)
	self.moduleOptions[name] = optionTbl
	self.optionsFrames[name] = uproot and self.Libs.ACD:AddToBlizOptions(self.AddOn, displayName, self.AddOn, name)
end

function E:ACR_NotifyChange()
	if self.Libs.ACD.OpenFrames.OmniCD then
		self.Libs.ACR:NotifyChange(self.AddOn)
	end
end

function E:RefreshProfile(currentProfile)
	currentProfile = currentProfile or self.DB:GetCurrentProfile()

	self.DB.keys.profile = ""
	self.DB:SetProfile(currentProfile)
end
