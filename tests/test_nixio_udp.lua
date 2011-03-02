-- Copyright (c) 2010 by Robert G. Jakabosky <bobby@neoawareness.com>
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

local connection = require'handler.nixio.connection'
local ev = require'ev'
local loop = ev.Loop.default

local udp_client_mt = {
handle_error = function(this, err)
	if err ~= 'closed' then
		print('udp_client.error:', err)
	end
end,
handle_connected = function(this)
	print('udp_client.connected:')
	this.sck:send('hello\n')
end,
handle_data = function(this, data)
	print('udp_client.data:',data)
end,
}
udp_client_mt.__index = udp_client_mt

-- new udp client
local function new_udp_client(host, port)
	local this = setmetatable({}, udp_client_mt)
	this.sck = connection.udp(loop, this, host, port)
	return this
end

local host = arg[1] or "localhost"
local port = arg[2] or 8081
local client = new_udp_client(host, port)

loop:loop()
