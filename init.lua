--[[
   ****************************************************************
   *******                   Simple Chat                     ******
   *******       A Mod to manage the Chat in Minetest        ******
   *******                  License: GPL 3.0                 ******
   *******                     by A.C.M.                     ******
   ****************************************************************
--]]


smart_chat = {}

local sc = smart_chat
sc.player = {}
sc.public = {}
sc.last_command = nil

sc.version = 1
sc.revision = 5

sc.modname = minetest.get_current_modname()
sc.modpath = minetest.get_modpath(sc.modname)

local path = sc.modpath

sc.helpsystem = {}
sc.registered_commands = {}

sc.storage = minetest.get_mod_storage()
sc.permchannel = {}
sc.socket = {}

-- Colors for Chat
sc.green = minetest.get_color_escape_sequence('#00FF00')
sc.red = minetest.get_color_escape_sequence('#FF0000')
sc.orange = minetest.get_color_escape_sequence('#FF6700')
sc.blue = minetest.get_color_escape_sequence('#0000FF')
sc.yellow = minetest.get_color_escape_sequence('#FFFF00')
sc.purple = minetest.get_color_escape_sequence('#FF00FF')
sc.pink = minetest.get_color_escape_sequence('#FFAAFF')
sc.white = minetest.get_color_escape_sequence('#FFFFFF')
sc.black = minetest.get_color_escape_sequence('#000000')
sc.grey = minetest.get_color_escape_sequence('#888888')
sc.light_blue = minetest.get_color_escape_sequence('#8888FF')
sc.light_green = minetest.get_color_escape_sequence('#88FF88')
sc.light_red = minetest.get_color_escape_sequence('#FF8888')

sc.irc_on = minetest.settings:get_bool("smart_chat.irc_on") or false

sc.S = nil
local S

if(minetest.get_translator ~= nil) then
    S = minetest.get_translator(sc.modname)

else
    S = function ( s ) return s end

end

if (sc.irc_on) then

-- Let it be.
    local env, request_env = _G, minetest.request_insecure_environment
    env = request_env()

    if (not request_env) then
        minetest.log("action", "[MOD] " .. sc.modname .. ": Could not initalise insequre_environment.")
        sc.irc_on = false

    end -- if(request_env

    if (not env) then
        minetest.log("action", "[MOD] " .. sc.modname .. ": Please add the mod to secure.trusted_mods to run.")
        sc.irc_on = false

    end -- if (not env

    local old = require
    require = env.require
    sc.socket = require("socket")
    require = old
    minetest.log("action", "[MOD] " .. sc.modname .. " Socket-Library loaded.")

else
    print("IRC turned off.")

end -- if (sc.irc

sc.S = S

dofile(path .. "/lib.lua")
dofile(path .. "/core.lua")
dofile(path .. "/cmd_help.lua")
dofile(path .. "/irc.lua")
dofile(path .. "/matterbridge.lua"
dofile(path .. "/cmd_join.lua")
dofile(path .. "/cmd_leave.lua")
dofile(path .. "/cmd_list.lua")
dofile(path .. "/cmd_channels.lua")
dofile(path .. "/cmd_all.lua")
dofile(path .. "/cmd_invite.lua")
dofile(path .. "/cmd_toggle.lua")
dofile(path .. "/cmd_where.lua")
dofile(path .. "/cmd_store_channel.lua")
dofile(path .. "/cmd_free_channel.lua")
dofile(path .. "/cmd_kick.lua")
dofile(path .. "/cmd_move.lua")
dofile(path .. "/cmd_status.lua")
dofile(path .. "/cmd_talk2public.lua")

--[[
   ****************************************************************
   *******        Registered Chatcommands                    ******
   ****************************************************************
--]]

local load = sc.storage:to_table()
sc.permchannel = load.fields

minetest.register_privilege("channelmod", S("Can manage Chatchannels."))
minetest.register_privilege("channeladmin", S("Can manage the entire Chat."))

minetest.register_chatcommand("c",{
    param = "<command> <parameter>",
    privs = {
		interact = true,
		shout = true
	},
    description = S("Gives Simple_Chat a command with or without Parameter.") .. "\n",
    func = function(player, cmd)
                sc.last_command = cmd
                if(cmd.type == "string") then
                    cmd = cmd:lower()
                end
                local command = sc.split(cmd)
                sc.check(player, command)

            end -- function

}) -- minetest.register_chatcommand
