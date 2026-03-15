local notifications = {}



---Send notification to player
---@param src number
---@param data NotificationData
function notifications.Notify(src, data)
    TriggerClientEvent('ox_lib:notify', src, data)
end

return notifications
