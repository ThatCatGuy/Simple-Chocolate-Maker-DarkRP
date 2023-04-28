ENT.Base = "base_ai" 
ENT.Type = "ai" 
ENT.AutomaticFrameAdvance = true
ENT.PrintName = "Chocolate Buyer"
ENT.Category = "Simple Chocolate Maker"
ENT.Author = "ThatCatGuy"
ENT.Spawnable = true
ENT.AdminOnly = true 

ENT.Name 	= "Chocolate Buyer"
ENT.Model 	= "models/Humans/Group01/male_08.mdl"
ENT.NPCType = "Sell Your Chocolate"

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end