local onDuty = {}

RegisterNetEvent('standalone-duty:server:setDuty', function(role, callsign)
    local src = source
    onDuty[src] = {role = role, callsign = callsign}
    TriggerClientEvent('standalone-duty:client:notify', src, "You are now on duty as " .. role .. " | Callsign: " .. callsign, "success")
end)

RegisterNetEvent('standalone-duty:server:offDuty', function()
    local src = source
    onDuty[src] = nil
    TriggerClientEvent('standalone-duty:client:notify', src, "You are now off duty", "info")
end)

RegisterCommand('services', function(source)
    local police, fire, ambulance = 0, 0, 0
    for _, v in pairs(onDuty) do
        if v.role == "Police" then police = police + 1 end
        if v.role == "Fire" then fire = fire + 1 end
        if v.role == "Ambulance" then ambulance = ambulance + 1 end
    end
    local civs = #GetPlayers() - (police + fire + ambulance)
    TriggerClientEvent('chat:addMessage', source, { args = { '[Services]', ('Police: %s | Fire: %s | Ambulance: %s | Civilians: %s'):format(police, fire, ambulance, civs) } })
end)
