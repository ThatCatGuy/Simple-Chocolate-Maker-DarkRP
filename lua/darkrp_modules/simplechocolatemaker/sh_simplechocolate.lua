hook.Add("loadCustomDarkRPItems", "SimpleChocolate_Initialize", function()

TEAM_CHOCOLATEMAKER = DarkRP.createJob("Chocolate Maker", {
    color = Color(255, 255, 255, 255),
    model = {
        "models/player/Group03/Female_01.mdl",
        "models/player/Group03/Female_02.mdl"
    },
    description = [[Create chocolate and sell it to Mr Wonka! But be aware: If someone kills you then you will loose all of your chocolate bars!]],
    weapons = {},
    command = "chocolatemaker",
    max = 5,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Other",
})

local allowedChocolate = {TEAM_CHOCOLATEMAKER}

DarkRP.createCategory{
    name = "Simple Chocolate Maker",
    categorises = "entities",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = function(ply) return true end,
    sortOrder = 100,
}

DarkRP.createEntity("Milk", {
  ent = "choc_milk",
  model = "models/props_junk/garbage_milkcarton002a.mdl",
  price = 1000,
  max = 2,
  cmd = "buychocmilk",
  category = "Simple Chocolate Maker",
  allowed = allowedChocolate
})

DarkRP.createEntity("Cocoa", {
  ent = "choc_cocoa",
  model = "models/props_junk/garbage_metalcan001a.mdl",
  price = 1000,
  max = 2,
  cmd = "buychoccocoa",
  category = "Simple Chocolate Maker",
  allowed = allowedChocolate
})

DarkRP.createEntity("Sugar", {
  ent = "choc_sugar",
  model = "models/props_junk/garbage_bag001a.mdl",
  price = 1000,
  max = 2,
  cmd = "buychocsugar",
  category = "Simple Chocolate Maker",
  allowed = allowedChocolate
})

DarkRP.createEntity("Rum", {
  ent = "choc_rum",
  model = "models/props_junk/glassjug01.mdl",
  price = 1000,
  max = 1,
  cmd = "buychocrum",
  category = "Simple Chocolate Maker",
  allowed = allowedChocolate
})

DarkRP.createEntity("Gas Canister", {
  ent = "choc_gas",
  model = "models/props_c17/canister01a.mdl",
  price = 1000,
  max = 1,
  cmd = "buychocgas",
  category = "Simple Chocolate Maker",
  allowed = allowedChocolate  
})

DarkRP.createEntity("Stove", {
  ent = "choc_stove",
  model = "models/props_c17/furnitureStove001a.mdl",
  price = 12000,
  max = 1,
  cmd = "buychocstove",
  category = "Simple Chocolate Maker",
  allowed = allowedChocolate
})

end)