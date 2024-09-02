fx_version "cerulean"

description "LTD FiveM made with React & ESX"
author "SayRoo"
version '1.0'

lua54 'yes'

games {
  "gta5",
  "rdr3"
}

ui_page 'web/index.html'

shared_scripts {
  '@base/imports.lua',
  'shared/*'
}

client_script {
  "client/**/*",
}
server_script {"server/**/*"}

files {
	'web/index.html',
	'web/**/*',
}