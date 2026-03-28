-- bridge.fuel.cdn.server
if GetResourceState('LegacyFuel') == 'started' then
    Debug('SUCCESS', Lang:t('Debug.FuelDetected') .. 'Legacy Fuel')
end



return {}
