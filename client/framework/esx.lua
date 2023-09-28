if GetResourceState("es_extended") == "missing" then
    return
end

local isFirstSpawn = true

AddEventHandler('esx:onPlayerSpawn', function()
    if isFirstSpawn then
        SpawnSelect(true, {})
        isFirstSpawn = false
    end
end)
