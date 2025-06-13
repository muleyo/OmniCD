local E = select(2,	...):unpack()

E.spell_cdmod_talents = {

	[3044]	= {
		19454,	0.2,
		19455,	0.4,
		19456,	0.6,
		19457,	0.8,
		19458,	1.0,
	},

	[2136]	= {
		11078,	0.5,
		11080,	1.0,
		12342,	1.5,
	},
	[122]	= {
		11165,	2,
		12475,	4,
	},
	[7814]	= {
		18128,	3,
		18129,	6,
	},

	[1022]	= {
		20174,	60,
		20175,	120,
	},
	[853]	= {
		20487,	5,
		20488,	10,
		20489,	15,
	},
	[20271]	= {
		25956,	1,
		25957,	2,
	},
	[633]	= {
		20234,	600,
		20235,	1200,
	},

	[586]	= {
		15274,	3,
		15311,	6,
	},
	[8092]	= {
		15273,	0.5,
		15312,	1.0,
		15313,	1.5,
		15314,	2.0,
		15316,	2.5,
	},
	[8122]	= {
		15392,	2,
		15448,	4,
	},

	[2094]	= {
		13981,	45,
		14066,	90,
	},
	[1856]	= {
		13981,	45,
		14066,	90,
	},
	[5277]	= {
		13742,	45,
		13872,	90,
	},
	[2983]	= {
		13742,	45,
		13872,	90,
	},
	[1784]	= {
		13975,	1,
		14062,	2,
		14063,	3,
		14064,	4,
		14065,	5,
	},

	[8042]	= {
		16040,	0.2,
		16113,	0.4,
		16114,	0.6,
		16115,	0.8,
		16116,	1.0,
	},
	[8050]	= {
		16040,	0.2,
		16113,	0.4,
		16114,	0.6,
		16115,	0.8,
		16116,	1.0,
	},
	[8056]	= {
		16040,	0.2,
		16113,	0.4,
		16114,	0.6,
		16115,	0.8,
		16116,	1.0,
	},
	[8177]	= {
		16258,	1,
		16293,	2,
	},
	[20608]	= {
		16184,	600,
		16209,	1200,
	},

	[1161]	= {
		12327,	120,
		12886,	180,
	},
	[1719]	= {
		29723,	240,
		29724,	420,
		29725,	600,
	},
	[355]	= {
		12302,	1,
		12765,	2,
	},
	[20252]	= {
		20504,	5,
		20505,	10,
	},
}

E.spell_cdmod_talents_mult = {}

E.spell_chmod_talents = E.BLANK

E.spell_cdmod_by_haste = {
	[19434]	= 3,
}





E.spell_cdmod_by_aura_mult = E.BLANK

E.spell_noreset_onencounterend = {
	[20608]	= true,
}


E.talentNameToRankIDs = {}

local temp = {}
for _, v in E.pairs(E.spell_cdmod_talents, E.spell_cdmod_talents_mult) do
	for k = 1, #v, 2 do
		local id = v[k]
		local name = C_Spell.GetSpellName(id)
		if name and not temp[id] then
			E.talentNameToRankIDs[name] = E.talentNameToRankIDs[name] or {}
			tinsert(E.talentNameToRankIDs[name], id)
			temp[id] = true
		end
	end
end

local itemBonus = {

	[20484]	= { 26106,	600	},

	[5116]	= {
		23158,	1,
		24465,	1,
	},
	[5384]	= { 24432,	2	},


	[1953]	= { 23025,	2	},
	[12051]	= { 28763,	60	},

	[853]	= { 23302,	10	},
	[633]	= { 28774,	720	},

	[586]	= { 18388,	2	},

	[2094]	= { 24469,	5	},
	[5277]	= { 26112,	60	},
	[1776]	= { 23048,	1	},
	[1766]	= { 24434,	0.5	},
	[1856]	= {
		21874,	30,
		14064,	60,
	},

	[20608]	= { 27797,	600	},

	[20252]	= { 22738,	5	},
	[5246]	= { 24456,	15	},
}
local itemBonusMult = {

	[16914]	= { 23556,	.50	},
	[740]	= { 23556,	.50	},

	[6789]	= { 24487,	.85	},
}
local function MergeTable(src,	dest)
	for id, t in pairs(src) do
		dest[id] = dest[id] or {}
		for i = 1, #t do
			local v = t[i]
			tinsert(dest[id], v)
		end
	end
