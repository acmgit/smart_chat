local sc = smart_chat
local S = sc.S

sc.register_help({
                            Name = "where",
                            Usage = "/c where <name>",
                            Description = S("Show's the room, where <name> is."),
                            Parameter = "<>",
                            Shortcut = "/c w <name>",
                        }
                       )

sc["where"] = function(player, parameter)



    if(parameter[2] == "" or parameter[2] == nil) then
        sc.print(sc.red .. S("Error: No name given."))

    else
        local pname = parameter[2]
        local channel = sc.player[pname]

        if(minetest.get_player_by_name(pname)) then
            local room = sc.player[pname]
            if(room ~= nil) then
                sc.print(player, sc.green .. S("Player [") .. sc.orange .. pname
                         .. sc.green .. S(" is in Channel {")
                        .. sc.yellow .. channel .. sc.green .. "}.")

            else
                sc.print(player, sc.green .. S("Player [") .. sc.orange .. pname
                         .. sc.green .. S("] is in the public Chat."))

            end -- if(room ~= nil)

        else -- if(minetest.get_player_by_name
            sc.print(player, sc.red .. S("Error: Player is not online."))

        end -- if(minetest.get_player_by_name

    end -- if(paramter[2]

end -- sc["where"

sc["w"] = function(player, parameter)

        sc["where"](player, parameter)

end -- sc["w"
