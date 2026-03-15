local weather = {}

---This will toggle the players weather/time sync
---@param toggle boolean
function weather.ToggleSync(toggle)
    -- Lógica simples usando nativas do jogo para o exemplo "default"
    -- Quando o sync é pausado, podemos fixar o tempo ou o clima localmente
    if toggle then
        -- Retomar sincronização (exemplo hipotético, nativas puras apenas controlam localmente)
        print("Weather Sync Enabled (Default Logic)")
        NetworkClearClockTimeOverridden()
        ClearOverrideWeather()
    else
        -- Pausar/Override localmente
        print("Weather Sync Disabled (Default Logic)")
        -- Fixa o tempo localmente em 12:00 como exemplo de "pausar"
        NetworkOverrideClockTime(12, 0, 0)
        SetWeatherTypeNowPersist("EXTRASUNNY")
    end
end

function weather.GetResourceName()
    return "default"
end

return weather
