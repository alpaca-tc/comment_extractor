--[-1-]Attribution-Share Alike 3.0 License, copyright (c) 2010 Pieter Hintjens, modified @alpaca-tc
--[-2-]  Demonstrate identities as used by the request-reply pattern.  Run this
--[-3-]  program by itself.  Note that the utility functions s_ are provided by
--[-4-]  zhelpers.h.  It gets boring for everyone to keep repeating this code.
--[-5-]
--[-6-]  Author: Robert G. Jakabosky <bobby@sharedrealm.com>
--[-7-]
require"zmq"
require"zhelpers"

local context = zmq.init(1)

local sink = context:socket(zmq.ROUTER)
sink:bind("inproc://example")

--[-16-]  First allow 0MQ to set the identity
local anonymous = context:socket(zmq.REQ)
anonymous:connect("inproc://example")
anonymous:send("ROUTER uses a generated UUID")
s_dump(sink)

--[[[-22-]
[-23-]
]]
local identified = context:socket(zmq.REQ) --[-25-]  Then set the identity ourselves
identified:setopt(zmq.IDENTITY, "PEER2")
identified:connect("inproc://example")
identified:send("ROUTER socket uses REQ's socket identity")
s_dump(sink)

sink:close()
anonymous:close()
identified:close()
context:term()
