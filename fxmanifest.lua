fx_version 'adamant'
game 'gta5'
lua54 "yes"

author 'Skymidz#7333'

-- RageUI V2
client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
}

-- Client
client_scripts {
    '@es_extended/locale.lua',
    "locales/*.lua",
    "client/*.lua",
}

-- Server
server_scripts {
    "@mysql-async/lib/MySQL.lua",
    '@es_extended/locale.lua',
    "locales/*.lua",
    "server/*.lua",
}

-- Shared
shared_scripts {
    "shared/*.lua",
}

escrow_ignore {
    "shared/config.lua",
    "locales/fr.lua", 
    "locales/en.lua"
}