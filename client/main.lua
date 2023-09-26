local cam
local cam2
local lastCamLocation

---@param last boolean
---@param options table
function SpawnSelect(last, options)
    local coords = last and GetEntityCoords(cache.ped) or Config.spawns[Config.Default].coords
    local heading = GetEntityHeading(cache.ped)
    local point = last and GetEntityCoords(cache.ped) or Config.spawns[Config.Default].point
    SetEntityVisible(cache.ped, false, false)
    FreezeEntityPosition(cache.ped, true)
    local pedCoords = GetEntityCoords(cache.ped)
    cam2 = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamCoord(cam2, pedCoords.x, pedCoords.y, pedCoords.z + 1500)
    PointCamAtCoord(cam2, pedCoords.x, pedCoords.y, pedCoords.z)
    SetCamActiveWithInterp(cam2, cam, 6000, 1, 1)
    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamCoord(cam, coords.x + 20, coords.y + 20, coords.z + 10)
    PointCamAtCoord(cam, point.x, point.y, point.z)
    SetCamActiveWithInterp(cam, cam2, 6000, 1, 1)
    RenderScriptCams(true, true, 5000, true, true)
    SetEntityHeading(cache.ped, coords.w)
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
        ---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
        SetEntityCoords(cache.ped, coords.x, coords.y, coords.z)
        SetEntityHeading(cache.ped, heading)
    else
        ---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
        SetEntityCoords(cache.ped, point.x, point.y, point.z)
        SetEntityHeading(cache.ped, point.w)
    end
    SendNUIMessage({
        show = true
    })
    SetNuiFocus(true, true)
    SendNUIMessage({
        data = {
            spawns = Config.spawns,
            title = last and Config.spawns['last'].label or Config.spawns[Config.Default].label
        }
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
    SendNUIMessage({
        data = {
            title = value.label
        }
    })
    Wait(1000)
    ---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
    SetEntityCoords(cache.ped, value.point.x, value.point.y, value.point.z)
    SetEntityHeading(cache.ped, value.point.w)
    lastCamLocation = data
end)

RegisterNUICallback('spawn', function(data, cb)
    SetEntityVisible(cache.ped, true, false)
    FreezeEntityPosition(cache.ped, false)
    SetNuiFocus(false, false)
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
end)
