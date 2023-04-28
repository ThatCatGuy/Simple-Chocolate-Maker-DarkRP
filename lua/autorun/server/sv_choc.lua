util.AddNetworkString("SimpleChocolate.Notify")
local function Notify(ply, msg)
	net.Start("SimpleChocolate.Notify")
		net.WriteString(msg)
	net.Send(ply)
end

util.AddNetworkString("SimpleChocolate.NPCNotify")
local function NPCNotify(ply, msg)
	net.Start("SimpleChocolate.NPCNotify")
		net.WriteString(msg)
	net.Send(ply)
end

function SimpleChocolateWantedPlayer(ply, reason, time)
	if not ply:getDarkRPVar("wanted") then
		ply:setDarkRPVar("wanted", true)
		NPCNotify(ply, "You are now wanted for " .. reason)
		timer.Create(ply:SteamID64() .. " wantedtimer", time, 1, function()
			if not IsValid(ply) then return end
			ply:unWanted()
		end)
	end
end

CreateConVar( "simplechocolate_sellprice", 24000, FCVAR_SERVER_CAN_EXECUTE )
CreateConVar( "simplechocolate_cookingtime", 240, FCVAR_SERVER_CAN_EXECUTE )
CreateConVar( "simplechocolate_stovehealth", 200, FCVAR_SERVER_CAN_EXECUTE )
CreateConVar( "simplechocolate_makewanted", 1, FCVAR_SERVER_CAN_EXECUTE )

local Sayings = {
	"You got something for me?",
	"Bring me something and then we can talk...",
	"Im running low on product, bring me some?",
	"Stop wasting my time and bring me some chocolate"
}

function SimpleChocolateRandomSaying(ply)
	local msg = Sayings[math.random(#Sayings)]
	NPCNotify(ply, msg)
end

function SimpleChocolateSold(ply, amount, money)
	NPCNotify(ply, "You just sold " .. amount .. " bars of chocolate for " .. DarkRP.formatMoney(money) .. "!")
end

function SimpleChocolatePickUp(ply, amount)
	ply.Chocolate = (ply.Chocolate or 0) + (amount and amount or 1)
	Notify(ply, "+" .. (amount and amount or 1) .. " bars of chocolate (" .. ply.Chocolate .. ")")
end

local function SimpleChocolateCheck(ply)
	ply.Chocolate = (ply.Chocolate or 0)
	if ply.Chocolate == 0 then Notify(ply, "You don't have any chocolate.") return end
	Notify(ply, "You have " .. ply.Chocolate .. " bars of chocolate.")
end

hook.Add( "PlayerSay", "SimpleChocolateCheck", function( ply, text  )
    if  ( string.lower( text ) == "/chocolate" or string.lower( text ) == "!chocolate" ) then
	     SimpleChocolateCheck(ply)
	    return ""
	end
end)

// NPC Spawn Functions
local map = string.lower( game.GetMap() )
//##### Save the Ents ##############################################################
local function SimpleChocolateNPCSave(ply)
    if ply:IsSuperAdmin() then   
        local chocents = {}
        for k,v in pairs( ents.FindByClass("choc_npc") ) do
            chocents[k] = { type = v:GetClass(), pos = v:GetPos(), ang = v:GetAngles() }
        end	
        local convert_data = util.TableToJSON( chocents )		
        file.Write( "simplechocolate/chocents_" .. map .. ".txt", convert_data )
        NPCNotify(ply, "Chocolate NPC Locations Saved for map " .. map)  
    end
end
concommand.Add("simplechocolate_savenpcs", SimpleChocolateNPCSave)
 
//##### Delete the Ents ##############################################################
local function SimpleChocolateNPCDelete(ply)
    if ply:IsSuperAdmin() then
    	for k,v in pairs( ents.FindByClass("choc_npc") ) do
            v:Remove()
        end
        file.Delete( "simplechocolate/chocents_" .. map .. ".txt" )
        NPCNotify(ply, "Chocolate NPC Locations Deleted from map " .. map)
    end    
end
concommand.Add("simplechocolate_removenpcs", SimpleChocolateNPCDelete)

//##### Load the Ents ##############################################################
local function SimpleChocolateNPCLoad(ply)
	if ply:IsSuperAdmin() then
		if not file.IsDir( "simplechocolate", "DATA" ) then
        	file.CreateDir( "simplechocolate", "DATA" )
    	end
		if not file.Exists("simplechocolate/chocents_" .. map .. ".txt","DATA") then return end
		for k,v in pairs( ents.FindByClass("choc_npc") ) do
            v:Remove()
        end	
		local ImportData = util.JSONToTable(file.Read("simplechocolate/chocents_" .. map .. ".txt","DATA"))
	    	for k, v in pairs(ImportData) do
	        local ent = ents.Create( v.type )
	        ent:SetPos( v.pos )
	        ent:SetAngles( v.ang )
	        ent:Spawn()
		end
	end
end
concommand.Add("simplechocolate_respawnnpcs", SimpleChocolateNPCLoad)

//##### Autospawn the Ents ##############################################################
local function SimpleChocolateNPCInit()
    if not file.IsDir( "simplechocolate", "DATA" ) then
        file.CreateDir( "simplechocolate", "DATA" )
    end
	if not file.Exists("simplechocolate/chocents_" .. map .. ".txt","DATA") then return end
	local ImportData = util.JSONToTable(file.Read("simplechocolate/chocents_" .. map .. ".txt","DATA"))
    	for k, v in pairs(ImportData) do
        local ent = ents.Create( v.type )
        ent:SetPos( v.pos )
        ent:SetAngles( v.ang )
        ent:Spawn()
	end
end
hook.Add( "InitPostEntity", "SimpleChocolateNPCInit", SimpleChocolateNPCInit )