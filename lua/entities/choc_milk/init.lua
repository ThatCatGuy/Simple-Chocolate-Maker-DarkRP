AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 

include( "shared.lua" )

function ENT:Initialize()
	self:SetUseType( SIMPLE_USE )
	self:SetModel( "models/props_junk/garbage_milkcarton002a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON  )
	self:DrawShadow(false)

  local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end