local QBCore = exports['qb-core']:GetCoreObject()
local searched = {3423423}
local canSearch = true

RegisterNetEvent('qb-airportrun:client:searchtrash', function()
    if canSearch then
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local dumpsterFound = false
        
        for i = 1, #Config.Objects do
            local dumpster = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, Config.Objects[i], false, false, false)
            local dumpPos = GetEntityCoords(dumpster)
            local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true)
            
            if dist < 1.8 then
                for i = 1, #searched do
                    if searched[i] == dumpster then
                        dumpsterFound = true
                    end
                    if i == #searched and dumpsterFound then
                        QBCore.Functions.Notify('This Location has already been searched try somewhere else you bum!', 'error')
                    elseif i == #searched and not dumpsterFound then
                        
                        local itemType = math.random(#Config.RewardTypes)
                        TriggerEvent('qb-airportrun:client:progressbar', itemType)
                        TriggerServerEvent('qb-airportrun:server:startDumpsterTimer', dumpster)
                        table.insert(searched, dumpster)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('qb-airportrun:server:removeDumpster', function(object)
    for i = 1, #searched do
        if searched[i] == object then
            table.remove(searched, i)
        end
    end
end)

RegisterNetEvent('qb-airportrun:client:progressbar', function(itemType)
    local item = math.random(#Config.RewardsSmall)
    QBCore.Functions.Progressbar("trash_find", "Searching Luggage..", math.random(3000, 5000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@idle_b",
        anim = "idle_d",
        flags = 16,
    }, {}, {}, function()-- Done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        if Config.RewardTypes[itemType].type == "item" then
            QBCore.Functions.Notify("Found Something", "success")
            TriggerServerEvent('qb-airportrun:server:recieveItem', Config.RewardsSmall[item].item, math.random(Config.RewardsSmall[item].minAmount, Config.RewardsSmall[item].maxAmount))
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.RewardsSmall[item].item], "add")
        elseif Config.RewardTypes[itemType].type == "money" then
            QBCore.Functions.Notify("Found Some Money", "success")
            TriggerServerEvent('qb-airportrun:server:givemoney', math.random(10, 50))
        elseif Config.RewardTypes[itemType].type == "nothing" then
            QBCore.Functions.Notify("Found Nothing", "error")
        end
    end, function()-- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        QBCore.Functions.Notify("Stopped Searching", "error")
    end)
end)

CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.Objects, {
        options = {
            {
                type = "client",
                event = "qb-airportrun:client:searchtrash",
                icon = "fas fa-pencil-ruler",
                label = "Search",
            },
        },
        distance = 2.0
    })
end)
