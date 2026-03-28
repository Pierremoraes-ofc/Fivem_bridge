
if GetResourceState('qb-weathersync') == 'started' then
    Debug('SUCCESS', Lang:t('Debug.WeatherDetected') .. 'QB Weather')
end

return {}