end
MergeTable(itemBonus, E.spell_cdmod_talents)
MergeTable(itemBonusMult, E.spell_cdmod_talents_mult)
itemBonus = nil
itemBonusMult = nil





E.spellcast_linked = {
	[1499]	= { 1499,	13813,	13795,	13809	},
	[13813]	= { 1499,	13813,	13795,	13809	},
	[13795]	= { 1499,	13813,	13795,	13809	},
	[13809]	= { 1499,	13813,	13795,	13809	},
	[543]	= { 543,	6143	},
	[6143]	= { 543,	6143	},
	[498]	= { 498,	642	},
	[642]	= { 498,	642	},
	[8042]	= { 8042,	8050,	8056	},
	[8050]	= { 8042,	8050,	8056	},
	[8056]	= { 8042,	8050,	8056	},
	[871]	= { 871,	1719,	20230	},
	[1719]	= { 871,	1719,	20230	},
	[20230]	= { 871,	1719,	20230	},
}

E.spellcast_merged = {

	[20554]	= 26297,
	[26296]	= 26297,
}


local spellRanks = {

	{ 5211,	6798,	8983	},
	{ 8998,	9000,	9892	},
	{ 1850,	9821	},
	{ 16914,	17401,	17402	},
	{ 22842,	22895,	22896,	26999	},
	{ 5215,	6783,	9913	},
	{ 20484,	20739,	20742,	20747,	20748	},
	{ 740,	8918,	9862,	9863	},

	{ 3044,	14281,	14282,	14283,	14284,	14285,	14286,	14287	},
	{ 781,	14272,	14273	},
	{ 20736,	14274,	15629,	15630,	15631,	15632,	27020	},
	{ 13813,	14316,	14317	},
	{ 1499,	14310,	14311	},
	{ 13795,	14302,	14303,	14304,	14305	},
	{ 1495,	14269,	14270,	14271	},
	{ 2643,	14288,	14289,	14290,	25294	},
	{ 2973,	14260,	14261,	14262,	14263,	14264,	14265,	14266	},
	{ 1513,	14326,	14327	},
	{ 1510,	14294,	14295	},

	{ 1742,	1753,	1754,	1755,	1756,	16697	},
	{ 2649,	14916,	14917,	14918,	14919,	14920,	14921	},
	{ 7371,	26177,	26178,	26179,	26201,	27685	},
	{ 17253,	17255,	17256,	17257,	17258,	17259,	17260,	17261	},
	{ 23099,	23109,	23110	},
	{ 23145,	23147,	23148	},
	{ 24450,	24452,	24453	},
	{ 24640,	24583,	24586,	24587	},
	{ 24604,	24605,	24603,	24597	},
	{ 26090,	26187,	26188	},
	{ 34889,	35323	},

	{ 120,	8492,	10159,	10160,	10161	},
	{ 543,	8457,	8458,	10223,	10225	},
	{ 2136,	2137,	2138,	8412,	8413,	10197,	10199	},
	{ 122,	865,	6131,	10230	},
	{ 6143,	8461,	8462,	10177,	28609	},

	{ 1022,	5599,	10278	},
	{ 642,	1020	},
	{ 498,	5573	},
	{ 879,	5614,	5615,	10312,	10313,	10314	},
	{ 853,	5588,	5589,	10308	},
	{ 24275,	24274,	24239	},
	{ 2812,	10318	},
	{ 633,	2799,	10310	},
	{ 2878,	5627,	10326	},

	{ 13908,	19236,	19238,	19240,	19241,	19242,	19243	},
	{ 2944,	19276,	19277,	19278,	19279,	19280	},
	{ 586,	9578,	9579,	9592,	10941,	10942	},
	{ 13896,	19271,	19273,	19274,	19275	},
	{ 8092,	8102,	8103,	8104,	8105,	8106,	10945,	10946,	10947	},
	{ 17,	592,	600,	3747,	6065,	6066,	10898,	10899,	10900,	10901	},
	{ 8122,	8124,	10888,	10890	},
	{ 2651,	19289,	19291,	19292,	19293	},

	{ 1966,	6768,	8637,	11303,	25302	},
	{ 1776,	1777,	8629,	11285,	11286	},
	{ 1766,	1767,	1768,	1769	},
	{ 408,	8643	},
	{ 2983,	8696,	11305	},
	{ 1784,	1785,	1786,	1787	},
	{ 1856,	1857	},

	{ 421,	930,	2860,	10605	},
	{ 8042,	8044,	8045,	8046,	10412,	10413,	10414	},
	{ 1535,	8498,	8499,	11314,	11315	},
	{ 8050,	8052,	8053,	10447,	10448,	29228	},
	{ 8056,	8058,	10472,	10473	},
	{ 5730,	6390,	6391,	6392,	10427,	10428	},

	{ 603,	30910	},
	{ 6789,	17925,	17926	},
	{ 5484,	17928	},
	{ 6229,	11739,	11740,	28610	},
	{ 6353,	17924	},
	{ 20707,	20762,	20763,	20764,	20765	},

	{ 19244,	19647	},
	{ 19505,	19731,	19734,	19736	},
	{ 17735,	17750,	17751,	17752	},
	{ 7814,	7815,	7816,	11778,	11779,	11780	},
	{ 6360,	7813,	11784,	11785	},
	{ 3716,	7809,	7810,	7811,	11774,	11775	},

	{ 100,	6178,	11578	},
	{ 20252,	20616,	20617	},
	{ 694,	7400,	7402,	20559,	20560	},
	{ 7384,	7887,	11584,	11585	},
	{ 6552,	6554	},
	{ 6572,	6574,	7379,	11600,	11601,	25288	},
	{ 72,	1671,	1672	},
	{ 6343,	8198,	8204,	8205,	11580,	11581	},
}

