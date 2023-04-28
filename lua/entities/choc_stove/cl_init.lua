include( 'shared.lua' )

surface.CreateFont( "ChocSmall", {
    font = "Roboto",
    size = 20,
    weight = 500,
})

surface.CreateFont( "ChocMedium", {
    font = "Roboto",
    size = 38,
    weight = 500,
})

surface.CreateFont( "ChocLarge", {
    font = "Roboto",
    size = 42,
    weight = 500,
})

function ENT:Initialize()
	self.Time = GetConVar( "simplechocolate_cookingtime" ):GetInt() or self.MaxTime
end

local color_white 	= Color(255,255,255)
local color_black 	= Color(0,0,0)
local color_green 	= Color(0, 220, 0)
local color_red   	= Color(220, 0, 0)

local function Notify(msg, color, prefix)
	chat.AddText(color, prefix .. " | ", Color(240, 240, 240), msg)
end

function ENT:Draw()
   	self:DrawModel()
   	self:DrawShadow(false)
   	local Pos = self:GetPos()
    local Ang = self:GetAngles()
	local dist = Pos:Distance(LocalPlayer():GetPos())
	local alpha = 255 - dist

	color_white.a = alpha
	color_black.a = alpha
	color_green.a = alpha
	color_red.a = alpha
	
	if dist > 280 then return end
	local Cocoa = self:GetCocoa()
	local Sugar = self:GetSugar()
	local Milk = self:GetMilk()
	local Rum = self:GetRum()
	local Cooking = self:GetCooking()
	local Gas = self:GetGasStorage()
	local MaxGas = self:GetGasStorageMax()
	local owner = self:Getowning_ent()

    owner = (IsValid(owner) and owner:Nick()) or DarkRP.getPhrase("unknown")

    Ang:RotateAroundAxis(Ang:Right(),-90)
    Ang:RotateAroundAxis(Ang:Up(),90)
    cam.Start3D2D(Pos + (Ang:Up() * 15),Ang,0.10)
    local w = 220
		draw.RoundedBox(0,-160,-150,320,w,color_black)
		if owner then
			draw.SimpleTextOutlined(owner,"ChocLarge",0,-150,color_white,TEXT_ALIGN_CENTER,0,2, color_black)
		end
		draw.SimpleTextOutlined("Cocoa " .. Cocoa .. " / 4","ChocMedium",0,-100,(Cocoa == 4 and color_green ) or color_red,TEXT_ALIGN_CENTER,0,2,color_black)
		draw.SimpleTextOutlined("Sugar " .. Sugar .. " / 12","ChocMedium",0,-70,(Sugar == 12 and color_green ) or color_red,TEXT_ALIGN_CENTER,0,2,color_black)
		draw.SimpleTextOutlined("Milk " .. Milk .. " / 4","ChocMedium",0,-35,(Milk == 4 and color_green ) or color_red,TEXT_ALIGN_CENTER,0,2,color_black)
		draw.SimpleTextOutlined("Rum " .. Rum .. " / 1","ChocMedium",0,-5,(Rum == 1 and color_green ) or color_red,TEXT_ALIGN_CENTER,0,2,color_black)

		draw.RoundedBox(0,-150,43,300,20,color_black)
		draw.RoundedBox(0,-148,45,math.Round( (Gas*296) / MaxGas),17, (Gas <= 120 and color_red ) or color_green)
		draw.SimpleTextOutlined("Gas: " .. math.Round( (Gas*100) / MaxGas).."%","ChocSmall",0,43, color_white,TEXT_ALIGN_CENTER,0,1,color_black)
		if Gas <= 120 then
			draw.SimpleTextOutlined("More Gas Needed!","ChocSmall",0,-189,color_red,TEXT_ALIGN_CENTER,0,2,color_black)
		end

		if self.choc and !Cooking then self.choc = nil end
		if Cocoa == 4 and Sugar == 12 and Milk == 4 and Rum == 1 and Cooking then
			if !self.choc then self.choc = CurTime() end
			local tw = CurTime() - self.choc
			local td = tw / self.Time
			self.tt = td * 296
			if self.tt >= 295 then self.choc = nil end
			draw.RoundedBox(0,-150,-195,300,30,color_black)
			draw.RoundedBox(0,-148,-193,self.tt,26,color_green)
			draw.SimpleTextOutlined("Cooking Chocolate...","ChocSmall",0,-189,color_white,TEXT_ALIGN_CENTER,0,2,color_black)
			
		end
	cam.End3D2D() 
end