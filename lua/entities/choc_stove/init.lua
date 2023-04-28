AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include("shared.lua")

function ENT:SpawnFunction(ply, tr, cn)
  local ang = ply:GetAngles()
  local ent = ents.Create(cn)
  ent:SetPos(tr.HitPos + tr.HitNormal + Vector(0,0,20))
  ent:SetAngles(Angle(0, ang.y, 0) - Angle(0, 180, 0))
  ent:Spawn()

  return ent
end

function ENT:Initialize()
    self:SetUseType( SIMPLE_USE )
    self:SetModel( "models/props_c17/furniturestove001a.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:DrawShadow(false)
    
    self:SetHP(GetConVar( "simplechocolate_stovehealth" ):GetInt())
    self:SetCocoa(0)
    self:SetSugar(0)
    self:SetMilk(0)
    self:SetRum(0)
    self:SetCooking(false)
    self:SetGasStorage(600)
    self:SetGasStorageMax(600)

    self:SetPos(self:GetPos()+Vector(0, 0, 32));

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableMotion(false)
    end
    if IsValid(self.dt.owning_ent) then
        self:CPPISetOwner(self.dt.owning_ent)
        self.SID = self.dt.owning_ent.SID
    end
    
    self.Time = GetConVar( "simplechocolate_cookingtime" ):GetInt() or self.MaxTime
end

function ENT:ShouldStart()
    return self:GetCocoa() == 4 and self:GetSugar() == 12 and self:GetMilk() == 4 and self:GetRum() == 1 and self:GetGasStorage() > 120 and not self:GetCooking()
end

function ENT:OnRemove()
    timer.Remove(tostring(self:EntIndex()).."make")
    timer.Remove(tostring(self:EntIndex()))
end

function ENT:AddCocoa()
    self:SetCocoa(self:GetCocoa() + 1)
    timer.Simple(4, function()
        if !IsValid(self) then return end
    end)
end

function ENT:AddMilk()
    self:SetMilk(self:GetMilk() + 1)
    timer.Simple(4, function()
        if !IsValid(self) then return end
    end)
end

function ENT:AddRum()
    self:SetRum(self:GetRum() + 1)
    timer.Simple(4, function()
        if !IsValid(self) then return end
    end)
end

function ENT:AddSugar()
    self:SetSugar(self:GetSugar() + 3)
    timer.Simple(4, function()
        if !IsValid(self) then return end
    end)
end

function ENT:AddGas()
    self:SetGasStorage(self:GetGasStorageMax())
    timer.Simple(4, function()
        if !IsValid(self) then return end
    end)
end

function ENT:Touch(ent)
    if IsValid(ent) and !ent.Used then
        if ent:GetClass() == "choc_cocoa" and self:GetCocoa() < 4 then
            self:AddCocoa()
            ent:Remove()
            if self:ShouldStart() then self:MakeChocolate() end
        elseif ent:GetClass() == "choc_sugar" and self:GetSugar() < 12 then
            self:AddSugar()
            ent:Remove()
            if self:ShouldStart() then self:MakeChocolate() end
        elseif ent:GetClass() == "choc_milk" and self:GetMilk() < 4 then
            self:AddMilk()
            ent:Remove()
            if self:ShouldStart() then self:MakeChocolate() end
        elseif ent:GetClass() == "choc_rum" and self:GetRum() < 1 then
            self:AddRum()
            ent:Remove()
            if self:ShouldStart() then self:MakeChocolate() end
        elseif ent:GetClass() == "choc_gas" and self:GetGasStorage() < 600 then
            self:AddGas()
            ent:Remove()
            if self:ShouldStart() then self:MakeChocolate() end
        else
            return
        end
        ent.Used = true
    end
end

function ENT:CreateChocolateBar()
    local a = ents.Create("choc_bar")
    a:SetPos(self:GetPos() + Vector(0,0,25))
    a:Spawn()
end

function ENT:MakeChocolate()
    self:SetCooking(true)
    timer.Create(tostring(self:EntIndex()), 1, 0, function()
        self:EmitSound("ambient/levels/canals/toxic_slime_gurgle" .. math.random(6, 7) .. ".wav", 70)
        self:SetGasStorage(math.Clamp(self:GetGasStorage() - 1, 0, self:GetGasStorageMax()))
    end)
    timer.Create(tostring(self:EntIndex()).."make", self.Time, 1, function()
        self:SetCocoa(0)
        self:SetSugar(0)
        self:SetMilk(0)
        self:SetRum(0)
        self:SetCooking(false)

        timer.Remove(tostring(self:EntIndex()))

        local a = ents.Create("choc_bar")
        if not IsValid(a) then return end
        a:SetPos(self:GetPos() + Vector(0,0,25))
        a:Spawn()
    end)
end

function ENT:Destruct()
    local vPoint = self:GetPos()
    local effectdata = EffectData()
    effectdata:SetStart(vPoint)
    effectdata:SetOrigin(vPoint)
    effectdata:SetScale(1)
    util.Effect("Explosion", effectdata)
end

function ENT:OnTakeDamage( dmg )
    local attacker = dmg:GetAttacker()
    if not attacker:isCP() then 
    self:TakePhysicsDamage(dmg)
        self:SetHP( ( self:GetHP() or 200 ) - dmg:GetDamage() )
        if self:GetHP() <= 0 then                  
            if not IsValid( self ) then
                return
            end
            self:Destruct()
            self:Remove()
        end
    end
end