fx_version 'cerulean'
game 'gta5'

description 'Professional Arrest System for vRP'
author 'vnohnn4-sketch'
version '1.0.0'
repository 'https://github.com/vnohnn4-sketch/fivem-arrest-system'

server_scripts {
    'server/main.lua',
    'server/database.lua',
    'server/commands.lua'
}

client_scripts {
    'client/main.lua',
    'client/arrest.lua',
    'client/ui.lua'
}

shared_scripts {
    'shared/config.lua'
}

dependencies {
    'vrp'
}
