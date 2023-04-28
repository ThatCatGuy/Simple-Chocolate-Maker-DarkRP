AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
include('shared.lua')

function ENT:Initialize()
	self:SetModel(self.Model)
	self:DrawShadow(false)
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self:SetMaxYawSpeed(90)
end

local simplechocolate_sellprice = GetConVar( "simplechocolate_sellprice" )
local simplechocolate_makewanted = GetConVar( "simplechocolate_makewanted" )

function ENT:AcceptInput(name, activator, caller, data)
	if caller.NPCNextUse and caller.NPCNextUse > CurTime() then
		return
	end
	caller.NPCNextUse = CurTime() + 5
	if name == "Use" and IsValid(caller) and caller:IsPlayer() then
		if caller.Chocolate and caller.Chocolate > 0 then
			local reward = caller.Chocolate * simplechocolate_sellprice:GetInt()
			SimpleChocolateSold(caller, caller.Chocolate, reward)
			caller.Chocolate = 0
			caller:addMoney(reward)

			if simplechocolate_makewanted:GetBool() then // Make Wanted
				SimpleChocolateWantedPlayer(caller, "Selling illigal chocolate.", 300)
			end
		else
			SimpleChocolateRandomSaying(caller)
		end
	end
end