-- bridge.fuel.cdn.server
if GetResourceState('lc_fuel') == 'started' then
    Debug('SUCCESS', Lang:t('Debug.FuelDetected') .. 'LC Fuel')
end



return {}
