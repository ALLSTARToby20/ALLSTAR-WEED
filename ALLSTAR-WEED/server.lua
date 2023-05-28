local QBCore = exports['qb-core']:GetCoreObject()

-- Server Events --
RegisterServerEvent("allstar-drug:giveweed1")
AddEventHandler("allstar-drug:giveweed1", function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local a = 0
    repeat
        Player.Functions.AddItem("weedbud", 30)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["weedbud"], "add")
        a = a + 1
    until( a == amount )   
end)
