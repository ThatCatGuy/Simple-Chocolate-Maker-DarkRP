ENT.Type = 'anim'
 
ENT.PrintName = "Chocolate Stove"
ENT.Category = "Simple Chocolate Maker"
ENT.Author = "ThatCatGuy"
ENT.Purpose = "Make Chocolate"
ENT.Instructions = "N/A"
ENT.Freeze = true
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.MaxTime = 240
ENT.HP = 200

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
    self:NetworkVar("Int", 0, "HP")
    self:NetworkVar("Int", 1, "Cocoa")
    self:NetworkVar("Int", 2, "Sugar")
    self:NetworkVar("Int", 3, "Milk")
    self:NetworkVar("Int", 4, "Rum")
    self:NetworkVar("Int", 5, "GasStorage") 
    self:NetworkVar("Int", 6, "GasStorageMax") 
    self:NetworkVar("Bool", 7, "Cooking")    
end