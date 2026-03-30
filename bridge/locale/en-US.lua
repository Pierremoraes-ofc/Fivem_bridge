local Translations = {
    Debug = {
        FrameworkDetected = "Framework detected: %s",
        FuelDetected = "Fuel system detected: %s",
        InventoryDetected = "Inventory system detected: %s",
        NotificationDetected = "Notification system detected: %s",
        TargetDetected = "Target system detected: %s",
        PhoneDetected = "Phone system detected: %s",
        ProgressbarDetected = "Progress bar system detected: %s",
        VehicleKeyDetected = "Vehicle key system detected: %s",
    },
    message = {
        UpdateCheckFailed = "Failed to check for updates.",
        UpdateAvailable = "New version available: %s (you are on %s)",
        UpdateAvailableLink = "Access: https://github.com/%s/%s/releases/latest",
        UpdateChecked = "Version %s — you are updated!"
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})