---------------------------------------------------------------------------------

-- Customized for OmniCD by permission of the copyright owner.

---------------------------------------------------------------------------------

--[[-----------------------------------------------------------------------------
Slider Widget
Graphical Slider, like, for Range values.
-------------------------------------------------------------------------------]]
--[[ s r
local Type, Version = "Slider", 23
]]
local Type, Version = "Slider-OmniCDC", 1
-- e
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end
local OmniCDC = LibStub("LibOmniCDC", true)

-- Lua APIs
local min, max, floor = math.min, math.max, math.floor
local tonumber, pairs = tonumber, pairs

-- WoW APIs
local PlaySound = PlaySound
local CreateFrame, UIParent = CreateFrame, UIParent

--[[-----------------------------------------------------------------------------
Support functions
-------------------------------------------------------------------------------]]
local function UpdateText(self)
	local value = self.value or 0
	if self.ispercent then
		self.editbox:SetText(("%s%%"):format(floor(value * 1000 + 0.5) / 10))
	else
		self.editbox:SetText(floor(value * 100 + 0.5) / 100)
	end
end

local function UpdateLabels(self)
	local min_value, max_value = (self.min or 0), (self.max or 100)
	if self.ispercent then
		self.lowtext:SetFormattedText("%s%%", (min_value * 100))
		self.hightext:SetFormattedText("%s%%", (max_value * 100))
	else
		self.lowtext:SetText(min_value)
		self.hightext:SetText(max_value)
	end
end

--[[-----------------------------------------------------------------------------
Scripts
-------------------------------------------------------------------------------]]
local function Control_OnEnter(frame)
	frame.obj:Fire("OnEnter")
	-- s b
	frame.handleRight:Show()
	frame.Thumb:SetColorTexture(1, 1, 1)
end

local function Control_OnLeave(frame)
	frame.obj:Fire("OnLeave")
	-- s b
	frame.handleRight:Hide()
	frame.Thumb:SetColorTexture(0.8, 0.624, 0)
end

local function Frame_OnMouseDown(frame)
	frame.obj.slider:EnableMouseWheel(true)
	AceGUI:ClearFocus()
end

local function Slider_OnValueChanged(frame, newvalue)
	local self = frame.obj
	if not frame.setup then
		if self.step and self.step > 0 then
			local min_value = self.min or 0
			newvalue = floor((newvalue - min_value) / self.step + 0.5) * self.step + min_value
		end
		if newvalue ~= self.value and not self.disabled then
			self.value = newvalue
			self:Fire("OnValueChanged", newvalue)
		end
		if self.value then
			UpdateText(self)
		end
	end
end

local function Slider_OnMouseUp(frame)
	local self = frame.obj
	self:Fire("OnMouseUp", self.value)
end

local function Slider_OnMouseWheel(frame, v)
	local self = frame.obj
	if not self.disabled then
		local value = self.value
		if v > 0 then
			value = min(value + (self.step or 1), self.max)
		else
			value = max(value - (self.step or 1), self.min)
		end
		self.slider:SetValue(value)
	end
end

local function EditBox_OnEscapePressed(frame)
	frame:ClearFocus()
end

local function EditBox_OnEnterPressed(frame)
	local self = frame.obj
	local value = frame:GetText()
	if self.ispercent then
		value = value:gsub('%%', '')
		value = tonumber(value) / 100
	else
		value = tonumber(value)
	end

	if value then
		PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
		self.slider:SetValue(value)
		self:Fire("OnMouseUp", value)
	end
end

local function EditBox_OnEnter(frame)
	--[[ s r
	frame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
	]]
	frame:SetBackdropBorderColor(0.5, 0.5, 0.5)
end

