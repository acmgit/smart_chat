local sc = smart_chat
local S = sc.S
local cname = "list"
local short = "li"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname .. " <name>",
                            Description = S("Lists all player in the channel."),
                            Parameter = "<>",
                            Shortcut = "/c " .. short .. " <name>",
                        }
                       )

sc.registered_commands[cname] = function(player, parameter)

    local channel = sc.player[player]
    local all_player = minetest.get_connected_players()


    if(parameter[2] == "" or parameter[2] == nil) then
        sc.print(player, sc.green .. S("Player in Channel") .. ":")
        for _,players in pairs(all_player) do
            local pname = players:get_player_name()

            if(sc.check_channel(pname, channel)) then
                sc.print(player, sc.orange .. pname)

            end -- if(sc.check_channel

        end -- for_,players

    else
        local channelname = parameter[2]
        sc.print(player, sc.green .. S("Player in Channel") .. " [" .. sc.orange .. channelname .. sc.green .. "]:")
        for _,players in pairs(all_player) do
            local pname = players:get_player_name()

            if(sc.check_channel(pname, channelname)) then
                sc.print(player, sc.orange .. pname)

            end -- if(sc.check_channel

        end -- for _,players

    end -- if(paramter[2]

end -- sc["list"

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc["l"
