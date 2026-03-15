local notifications = {}



---Send notification to player
---@param src number
---@param data NotificationData
function notifications.Notify(src, data)
    local title = data.title or ''
    local desc = data.description or ''

    TriggerClientEvent('esx:showNotification', src, title .. ' ' .. desc)
end

return notifications