local function EditBox_OnLeave(frame)
	--[[ s r
	frame:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.8)
	]]
	frame:SetBackdropBorderColor(0.2, 0.2, 0.25)
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
	["OnAcquire"] = function(self)
		self:SetWidth(200)
		self:SetHeight(44)
		self:SetDisabled(false)
		self:SetIsPercent(nil)
		self:SetSliderValues(0,100,1)
		self:SetValue(0)
		self.slider:EnableMouseWheel(false)
	end,

	-- ["OnRelease"] = nil,

	["SetDisabled"] = function(self, disabled)
		self.disabled = disabled
		if disabled then
			self.slider:EnableMouse(false)
			self.label:SetTextColor(.5, .5, .5)
			self.hightext:SetTextColor(.5, .5, .5)
			self.lowtext:SetTextColor(.5, .5, .5)
			--self.valuetext:SetTextColor(.5, .5, .5)
			self.editbox:SetTextColor(.5, .5, .5)
			self.editbox:EnableMouse(false)
			self.editbox:ClearFocus()
			-- s b
			self.slider.Thumb:SetColorTexture(.5, .5, .5)
			self.slider.handleLeft:SetColorTexture(.5, .5, .5)
		else
			self.slider:EnableMouse(true)
			self.label:SetTextColor(1, .82, 0)
			-- e
			self.hightext:SetTextColor(1, 1, 1)
			self.lowtext:SetTextColor(1, 1, 1)
			--self.valuetext:SetTextColor(1, 1, 1)
			self.editbox:SetTextColor(1, 1, 1)
			self.editbox:EnableMouse(true)
			-- s b
			self.slider.Thumb:SetColorTexture(0.8, 0.624, 0)
			self.slider.handleLeft:SetColorTexture(0.8, 0.624, 0)
		end
	end,

	["SetValue"] = function(self, value)
		self.slider.setup = true
		self.slider:SetValue(value)
		self.value = value
		UpdateText(self)
		self.slider.setup = nil
	end,

	["GetValue"] = function(self)
		return self.value
	end,

	["SetLabel"] = function(self, text)
		self.label:SetText(text)
	end,

	["SetSliderValues"] = function(self, min_value, max_value, step)
		local frame = self.slider
		frame.setup = true
		self.min = min_value
		self.max = max_value
		self.step = step
		frame:SetMinMaxValues(min_value or 0,max_value or 100)
		UpdateLabels(self)
		frame:SetValueStep(step or 1)
		if self.value then
			frame:SetValue(self.value)
		end
		frame.setup = nil
	end,

	["SetIsPercent"] = function(self, value)
		self.ispercent = value
		UpdateLabels(self)
		UpdateText(self)
	end
}

--[[-----------------------------------------------------------------------------
Constructor
-------------------------------------------------------------------------------]]
--[[ s -r
local SliderBackdrop  = {
	bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
	edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
	tile = true, tileSize = 8, edgeSize = 8,
	insets = { left = 3, right = 3, top = 6, bottom = 6 }
}

local ManualBackdrop = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
	tile = true, edgeSize = 1, tileSize = 5,
}
]]

