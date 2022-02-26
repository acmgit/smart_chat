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

sc.registered_commands[cname] = function(player, parameter)

    local pprivs = minetest.get_player_privs(player)
    if not pprivs.basic_privs then
		minetest.chat_send_player(player,sc.red .. S("Error - require 'basic_privs' privilege."))
		return
	end


    if(parameter[2] == nil or parameter[2] == "") then
        sc.print(player, sc.red .. S("Error: No Message given."))
        return
    end

    local message = ""
    local command = sc.last_command -- Get the last complete command
    local pos = command:find(" ") -- Where is the Command
    if pos then -- is there a Parameter
        message = command:sub(pos + 1)
    end

    local channel = sc.player[player]

    if(sc.player[player] ~= nil) then                                                      -- Player is in a channel.
        local line = sc.yellow .. "[" .. sc.yellow .. player .. "@" .. channel
                               .. sc.yellow .. "] " .. sc.green .. message

        minetest.chat_send_all(line)
        line = "[" .. player .. "@" .. channel .. "] " .. message
        sc.send_2_irc(player, line)
        if(sc.matterbridge) then
            yl_matterbridge.send_to_bridge(player, line)

        end -- if(sc.matterbridge

    else
        local line = sc.yellow .. "[" .. sc.yellow .. player
                               .. sc.yellow .. "] " .. sc.green .. message
        minetest.chat_send_all(line)
        line = "[" .. player .. "@" .. channel .. "] " .. message
        sc.send_2_irc(player, line)
        if(sc.matterbridge) then
            sc.send_2_bridge(player, line)

        end -- if(matterbridge

    end -- if(sc.player[

end -- sc["all"


sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc["a"
