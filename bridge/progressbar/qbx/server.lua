-- bridge.progressbar.qbx.server

if GetResourceState('ox_lib') == 'started' then
    Debug('SUCCESS', Lang:t('Debug.ProgressbarDetected') .. 'Ox Lib progressbar')
end

return {}
