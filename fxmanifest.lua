fx_version 'cerulean'
game 'gta5'
lua54 'yes'

client_script {
    'config.lua',
    'client/framework/*lua',
    'client/main.lua'
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/framework/*.lua'
}

ui_page 'web/index.html'

files {
    'web/index.html',
}