local function Constructor()
	local frame = CreateFrame("Frame", nil, UIParent)

	frame:EnableMouse(true)
	frame:SetScript("OnMouseDown", Frame_OnMouseDown)

	--[[ s r
	local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	]]
	local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall-OmniCDC") -- text color set by SetDisabled. v27 set to smaller font
	-- e
	label:SetPoint("TOPLEFT")
	label:SetPoint("TOPRIGHT", -10, 0) -- v26
	label:SetJustifyH("CENTER")
	label:SetHeight(15)

	--[[ s r
	local slider = CreateFrame("Slider", nil, frame, "BackdropTemplate")
	slider:SetOrientation("HORIZONTAL")
	slider:SetHeight(15)
	slider:SetHitRectInsets(0, 0, -10, 0)
	slider:SetBackdrop(SliderBackdrop)
	]]
	local slider = CreateFrame("Slider", nil, frame)
	slider:SetOrientation("HORIZONTAL")
	slider:SetHeight(10)
	slider:SetHitRectInsets(0, 0, -10, 0)
	slider.bg = slider:CreateTexture(nil, "BACKGROUND")
	slider.bg:SetTexelSnappingBias(0.0)
	slider.bg:SetSnapToPixelGrid(false)
	slider.bg:SetColorTexture(0.2, 0.2, 0.25)
	slider.bg:SetHeight(2 * OmniCDC.ACDPixelMult)
	slider.bg:SetPoint("LEFT")
	slider.bg:SetPoint("RIGHT")
	-- e
	--[[ s r
	slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
	slider:SetPoint("TOP", label, "BOTTOM")
	slider:SetPoint("LEFT", 3, 0)
	slider:SetPoint("RIGHT", -3, 0)
	]]
	slider.Thumb = slider:CreateTexture(nil, "Artwork")
	slider.Thumb:SetSize(4 * OmniCDC.ACDPixelMult, 8 * OmniCDC.ACDPixelMult)
	slider.Thumb:SetTexelSnappingBias(0.0)
	slider.Thumb:SetSnapToPixelGrid(false)
	slider.Thumb:SetColorTexture(0.8, 0.624, 0)
	slider:SetThumbTexture(slider.Thumb)
	slider:SetPoint("TOP", label, "BOTTOM")
	slider:SetPoint("LEFT", 1, 0)
	slider:SetPoint("RIGHT", -11, 0) -- v26
	slider.handleLeft = slider:CreateTexture(nil, "Artwork")
	slider.handleLeft:SetTexelSnappingBias(0.0)
	slider.handleLeft:SetSnapToPixelGrid(false)
	slider.handleLeft:SetColorTexture(0.8, 0.624, 0)
	slider.handleLeft:SetPoint("TOPLEFT", slider.bg)
	slider.handleLeft:SetPoint("BOTTOMLEFT", slider.bg)
	slider.handleLeft:SetPoint("RIGHT", slider.Thumb, "LEFT")
	slider.handleRight = slider:CreateTexture(nil, "Artwork")
	slider.handleRight:SetTexelSnappingBias(0.0)
	slider.handleRight:SetSnapToPixelGrid(false)
	slider.handleRight:SetColorTexture(0.5, 0.5, 0.5)
	slider.handleRight:SetPoint("TOPRIGHT", slider.bg)
	slider.handleRight:SetPoint("BOTTOMRIGHT", slider.bg)
	slider.handleRight:SetPoint("LEFT", slider.Thumb, "RIGHT")
	slider.handleRight:Hide()
	-- e
	slider:SetValue(0)
	slider:SetScript("OnValueChanged",Slider_OnValueChanged)
	slider:SetScript("OnEnter", Control_OnEnter)
	slider:SetScript("OnLeave", Control_OnLeave)
	slider:SetScript("OnMouseUp", Slider_OnMouseUp)
	slider:SetScript("OnMouseWheel", Slider_OnMouseWheel)

	--[[ s r
	local lowtext = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	lowtext:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 2, 3)

	local hightext = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	hightext:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", -2, 3)
	]]
	local lowtext = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall-OmniCDC")
	lowtext:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 2, -1)
	local hightext = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall-OmniCDC")
	hightext:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", -2, -1)
	-- e

	local editbox = CreateFrame("EditBox", nil, frame, "BackdropTemplate")
	editbox:SetAutoFocus(false)
	--[[ s r
	editbox:SetFontObject(GameFontHighlightSmall)
	]]
	editbox:SetFontObject("GameFontHighlightSmall-OmniCDC")
	-- e
	editbox:SetPoint("TOP", slider, "BOTTOM")
	editbox:SetHeight(14)
	editbox:SetWidth(70)
	editbox:SetJustifyH("CENTER")
	editbox:EnableMouse(true)
	--[[ s r
	editbox:SetBackdrop(ManualBackdrop)
	]]
	OmniCDC.SetBackdrop(editbox, "ACD")
	-- e
	editbox:SetBackdropColor(0, 0, 0, 0.5)
	--[[ s r
	editbox:SetBackdropBorderColor(0.3, 0.3, 0.30, 0.80)
	]]
	editbox:SetBackdropBorderColor(0.2, 0.2, 0.25)
	-- e
	editbox:SetScript("OnEnter", EditBox_OnEnter)
	editbox:SetScript("OnLeave", EditBox_OnLeave)
	editbox:SetScript("OnEnterPressed", EditBox_OnEnterPressed)
	editbox:SetScript("OnEscapePressed", EditBox_OnEscapePressed)

	local widget = {
		label	    = label,
		slider	    = slider,
		lowtext	    = lowtext,
		hightext    = hightext,
		editbox	    = editbox,
		alignoffset = 25,
		frame	    = frame,
		type	    = Type
	}
	for method, func in pairs(methods) do
		widget[method] = func
	end
	slider.obj, editbox.obj = widget, widget

	return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(Type,Constructor,Version)