local talentRanks = {

	{ 16979	},
	{ 17116	},
	{ 18562	},
	{ 16857,	17390,	17391,	17392	},
	{ 16689,	16810,	16811,	16812,	16813,	17329	},

	{ 19574	},
	{ 19263	},
	{ 19577	},
	{ 23989	},
	{ 19503	},

	{ 19434,	20900,	20901,	20902,	20903,	20904	},
	{ 19306,	20909,	20910	},
	{ 19386,	24132,	24133	},

	{ 12042	},
	{ 12472	},
	{ 11129	},
	{ 12043	},
	{ 11113,	13018,	13019,	13020,	13021	},
	{ 11426,	13031,	13032,	13033	},
	{ 11958	},

	{ 20216	},
	{ 20066	},
	{ 20925,	20927,	20928	},
	{ 20473,	20929,	20930	},
	{ 26573,	20116,	20922,	20923,	20924	},

	{ 14751	},
	{ 10060	},
	{ 15473	},
	{ 15487	},
	{ 15286	},
	{ 724,	27870,	27871	},

	{ 13750	},
	{ 13877	},
	{ 14177	},
	{ 14278	},
	{ 14183	},
	{ 14185	},
	{ 14251	},

	{ 16166	},
	{ 16190,	17354,	17359	},
	{ 16188	},
	{ 17364	},

	{ 18288	},
	{ 18708	},
	{ 17962,	18930,	18931,	18932	},
	{ 17877,	18867,	18868,	18869,	18870,	18871	},

	{ 12809	},
	{ 12292	},
	{ 12975	},
	{ 12328	},
	{ 23881,	23892,	23893,	23894	},
	{ 12294,	21551,	21552,	21553	},
	{ 23922,	23923,	23924,	23925	},
}


for i = 1, #spellRanks do
	local t = spellRanks[i]
	local rank1 = t[1]
	rank1 = E.spellcast_merged[rank1] or rank1
	for j = 2, #t do
		local rankN = t[j]
		E.spellcast_merged[rankN] = rank1
	end
end


for i = 1, #talentRanks do
	local t = talentRanks[i]
	local rank1 = t[1]
	rank1 = E.spellcast_merged[rank1] or rank1
	local name = C_Spell.GetSpellName(rank1)
	if name then
		for j = 2, #t do
			local rankN = t[j]
			E.spellcast_merged[rankN] = rank1
			--[==[@debug@
			if not C_Spell.DoesSpellExist(rankN) then
				E.write("Invalid rank" .. j .. "talent ID:", rankN)
			end
			--@end-debug@]==]
		end


		local dupe = E.talentNameToRankIDs[name]
		if dupe then
			if type(dupe[1]) == "table" then
				tinsert(E.talentNameToRankIDs[name], t)
			else
				E.talentNameToRankIDs[name] = { dupe, t }
			end
		else
			E.talentNameToRankIDs[name] = t
		end
	--[==[@debug@
	else
		E.write("Invalid rank1 talent ID:", rank1)
	--@end-debug@]==]
	end
