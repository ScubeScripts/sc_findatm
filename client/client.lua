ESX = exports["es_extended"]:getSharedObject()

function getNearestATM()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local nearestATM = nil
    local shortestDistance = math.huge

    for _, atm in ipairs(Config.atmLocations) do
        local atmCoords = vector3(atm.x, atm.y, atm.z)
        local distance = #(playerCoords - atmCoords)
        if distance < shortestDistance then
            shortestDistance = distance
            nearestATM = atmCoords
        end
    end

    return nearestATM
end

RegisterCommand("findatm", function()
    local nearestATM = getNearestATM()
    if nearestATM then
        SetNewWaypoint(nearestATM.x, nearestATM.y)
        ESX.ShowNotification(Translation[Config.Locale]['atm_mark'])
    else
        ESX.ShowNotification(Translation[Config.Locale]['atm_error'])
    end
end, false)
