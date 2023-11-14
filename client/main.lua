local cam
local cam2
local lastCamLocation

local function SetVisible(bool)
    SendNUIMessage({
        action = 'setVisible',
        data = bool
    })
    SetNuiFocus(bool, bool)
end

---@param last boolean
---@param options table
function SpawnSelect(last, options)
    local coords = last and GetEntityCoords(PlayerPedId()) or Config.spawns[Config.Default].coords
    local heading = GetEntityHeading(PlayerPedId())
    local point = last and GetEntityCoords(PlayerPedId()) or Config.spawns[Config.Default].point
    SetEntityVisible(PlayerPedId(), false, false)
    FreezeEntityPosition(PlayerPedId(), true)
    local pedCoords = GetEntityCoords(PlayerPedId())
    cam2 = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamCoord(cam2, pedCoords.x, pedCoords.y, pedCoords.z + 1500)
    PointCamAtCoord(cam2, pedCoords.x, pedCoords.y, pedCoords.z)
    SetCamActiveWithInterp(cam2, cam, 6000, 1, 1)
    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamCoord(cam, coords.x + 20, coords.y + 20, coords.z + 10)
    PointCamAtCoord(cam, point.x, point.y, point.z)
    SetCamActiveWithInterp(cam, cam2, 6000, 1, 1)
    RenderScriptCams(true, true, 5000, true, true)
    SetEntityHeading(PlayerPedId(), coords.w)
    if options and next(options) then
        for k, v in pairs(options) do
            Config.spawns[k] = v
        end
    end
    if last then
        Config.spawns['last'] = {
            label = 'Last Location',
            coords = vec3(coords.x + 20, coords.y + 20, coords.z + 10),
            point = coords
        }
        ---@diagnostic disable-next-line: missing-parameter
        SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z)
        SetEntityHeading(PlayerPedId(), heading)
    else
        ---@diagnostic disable-next-line: missing-parameter
        SetEntityCoords(PlayerPedId(), point.x, point.y, point.z)
        SetEntityHeading(PlayerPedId(), point.w)
    end
    SetVisible(true)
    Wait(100)
    SendNUIMessage({
        action = 'setSpawns',
        data = Config.spawns
    })
    lastCamLocation = last and 'last' or Config.Default
end

exports('SpawnSelect', SpawnSelect)

RegisterNUICallback('setLocation', function(data, cb)
    if lastCamLocation == data then
        return
    end
    local value = Config.spawns[data]
    local lastValue = Config.spawns[lastCamLocation]
    cam2 = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamCoord(cam2, lastValue.coords.x, lastValue.coords.y, lastValue.coords.z + 1500)
    PointCamAtCoord(cam2, lastValue.point.x, lastValue.point.y, lastValue.point.z)
    SetCamActiveWithInterp(cam2, cam, 6000, 1, 1)
    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamCoord(cam, value.coords.x, value.coords.y, value.coords.z)
    PointCamAtCoord(cam, value.point.x, value.point.y, value.point.z)
    SetCamActiveWithInterp(cam, cam2, 6000, 1, 1)
    Wait(1000)
    ---@diagnostic disable-next-line: missing-parameter
    SetEntityCoords(PlayerPedId(), value.point.x, value.point.y, value.point.z)
    SetEntityHeading(PlayerPedId(), value.point.w)
    lastCamLocation = data
end)

RegisterNUICallback('spawn', function(data, cb)
    SendNUIMessage({
        action = 'setSpawns',
        data = {}
    })
    Wait(100)
    SetVisible(false)
    SetEntityVisible(PlayerPedId(), true, false)
    FreezeEntityPosition(PlayerPedId(), false)
    if cam then
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        cam = nil
    end
    if cam2 then
        SetCamActive(cam2, false)
        DestroyCam(cam2, true)
        cam2 = nil
    end
    RenderScriptCams(false, true, 5000, true, true)
    cb(true)
end)
