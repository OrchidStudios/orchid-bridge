fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Orchid Studios'
description 'Orchid Bridge'
version '0.5.0'

shared_scripts {
	'@ox_lib/init.lua'
}

files {
	'data/*.lua',
	'framework/**/client.lua',
	'**/*.lua',
	'modules/**/client/*.lua',
	'modules/**/*.lua',
	'init.lua',

	'web/build/index.html',
	'web/build/assets/*.js',
	'web/build/assets/*.css'
}

client_scripts {
	'exports/client/*.lua',

	-- 'tests/*.lua',
}

server_scripts {
	'versionChecker.lua',
	'exports/server/*.lua',
}

ui_page 'web/build/index.html'
