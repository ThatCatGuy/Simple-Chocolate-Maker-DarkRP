ENT.Base = "base_ai" 
ENT.Type = "ai" 
ENT.AutomaticFrameAdvance = true
ENT.PrintName = "Chocolate Buyer NPC"
ENT.Category = "Simple Chocolate Maker"
ENT.Author = "ThatCatGuy"
ENT.Spawnable = true
ENT.AdminOnly = true 

ENT.Name 	= "Mr Wonka"
ENT.Model 	= "models/Humans/Group01/male_08.mdl"
ENT.NPCType = "Sell Your Chocolate"

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end