end

E.spellcast_merged_updateoncast = E.BLANK

for k, v in pairs(E.spellcast_merged_updateoncast) do
	if not v[2] then
		local _, icon = C_Spell.GetSpellTexture(k)
		v[2] = icon
	end
end

E.spellcast_shared_cdstart = E.BLANK

E.spellcast_cdreset = {
	[23989]	= {
		nil,

		19263,
		5384,
		1499,	13813,	13795,	13809,
	},
	[12472]	= {
		nil,
		11958,
		11426,
		120,
		122,
		6143,
	},
	[14185]	= {
		nil,
		"*",
	},
}

E.spellcast_cdr = E.BLANK





E.spell_auraremoved_cdstart_preactive = {
	[17116]	= 17116,
	[5215]	= 5215,


	[12043]	= 12043,
	[14177]	= 14177,
	[1784]	= 1784,



	[20216]	= 20216,
	[16188]	= 16188,
	[28682]	= 11129,
	[11129]	= 11129,
	[14751]	= 14751,
	[16166]	= 16166,
	[18288]	= 18288,
	[20580]	= 20580,
	[5384]	= 0,
}

E.spell_auraapplied_processspell = E.BLANK
E.spell_dispel_cdstart = E.BLANK

E.selfLimitedMinMaxReducer = E.BLANK
E.runeforge_bonus_to_descid = E.BLANK
E.runeforge_specid = E.BLANK
E.runeforge_desc_to_powerid = E.BLANK
E.runeforge_unity = E.BLANK
E.covenant_to_spellid = E.BLANK
E.covenant_abilities = E.BLANK
E.spell_benevolent_faerie_majorcd = E.BLANK
E.covenant_cdmod_conduits = E.BLANK
E.covenant_chmod_conduits = E.BLANK
E.covenant_cdmod_items_mult = E.BLANK
E.soulbind_conduits_rank = E.BLANK
E.soulbind_abilities = E.BLANK
E.spell_cdmod_conduits = E.BLANK
E.spell_cdmod_conduits_mult = E.BLANK
E.spell_symbol_of_hope_majorcd = E.BLANK
E.spell_major_cd = E.BLANK





E.item_merged = {

	[18845] = 18834,
	[18846] = 18834,
	[18854] = 18834,
	[29593] = 18834,
	[18856] = 18834,
	[18859] = 18850,
	[18862] = 18851,
	[18849] = 18852,
	[18857] = 18852,
	[18858] = 18852,
	[18863] = 18853,
}

E.item_equip_bonus = {
	[19617]	= 24434,
	[14154]	= 18388,
	[22345]	= 20608,
	[19621]	= 24432,
}

