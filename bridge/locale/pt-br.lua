local Translations = {
    Debug = {
        FrameworkDetected = "Framework detectado: %{framework}",
        FuelDetected = "Sistema de combustível detectado: %s{fuel}",
        InventoryDetected = "Sistema de inventário detectado: %s{inventory}",
        NotificationDetected = "Sistema de notificação detectado: %s{notification}",
        TargetDetected = "Sistema de alvo detectado: %s{target}",
        PhoneDetected = "Sistema de telefone detectado: %s{phone}",
        ProgressbarDetected = "Sistema de barra de progresso detectado: %s{progressbar}",
        VehicleKeyDetected = "Sistema de chave de veículo detectado: %s{vehiclekey}",
        WeatherDetected = "Sistema de clima detectado: %s{weather}",
    },
    message = {
        UpdateCheckFailed = "Não foi possível verificar atualizações.",
        UpdateAvailable = "Nova versão disponível: %s{newversion} (você está na %s{oldversion})",
        UpdateAvailableLink = "Acesse: https://github.com/%s{author}/%s{repo}/releases/latest",
        UpdateChecked = "Versão %s{oldversion} — você está atualizado!"
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})