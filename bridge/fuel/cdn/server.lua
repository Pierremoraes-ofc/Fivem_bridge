-- bridge.fuel.cdn.server
if GetResourceState('cdn-fuel') == 'started' then
    Debug('SUCCESS', Lang:t('Debug.FuelDetected') .. 'CDN Fuel')
end



return {}
