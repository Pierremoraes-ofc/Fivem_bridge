
name          "fivem_bridge"
description   "Adicione compatibilidade com frameworks, targets, inventários, notificações, telefones e mais."
version       "1.0.2"
repository    "https://github.com/Pierremoraes-ofc/Fivem_bridge"
author        "Pierremoraes-ofc"

fx_version "cerulean"
game       "gta5"
lua54      "yes"

use_experimental_fxv2_oal "yes"
dependency "ox_lib"


-- Arquivos de configuração e inicialização (client + server)
shared_scripts {
    '@ox_lib/init.lua',
    '@qb-core/shared/locale.lua',
    "bridge/config.lua",
    'bridge/locale/*.lua',
    "bridge/init.lua"
}
-- Scripts de server de cada módulo (se houver)
server_scripts {
    'bridge/locale/*.lua',
    "bridge/version.lua",
    "bridge/**/*.lua",
    "bridge/**/**/*.lua",
}
files {
    "bridge/**/**/client.lua"
}
-- Scripts de client de cada módulo
client_scripts {
    "bridge/**/*.lua",
    "bridge/**/**/*.lua",
}
