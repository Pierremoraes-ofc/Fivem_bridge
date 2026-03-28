RegisterNetEvent("bridge:notify", function(data)
	Bridge.notify.Notify(data)
end)
Bridge.notify = Bridge.notify or {}

---Envia uma notificação para um jogador específico pelo servidor
---@param source number  ID do jogador
---@param data NotificationData
Bridge.notify.NotifyPlayer = function(source, data)
    if type(source) ~= "number" or source <= 0 then return end
    TriggerClientEvent("bridge:notify", source, data)
end

---Envia uma notificação para todos os jogadores conectados
---@param data NotificationData
Bridge.notify.NotifyAll = function(data)
    TriggerClientEvent("bridge:notify", -1, data)
end