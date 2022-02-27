local sc = smart_chat
local S = sc.S
local cname = "talk2public"
local short = "tp"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname .. " <message>",
                            Description = S("Send's a message to the public channel."),
                            Parameter = "<message>",
                            Shortcut = "/c " .. short .. " <message>",
                        }
                       )

local all_send_to_irc = function (message)
    local line = "PRIVMSG " .. sc.irc_channel .. " :" .. message .. sc.crlf

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

	end -- if not privs.basic_privs

    local message = ""
    local command = sc.last_command -- Get the last complete command
    local pos = command:find(" ") -- Where is the Command
    if pos then -- is there a Parameter
        message = command:sub(pos + 1)

    end -- if pos

    local channel = sc.player[player]

    if(sc.player[player] ~= nil) then
        local all_players = minetest.get_connected_players()
        local line = sc.yellow .. "[" .. sc.yellow .. player .. "@" .. channel
                               .. sc.yellow .. "] " .. sc.green .. message

        for _,players in pairs(all_players) do
            local pname = players:get_player_name()
             if ((sc.player[pname] == nil) or (sc.public[pname])) then                     -- player in or public is on
                sc.print(pname, line)

            end -- if((sc.player

        end -- for (_,player

        sc.chat(player, sc.green .. message)                                               -- send to own channel
        line = "[" .. player .. "@" .. sc.servername .. "]" .. message
        if(sc.irc_on) then
            all_send_to_irc(line)
            minetest.log("action", "[MOD] .. " .. sc.modname .. " : Module cmd_talk2public : " .. line)

        end

        if(sc.matterbridge) then
            all_send_to_bridge(player, line)
            minetest.log("action", "[MOD] .. " .. sc.modname .. " : Module cmd_talk2public : [Matterbridge] " .. line)

        end -- if(matterbridge)

    else
        minetest.chat_send_player(player,sc.red .. S("You're already in the public channel."))

    end -- if(sc.player[player] ~= nil

end -- sc["talk2public"

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc.registered_commands[talk2public_shortcut
