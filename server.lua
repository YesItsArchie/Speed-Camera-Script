RegisterNetEvent("speedcamera:finePlayer")
AddEventHandler("speedcamera:finePlayer", function(speed, limit)
    local src = source
    local fine = 500 + math.floor((speed - limit) * 10) -- fine increases with overspeed
    -- Example: send a chat message, integrate with billing system if you use ESX/QBCore
    TriggerClientEvent('chat:addMessage', src, {
        args = {"Speed Camera", ("You were caught going %.1f km/h in a %d zone. Fine: $%d"):format(speed, limit, fine)}
    })
end)
