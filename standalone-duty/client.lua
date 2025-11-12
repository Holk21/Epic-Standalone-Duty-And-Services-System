local isOnDuty = false
local playerRole, playerCallsign = nil, nil

RegisterCommand('duty', function()
    SetNuiFocus(true, true)
    SendNUIMessage({action = 'openDuty'})
end)

RegisterNUICallback('selectRole', function(data, cb)
    local role = data.role
    SendNUIMessage({action = 'askCallsign', role = role})
    cb('ok')
end)

RegisterNUICallback('setCallsign', function(data, cb)
    playerCallsign = data.callsign
    playerRole = data.role
    isOnDuty = true
    SetNuiFocus(false, false)
    TriggerServerEvent('standalone-duty:server:setDuty', playerRole, playerCallsign)
    cb('ok')
end)

RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterCommand('offduty', function()
    if isOnDuty then
        TriggerServerEvent('standalone-duty:server:offDuty')
        isOnDuty = false
        playerRole, playerCallsign = nil, nil
    else
        TriggerEvent('standalone-duty:client:notify', "You are not on duty", "error")
    end
end)

RegisterNetEvent('standalone-duty:client:notify', function(msg, type)
    if Config.NotifySystem == "okokNotify" then
        exports['okokNotify']:Alert(Config.DutyTitle, msg, 4000, type)
    else
        TriggerEvent('chat:addMessage', { args = { '[Duty]', msg } })
    end
end)
