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

        for _,player in pairs(all_players) do
            local pname = player:get_player_name()
             if ((sc.player[pname] == nil) and (sc.public[name])) then                     -- player in or public is on
                lib.print(pname, line)

            end -- if((sc.player

        end -- for (_,player

        sc.send_2_irc(player, line)                                                                -- send the message to irc
        if(matterbridge) then
            sc.send_2_bridge(player, message)

        end -- if(matterbridge)

    else
        minetest.chat_send_player(player,sc.red .. S("You're already in the public channel."))

    end -- if(sc.player[player] ~= nil

end -- sc["talk2public"

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc.registered_commands[talk2public_shortcut
