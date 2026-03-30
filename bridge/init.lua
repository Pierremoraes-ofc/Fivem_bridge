ActiveBridges = {}

--- Gets the bridge functions
---@param bridgeType string Bridge type from config.lua
---@return string
local function getBridge(bridgeType)
    local context = lib.context
    local bridge = ConfigBridge[bridgeType]

    for i = 1, #bridge do
        local info = bridge[i]
        if GetResourceState(info.resource):find("start") then
            ActiveBridges[bridgeType] = info.folder
            return ("bridge.%s.%s.%s"):format(bridgeType, info.folder, context)
        end
    end

    ActiveBridges[bridgeType] = "default"
    return ("bridge.%s.%s.%s"):format(bridgeType, "default", context)
end


Bridge = {
    framework = lib.load(getBridge("frameworks")),
    inventory = lib.load(getBridge("inventories")),
    notify = lib.load(getBridge("notifications")),
    target = lib.load(getBridge("targets")),
    phone = lib.load(getBridge("phones")),
    progress = lib.load(getBridge("progressbar")),
    weather = lib.load(getBridge("weather")),
    fuel = lib.load(getBridge("fuel")),
    vehicle_key = lib.load(getBridge("vehicle_key"))
}
