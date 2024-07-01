fx_version 'cerulean'
game 'gta5'

author 'Mohamslw'
description 'Simple job template by Moha'
version '1.0.0'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}
client_script 'client.lua'
server_script 'server.lua'

depencies {
    'es_extended',
    'ox_lib',
    'ox_inventory',
    'ox_target'
}