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

files {
    'web/dist/**/*',
}

ui_page 'web/dist/index.html'

-- provide 'qb-spawn