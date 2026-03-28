-- bridge.targets.ox.server

if GetResourceState('ox_target') == 'started' then
    Debug('SUCCESS', Lang:t('Debug.TargetDetected') .. 'Ox Target')
end

return {}
