
local speedCameras = {
    {coords = vector3(215.76, -808.84, 30.73), limit = 50}, -- EXAMPLES
    {coords = vector3(-1025.0, -2731.5, 13.76), limit = 80}, --  EXAMPLES (YOU CAN PUT YOUR OWN CORDINATES HERE)
}

local detectionRadius = 15.0 -- distance to trigger camera
local fineAmount = 500 -- default fine

-- Function to convert velocity to km/h
local function getSpeedKMH(veh)
    local speed = GetEntitySpeed(veh) * 3.6
    return speed
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500) -- check every 0.5 seconds
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            local veh = GetVehiclePedIsIn(ped, false)
            local vehSpeed = getSpeedKMH(veh)
            local vehCoords = GetEntityCoords(veh)

            for _, cam in pairs(speedCameras) do
                local dist = #(vehCoords - cam.coords)
                if dist < detectionRadius then
                    if vehSpeed > cam.limit then
                        -- Apply fine or notify player
                        TriggerServerEvent("speedcamera:finePlayer", vehSpeed, cam.limit)
                        Citizen.Wait(5000) -- cooldown so it doesn't spam
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for _, cam in pairs(speedCameras) do
            DrawMarker(1, cam.coords.x, cam.coords.y, cam.coords.z - 1.0, 0,0,0,0,0,0,2.0,2.0,1.0,255,0,0,100,false,true,2,nil,nil,false)
        end
    end
end)
