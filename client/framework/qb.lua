if GetResourceState("qb-core") == "missing" then
    return
end

local QBCore = exports['qb-core']:GetCoreObject()

local Houses = {}
local myHouses = {}

RegisterNetEvent('qb-houses:client:setHouseConfig', function(houseConfig)
    Houses = houseConfig
end)

RegisterNetEvent('qb-spawn:client:setupSpawns', function(cData, new, apps)
    if not new then
        QBCore.Functions.TriggerCallback('qb-spawn:server:getOwnedHouses', function(houses)
            for i = 1, #houses, 1 do
                local house = houses[i]
                local enter = Houses[house.house].coords.enter
                myHouses[house.house] = {
                    label = Houses[house.house].adress,
                    coords = vec3(enter.x + 20, enter.y + 20, enter.z + 10),
                    point = vec3(enter.x, enter.y, enter.z),
                    icon = 'fas fa-home'
                }
            end
        end, cData.citizenid)
    end
end)

RegisterNetEvent('qb-spawn:client:openUI', function(value)
    QBCore.Functions.GetPlayerData(function(PlayerData)
        ---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
        SetEntityCoords(PlayerPedId(), PlayerData.position.x, PlayerData.position.y, PlayerData.position.z)
        SetEntityHeading(PlayerPedId(), PlayerData.position.a)
        FreezeEntityPosition(PlayerPedId(), false)
    end)
    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    DoScreenFadeOut(250)
    Wait(1000)
    DoScreenFadeIn(250)
    SpawnSelect(value, myHouses)
end)
