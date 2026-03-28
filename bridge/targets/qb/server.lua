
if GetResourceState('qb-target') == 'started' then
    Debug('SUCCESS', Lang:t('Debug.TargetDetected') .. 'QB Target')
end

return {}
