
if GetResourceState('cd_easytime') == 'started' then
    Debug('SUCCESS', Lang:t('Debug.WeatherDetected') .. 'CD EasyTime')
end

return {}
