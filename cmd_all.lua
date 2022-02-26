local sc = smart_chat
local S = sc.S
local cname = "all"
local short = "a"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname .. " <message>",
                            Description = S("Send's a message on all."),
                            Parameter = "<message>",
                            Shortcut = "/c " .. short .. " <message>",
                        }
                       )

local all_send_to_irc = function (message)
    local line = "PRIVMSG " .. sc.irc_channel .. " " .. message .. sc.crlf

    sc.client:send(line)
    sc.irc_message_count = 1   -- This prevents for IRC-Echos of multiple player
    sc.irc_message = line      -- and remembers the last message

end -- function

local all_send_to_bridge = function (player, message)
    --local line = "<" .. player .. "@" .. sc.servername .. "> " .. message
    yl_matterbridge.send_to_bridge(player, message)

end -- function

sc.registered_commands[cname] = function(player, parameter)

    local pprivs = minetest.get_player_privs(player)
    if not pprivs.basic_privs then
		minetest.chat_send_player(player,sc.red .. S("Error - require 'basic_privs' privilege."))
		return

	end -- if not pprivs


    if(parameter[2] == nil or parameter[2] == "") then
        sc.print(player, sc.red .. S("Error: No Message given."))
        return

    end -- if(parameter

    local message = ""
    local command = sc.last_command -- Get the last complete command
    local pos = command:find(" ") -- Where is the Command
    if pos then -- is there a Parameter
        message = command:sub(pos + 1)

    end -- if pos


    if(sc.player[player] ~= nil) then                                                      -- Player is in a channel.
        local channel = sc.player[player]
        local line = sc.yellow .. "[" .. sc.yellow .. player .. "@" .. channel
                               .. sc.yellow .. "] " .. sc.green .. message

        minetest.chat_send_all(line)

        line = " [" .. player .. "@" .. sc.servername .. "] " .. message
        if(sc.irc_on) then
            all_send_to_irc(line)
            minetest.log("action", line)

        end -- if(sc.irc_on)

        if(sc.matterbridge) then
            all_send_to_bridge(player, line)
            minetest.log("action", "[Matterbridge] " .. line)

        end -- if(sc.matterbridge

    else
        local line = sc.yellow .. "[" .. sc.yellow .. player
                               .. sc.yellow .. "] " .. sc.green .. message
        minetest.chat_send_all(line)

        line = " [" .. player .. "@" .. sc.servername .. "] " .. message
        if(sc.irc_on) then
            all_send_to_irc(line)
            minetest.log("action", line)

        end -- if(sc.irc_on)

        if(sc.matterbridge) then
            all_send_to_bridge(player, line)
            minetest.log("action", "[Matterbridge] " .. line)

        end -- if(matterbridge

    end -- if(sc.player[

end -- sc["all"


sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc["a"
