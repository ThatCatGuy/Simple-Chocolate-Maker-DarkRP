AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 

include( 'shared.lua' )

function ENT:Initialize()
	self:SetUseType( SIMPLE_USE )
	self:SetModel( "models/hunter/plates/plate025x05.mdl" )
	self:SetMaterial("phoenix_storms/cube")
	self:SetColor( Color(69,45,45,255) )
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

function ENT:Use(activator, caller)
	self:Remove()
	SimpleChocolatePickUp(caller)
end