E.item_set_bonus = {

	[16828]	= { 23556,	8	},
	[16829]	= { 23556,	8	},
	[16830]	= { 23556,	8	},
	[16833]	= { 23556,	8	},
	[16831]	= { 23556,	8	},
	[16834]	= { 23556,	8	},
	[16835]	= { 23556,	8	},
	[16836]	= { 23556,	8	},
	[21355]	= { 26106,	5	},
	[21353]	= { 26106,	5	},
	[21354]	= { 26106,	5	},
	[21356]	= { 26106,	5	},
	[21357]	= { 26106,	5	},






	[19621]	= { 24465,	3	},
	[19953]	= { 24465,	3	},
	[19833]	= { 24465,	3	},
	[19832]	= { 24465,	3	},
	[19831]	= { 24465,	3	},
	[16466]	= { 23158,	3	},
	[16465]	= { 23158,	3	},
	[16468]	= { 23158,	3	},
	[16462]	= { 23158,	3	},
	[16463]	= { 23158,	3	},
	[16467]	= { 23158,	3	},
	[16569]	= { 23158,	3	},
	[16571]	= { 23158,	3	},
	[16567]	= { 23158,	3	},
	[16565]	= { 23158,	3	},
	[16566]	= { 23158,	3	},
	[16568]	= { 23158,	3	},
	[22843]	= { 23158,	4	},
	[22862]	= { 23158,	4	},
	[23251]	= { 23158,	4	},
	[23252]	= { 23158,	4	},
	[22874]	= { 23158,	4	},
	[22875]	= { 23158,	4	},
	[23292]	= { 23158,	4	},
	[23293]	= { 23158,	4	},
	[23278]	= { 23158,	4	},
	[23279]	= { 23158,	4	},
	[23306]	= { 23158,	4	},
	[23307]	= { 23158,	4	},
	[16531]	= { 23158,	4	},
	[16530]	= { 23158,	4	},
	[16525]	= { 23158,	4	},
	[16527]	= { 23158,	4	},
	[16526]	= { 23158,	4	},
	[16528]	= { 23158,	4	},
	[16425]	= { 23158,	4	},
	[16426]	= { 23158,	4	},
	[16401]	= { 23158,	4	},
	[16403]	= { 23158,	4	},
	[16428]	= { 23158,	4	},
	[16427]	= { 23158,	4	},

	[16441]	= { 23025,	3	},
	[16444]	= { 23025,	3	},
	[16443]	= { 23025,	3	},
	[16437]	= { 23025,	3	},
	[16440]	= { 23025,	3	},
	[16442]	= { 23025,	3	},
	[16536]	= { 23025,	3	},
	[16533]	= { 23025,	3	},
	[16535]	= { 23025,	3	},
	[16539]	= { 23025,	3	},
	[16540]	= { 23025,	3	},
	[16534]	= { 23025,	3	},
	[22870]	= { 23025,	4	},
	[22860]	= { 23025,	4	},
	[23263]	= { 23025,	4	},
	[23264]	= { 23025,	4	},
	[22883]	= { 23025,	4	},
	[22886]	= { 23025,	4	},
	[23304]	= { 23025,	4	},
	[23305]	= { 23025,	4	},
	[23290]	= { 23025,	4	},
	[23291]	= { 23025,	4	},
	[23318]	= { 23025,	4	},
	[23319]	= { 23025,	4	},
	[16485]	= { 23025,	4	},
	[16487]	= { 23025,	4	},
	[16491]	= { 23025,	4	},
	[16490]	= { 23025,	4	},
	[16489]	= { 23025,	4	},
	[16492]	= { 23025,	4	},
	[16369]	= { 23025,	4	},
	[16391]	= { 23025,	4	},
	[16413]	= { 23025,	4	},
	[16414]	= { 23025,	4	},
	[16416]	= { 23025,	4	},
	[16415]	= { 23025,	4	},
	[22502]	= { 28763,	2	},
	[22503]	= { 28763,	2	},
	[22498]	= { 28763,	2	},
	[22501]	= { 28763,	2	},
	[22497]	= { 28763,	2	},
	[22496]	= { 28763,	2	},
	[22500]	= { 28763,	2	},
	[22499]	= { 28763,	2	},
	[23062]	= { 28763,	2	},

	[22430]	= { 28774,	4	},
	[22431]	= { 28774,	4	},
	[22426]	= { 28774,	4	},
	[22428]	= { 28774,	4	},
	[22427]	= { 28774,	4	},
	[22429]	= { 28774,	4	},
	[22425]	= { 28774,	4	},
	[22424]	= { 28774,	4	},
	[23066]	= { 28774,	4	},
	[16473]	= { 23302,	3	},
	[16474]	= { 23302,	3	},
	[16476]	= { 23302,	3	},
	[16472]	= { 23302,	3	},
	[16471]	= { 23302,	3	},
	[16475]	= { 23302,	3	},
	[29612]	= { 23302,	3	},
	[29613]	= { 23302,	3	},
	[29614]	= { 23302,	3	},
	[29615]	= { 23302,	3	},
	[29616]	= { 23302,	3	},
	[29617]	= { 23302,	3	},
	[29600]	= { 23302,	3	},
	[29601]	= { 23302,	3	},
	[29602]	= { 23302,	3	},
	[29603]	= { 23302,	3	},
	[29604]	= { 23302,	3	},
	[29605]	= { 23302,	3	},
	[23272]	= { 23302,	4	},
	[23273]	= { 23302,	4	},
	[23274]	= { 23302,	4	},
	[23275]	= { 23302,	4	},
	[23276]	= { 23302,	4	},
	[23277]	= { 23302,	4	},
	[16410]	= { 23302,	4	},
	[16409]	= { 23302,	4	},
	[16433]	= { 23302,	4	},
	[16435]	= { 23302,	4	},
	[16434]	= { 23302,	4	},
	[16436]	= { 23302,	4	},

	[16453]	= { 23048,	3	},
	[16457]	= { 23048,	3	},
	[16455]	= { 23048,	3	},
	[16446]	= { 23048,	3	},
	[16454]	= { 23048,	3	},
	[16456]	= { 23048,	3	},
	[16563]	= { 23048,	3	},
	[16561]	= { 23048,	3	},
	[16562]	= { 23048,	3	},
	[16564]	= { 23048,	3	},
	[16560]	= { 23048,	3	},
	[16558]	= { 23048,	3	},
	[22864]	= { 23048,	4	},
	[22856]	= { 23048,	4	},
	[22879]	= { 23048,	4	},
	[22880]	= { 23048,	4	},
	[23257]	= { 23048,	4	},
	[23258]	= { 23048,	4	},
	[23298]	= { 23048,	4	},
	[23299]	= { 23048,	4	},
	[23284]	= { 23048,	4	},
	[23285]	= { 23048,	4	},
	[23312]	= { 23048,	4	},
	[23313]	= { 23048,	4	},
	[16498]	= { 23048,	4	},
	[16499]	= { 23048,	4	},
	[16505]	= { 23048,	4	},
	[16508]	= { 23048,	4	},
	[16506]	= { 23048,	4	},
	[16507]	= { 23048,	4	},
	[16392]	= { 23048,	4	},
	[16396]	= { 23048,	4	},
	[16417]	= { 23048,	4	},
	[16419]	= { 23048,	4	},
	[16420]	= { 23048,	4	},
	[16418]	= { 23048,	4	},
	[16827]	= { 21874,	2	},
	[16824]	= { 21874,	2	},
	[16825]	= { 21874,	2	},
	[16820]	= { 21874,	2	},
	[16821]	= { 21874,	2	},
	[16826]	= { 21874,	2	},
	[16822]	= { 21874,	2	},
	[16823]	= { 21874,	2	},
	[19617]	= { 24469,	3	},
	[19954]	= { 24469,	3	},
	[19836]	= { 24469,	3	},
	[19835]	= { 24469,	3	},
	[19834]	= { 24469,	3	},
	[21359]	= { 26112,	3	},
	[21360]	= { 26112,	3	},
	[21361]	= { 26112,	3	},
	[21362]	= { 26112,	3	},
	[21364]	= { 26112,	3	},


	[19605]	= { 24487,	5	},
	[19957]	= { 24487,	5	},
	[19848]	= { 24487,	5	},
	[19849]	= { 24487,	5	},
	[20033]	= { 24487,	5	},

	[19951]	= { 24456,	3	},
	[19577]	= { 24456,	3	},
	[19824]	= { 24456,	3	},
	[19823]	= { 24456,	3	},
	[19822]	= { 24456,	3	},
	[16477]	= { 22738,	3	},
	[16478]	= { 22738,	3	},
	[16480]	= { 22738,	3	},
	[16483]	= { 22738,	3	},
	[16484]	= { 22738,	3	},
	[16479]	= { 22738,	3	},
	[16541]	= { 22738,	3	},
	[16542]	= { 22738,	3	},
	[16544]	= { 22738,	3	},
	[16545]	= { 22738,	3	},
	[16548]	= { 22738,	3	},
	[16543]	= { 22738,	3	},
	[22868]	= { 22738,	4	},
	[22858]	= { 22738,	4	},
	[22872]	= { 22738,	4	},
	[22873]	= { 22738,	4	},
	[23244]	= { 22738,	4	},
	[23243]	= { 22738,	4	},
	[23300]	= { 22738,	4	},
	[23301]	= { 22738,	4	},
	[23286]	= { 22738,	4	},
	[23287]	= { 22738,	4	},
	[23314]	= { 22738,	4	},
	[23315]	= { 22738,	4	},
	[16509]	= { 22738,	4	},
	[16510]	= { 22738,	4	},
	[16513]	= { 22738,	4	},
	[16515]	= { 22738,	4	},
	[16514]	= { 22738,	4	},
	[16516]	= { 22738,	4	},
	[16405]	= { 22738,	4	},
	[16406]	= { 22738,	4	},
	[16430]	= { 22738,	4	},
	[16431]	= { 22738,	4	},
	[16429]	= { 22738,	4	},
	[16432]	= { 22738,	4	},
}

E.item_unity = E.BLANK





E.sync_cooldowns = E.BLANK
E.sync_in_raid = E.BLANK
E.sync_reset = E.BLANK

E:ProcessSpellDB()
