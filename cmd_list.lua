local sc = smart_chat
local S = sc.S

sc.register_help({
                            Name = "list",
                            Usage = "/c list <name>",
                            Description = S("Lists all player in the channel."),
                            Parameter = "<>",
                            Shortcut = "/c li <name>",
                        }
                       )

sc["list"] = function(player, parameter)

    local channel = sc.player[player]
    local all_player = minetest.get_connected_players()


    if(parameter[2] == "" or parameter[2] == nil) then
        sc.print(player, sc.green .. "Player in Channel:")
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

sc["li"] = function(player, parameter)

        sc["list"](player, parameter)

end -- sc["l"
