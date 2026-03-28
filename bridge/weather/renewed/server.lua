-- bridge.weather.renewed.server

if GetResourceState('renewed_weather') == 'started' then
    Debug('SUCCESS', Lang:t('Debug.WeatherDetected') .. 'Renewed Weather')
end

return {}
