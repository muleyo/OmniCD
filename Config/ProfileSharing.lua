local E, L, C = select(2, ...):unpack()
local PS = E.ProfileSharing

local selectedProfileType, selectedProfileSrc, selectedProfileDest
local selectedProfileZone, selectedProfileOption
local tbl = {}

PS.profileTypeValues = {
	["all"] = format("%s + %s", GENERAL, FRIENDLY),
	["cds"] = L["Spell Editor"],
}

local ProfileValues = function() return E.DB:GetProfiles(tbl) end

local ProfileSharing = {
	name = L["Profile Sharing"],
	order = 1100,
	type = "group",
	args = {
		desc = {
			name = "",
			order = 1,
			type = "description",
		},
		export = {
			name = L["Export Profile"],
			order = 100,
			type = "group",
			inline = true,
			args = {
				lb1 = {
					name = L["Exports your currently active profile."], order = 0, type = "description",
				},
				profileType = {
					name = L["Profile Type"],
					order = 1,
					type = "select",
					values = PS.profileTypeValues,
					get = function() return selectedProfileType end,
					set = function(_, value) selectedProfileType = value end,
				},
				openExportDialog = {
					disabled = function() return not selectedProfileType end,
					name = L["Export"],
					order = 2,
					type = "execute",
					func = function()
						local profileKey, encodedData = PS:ExportProfile(selectedProfileType)
						PS:ShowProfileDialog(encodedData or PS.errorMsg)
					end,
				},
			}
		},
		import = {
			name = L["Import Profile"],
			order = 200,
			type = "group",
			inline = true,
			args = {
				lb1 = {
					name = format(L["Importing \'%s\' will create a new profile."], PS.profileTypeValues.all),
					order = 0, type = "description",
				},
				lb2 = {
					name = format(L["Importing \'%s\' will merge new spells to your list and overwrite same spells."], PS.profileTypeValues.cds),
					order = 1, type = "description",
				},
				openImportDialog = {
					name = L["Import"],
					order = 3,
					type = "execute",
					func = function() PS:ShowProfileDialog(nil) end,
				},
			}
		},
		lb1 = {
			name = "\n\n", order = 201, type = "description",
		},
		copy = {
			name = L["Copy Zone Segments"],
			order = 300,
			type = "group",
			inline = true,
			args = {
				lb1 = {
					name = L["Tool to copy portions of a profile to another existing profile."],
					order = 0, type = "description",
				},
				src = {
					name = L["Source Profile"],
					order = 1,
					type = "select",
					values = ProfileValues,
					get = function() return selectedProfileSrc end,
					set = function(_, value) selectedProfileSrc = value end,
				},
				zone = {
					name = ZONE,
					order = 2,
					type = "select",
					values = E.L_CFG_ZONE,
					sorting = { "arena", "pvp", "party", "raid" },
					get = function() return selectedProfileZone end,
					set = function(_, value) selectedProfileZone = value end,
				},
				option = {
					name = OPTIONS,
					desc = L["Value \'Manual Position\' includes Interrupt and Raid Bar's saved positions."],
					order = 3,
					type = "select",
					values = {
						["all"] = ALL,
						["general"] = GENERAL,
						["position"] = L["Position"],
						["manualPos"] = L["Manual Position"],
						["icons"] = L["Icons"],
						["highlight"] = L["Highlighting"],
						["priority"] = L["Priority"],
						["frame"] = L["Frame"],
						["spells"] = L["Spells"],
						["spellFrame"] = format("%s-%s",L["Spells"], L["Bar"]),
						["spellPriority"] = format("%s-%s",L["Spells"], L["Priority"]),
						["spellGlow"] = format("%s-%s",L["Spells"], L["Glow"]),
						["extraBars"] = L["Raid Bar"],
					},
					sorting = {"all", "general", "position", "manualPos", "icons", "highlight", "priority", "frame", "spells", "spellFrame", "spellPriority", "spellGlow", "extraBars"},
					get = function() return selectedProfileOption end,
					set = function(_, value) selectedProfileOption = value end,
				},
				dest = {
					name = L["Destination Profile"],
					order = 4,
					type = "select",
					values = ProfileValues,
					get = function() return selectedProfileDest end,
					set = function(_, value) selectedProfileDest = value end,
					disabledItem = function() return selectedProfileSrc end,
				},
				copy = {
					disabled = function()
						return not selectedProfileSrc or not selectedProfileZone or not selectedProfileOption or not selectedProfileDest
					end,
					name = L["Copy"],
					order = 5,
					type = "execute",
					func = function()
						local src = selectedProfileSrc and tbl[selectedProfileSrc]
						local dest = selectedProfileDest and tbl[selectedProfileDest]
						local current = E.DB:GetCurrentProfile()
						if selectedProfileOption == "all" then
							local t = OmniCDDB.profiles[src].Party[selectedProfileZone]
							if t then
								OmniCDDB.profiles[dest].Party[selectedProfileZone] = E:DeepCopy(t)
							end
						else
							local t = OmniCDDB.profiles[src].Party[selectedProfileZone] and OmniCDDB.profiles[src].Party[selectedProfileZone][selectedProfileOption]
							if t then
								OmniCDDB.profiles[dest].Party = OmniCDDB.profiles[dest].Party or {}
								OmniCDDB.profiles[dest].Party[selectedProfileZone] = OmniCDDB.profiles[dest].Party[selectedProfileZone] or {}
								OmniCDDB.profiles[dest].Party[selectedProfileZone][selectedProfileOption] = E:DeepCopy(t)
							end
						end
						if dest == current then
							E:RefreshProfile(current)
						end
					end,
				},
			}
		}
	}
}

function E:AddProfileSharing()
	self.options.args["ProfileSharing"] = ProfileSharing
end
