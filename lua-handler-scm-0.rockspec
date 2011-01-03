#!/usr/bin/env lua

package	= 'lua-handler'
version	= 'scm-0'
source	= {
	url	= 'git://github.com/Neopallium/lua-handlers.git'
}
description	= {
	summary	= "Socket handler class that wrap lua-ev/luasocket.",
	detailed	= '',
	homepage	= 'https://github.com/Neopallium/lua-handlers',
	license	= 'MIT',
}
dependencies = {
	'luasocket',
	'lua-ev',
}
build	= {
	type		= 'none',
	install = {
		lua = {
			['handler.acceptor'] = "handler/acceptor.lua",
			['handler.connection']  = "handler/connection.lua",
			['handler.datagram']  = "handler/datagram.lua",
		}
	}
}
