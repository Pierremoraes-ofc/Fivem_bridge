local notifications = {}

if ActiveBridges["notification"] ~= "ox_lib" then return end

--- Notification
---@param data NotificationData
function notifications.Notify(data)
    lib.notify(data)
end

return notifications