local QBCore = exports['qb-core']:GetCoreObject()

local weed1growing = false
local plant1weed = 0

-- plant 1 NetEvents --
RegisterNetEvent('allstar-drug:weedplant1', function()
    if weed1growing == false then
        QBCore.Functions.Notify('wait for the weed to grow come back later', 'success', 5500)
        collecweed1growingtionpoin1 = true
        Wait(600000) -- 600000 = 10 min 60000 = 1 min
        plant1weed = plant1weed + 1
        weed1growing = false
        QBCore.Functions.Notify('Your weed is ready to collect', 'primary', 7500)
    elseif weed1growing == true then
        QBCore.Functions.Notify('the weed stopped growing', 'error', 5500)
        weed1growing = false
    end
end)

-- plant 1 collection --
RegisterNetEvent('allstar-drug: collection weed1', function()
    if plant1weed == 0 then
        QBCore.Functions.Notify('The weed is not ready to collect', 'error', 7500)
    elseif plant1weed >= 1 then
        QBCore.Functions.Progressbar('Collect1', 'Collecting weed...', 10000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@gangops@facility@servers@',
            anim = 'hotwire',
            flags = 16,
        }, {}, {}, function() -- Play When Done
            TriggerServerEvent('allstar-drug:giveweed1', plant1weed)
            QBCore.Functions.Notify('You have collected the weed!', 'success', 5000)
            plant1weed = 0
        end, function() -- Play When Cancel
            QBCore.Functions.Notify('Did not pick up the weed', 'error', 5500)
        end)
    end
end)

-- Menu --
RegisterNetEvent('allstar-weed1:menu', function()
    QBCore.Functions.TriggerCallback('QBCore.Functions.HasItem', function(HasItem)
		if HasItem then
            local src = source
            exports['qb-menu']:openMenu({
                {
                    id = 1,
                    header = "weed plant 1",
                    txt = "",
                    isMenuHeader = true
                },
                {
                    id = 2,
                    header = "grow weed",
                    txt = " start/stop the growing ",
                    params = {
                        event = "allstar-drug:weedplant1",
                    }
                },
                {
                    id = 3,
                    header = "Collect weed",
                    txt = " Collects the weed that has grown ",
                    params = {
                        event = "allstar-drug: collection weed1",
                    }
                },
                {
                    id = 4,
                    header = "Close Menu",
                    txt = "",
                    params = {
                        event = "qb-menu:closeMenu",
                    }
                },
            })
		else
			QBCore.Functions.Notify('You do not have a trowel', 'error', 3500)
		end
	end, "trowel")
end)



-- Dev Commands --
RegisterCommand('mine', function ()
    print("weedplant 1:")
    print(weed1weed)

end)

-- Target Exports -- 

exports['qb-target']:AddBoxZone("allstar-weedgrow1", vector3(1394.68, 1139.86, 109.75), 7.1, 2.3, {
    name="weedplant",
    heading=332,
    debugpoly = true,
}, {
    options = {
        {
       event = "allstar-weed1:menu",
        icon = "fas fa-sign-in-alt",
        label = "weed",
        },
    },
    distance = 3.5
})
