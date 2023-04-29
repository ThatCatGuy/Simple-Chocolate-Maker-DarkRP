# Simple-Chocolate-Maker-DarkRP

https://steamcommunity.com/sharedfiles/filedetails/?id=2968443002

This is a nice little basic cocolate maker system with Stove, Gas, Rum, Sugar, Cocoa and Milk and Chocolate Buyer NPC called Mr Wonka. This is set by default to the Chocolate Maker job which will be added on install.

## Extra Info

This is for the Chocolate Maker job by default.
You can be made wanted by selling it if this is enabled via convar
You will be made wanted when you sell the chocolate (This is optional and can be changed with a convar and is disabled by default).
You can check you current chocolate you are holding by typing in the chat box either **/chocolate** or **!chocolate** this will then tell you in chat how much if any you have on you.

## How to configure

## NPC Config
You can spawn the chocolate buyer from the Q menu.
You can save the chocolate buyer(s) locations on the current map by using console command **simplechocolate_savenpc**.
You can remove the chocolate buyer(s) locations on the current map by using console command **simplechocolat_removenpcs** this will prevent them spawning on the next restart..
You can respawn the chocolate buyer(s) locations on the current map by using console command **simplechocolat_respawnnpcs** this is handy if you just saved them or updated the saves it will remove them from the map and reload from the file so if you move one by mistake then use the respawn command and it will fix its position.

## Chocolate Config
 You can set the cooking speed of the chocolate by setting **simplechocolate_cookingtime xxx** in your server console. (Default = 240 seconds in total its 4 mins of cooking time)
You can set the sell price of the chocolate bars by setting **simplechocolate_sellprice xxx** in your server console. (Default = 24,000 per bar)
You can set the health of the stove by setting **simplechocolate_stovehealth xxx** in your server console. (Default = 200 hp)
You can set if you become wanted when selling the chocolate by setting **simplechocolate_makewanted 1** and disable this with **simplechocolate_makewanted 0** in your server console. (Default = 0 (don't make wanted))
To configure change it so its not limited to a Job then download it from the GitHub link below and edit the darkrp info.

## How to spawn
Change to Chocolate Maker then Open the F4 menu and goto entites and purchase the Stove, Gas, Rum, Sugar, Cocoa and Milk then put the items into the stove and wait for it to cook.
