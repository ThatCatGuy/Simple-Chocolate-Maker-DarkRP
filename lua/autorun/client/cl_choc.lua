local function Notify(msg)
	chat.AddText(Color(74, 58, 58), "Chocolate | ", Color(240, 240, 240), msg)
end

local function NPCNotify(msg)
	chat.AddText(Color(74, 58, 58), "Chocolate Buyer | ", Color(240, 240, 240), msg)
end

net.Receive("SimpleChocolate.Notify", function()
	Notify(net.ReadString())
end)

net.Receive("SimpleChocolate.NPCNotify", function()
	NPCNotify(net.ReadString())
end)