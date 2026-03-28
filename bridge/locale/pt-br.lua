local Translations = {
    Debug = {
        FrameworkDetected = "Framework detectado: %s",
        FuelDetected = "Sistema de combustível detectado: %s",
        InventoryDetected = "Sistema de inventário detectado: %s",
        NotificationDetected = "Sistema de notificação detectado: %s",
        TargetDetected = "Sistema de alvo detectado: %s",
        PhoneDetected = "Sistema de telefone detectado: %s",
        ProgressbarDetected = "Sistema de barra de progresso detectado: %s",
        VehicleKeyDetected = "Sistema de chave de veículo detectado: %s",
    },
    message = {
        UpdateCheckFailed = "Não foi possível verificar atualizações.",
        UpdateAvailable = "Nova versão disponível: %s (você está na %s)",
        UpdateAvailableLink = "Acesse: https://github.com/%s/%s/releases/latest",
        UpdateChecked = "Versão %s — você está atualizado!"
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})