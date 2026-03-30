-- bridge/version.lua  (carregado no shared_scripts)
local CURRENT_VERSION = "1.0.0"
local REPO_OWNER      = "Pierremoraes-ofc"
local REPO_NAME       = "Fivem_bridge"

-- Só roda no server para não abrir requisição no client
if IsDuplicityVersion() then
    CreateThread(function()
        -- Aguarda o server subir completamente
        Wait(5000)

        local url = ("https://api.github.com/repos/%s/%s/releases/latest"):format(REPO_OWNER, REPO_NAME)

        PerformHttpRequest(url, function(statusCode, response, headers)
            if statusCode ~= 200 or not response then
                if Config.debug then
                    Debug('ERROR', Lang:t('message.UpdateCheckFailed'))
                end
                return
            end

            local data = json.decode(response)
            if not data or not data.tag_name then return end

            local latestVersion = data.tag_name:gsub("^v", "") -- remove "v" se tiver, ex: "v1.0.1" -> "1.0.1"

            if latestVersion ~= CURRENT_VERSION then
                Debug('WARN', Lang:t('message.UpdateAvailable', { newversion = latestVersion, oldversion = CURRENT_VERSION }))
                Debug('WARN', Lang:t('message.UpdateAvailableLink', { author = REPO_OWNER, repo = REPO_NAME }))
            else
                if Config.debug then
                    Debug('SUCCESS', Lang:t('message.UpdateChecked', { oldversion = CURRENT_VERSION }))
                end
            end
        end, "GET", "", { ["User-Agent"] = "fivem_bridge" })
    end)
end