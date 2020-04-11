local sc = smart_chat
local S = sc.S

sc.register_help({
                            Name = "channels",
                            Usage = "/c channels",
                            Description = S("Lists all channels on the Server."),
                            Parameter = "<>",
                            Shortcut = "/c c"
                        }
                       )

sc["channels"] = function(player)

    local list = {}
    local all_player = minetest.get_connected_players()

    sc.print(player, sc.green .. S("Channels on Server:"))

    for _,players in pairs(all_player) do
        local pname = players:get_player_name()
        if(sc.player[pname] ~= nil) then
            list[sc.player[pname]] = sc.player[pname]

        end -- if(sc.player[pname] ~= nil

    end -- for_,players

    for _,entry in pairs(list) do
        sc.print(player, sc.orange .. entry)

    end

end -- sc["list"

sc["c"] = function(player, parameter)

        sc["channels"](player, parameter)

end -- sc["l"
