local sc = smart_chat
local S = sc.S

sc.register_help({
                            Name = "toggle",
                            Usage = "/c toggle",
                            Description = S("Turn's the permanent public Chat on or off."),
                            Parameter = "<>",
                            Shortcut = "/c t",
                        }
                       )

sc["toggle"] = function(player)

    local status = sc.public[player]

    if(status == nil) then
        if(sc.player[player] ~= nil) then
            sc.public[player] = player
            minetest.chat_send_player(player, sc.green .. S("The permanent public chat is now on."))
        else
            minetest.chat_send_player(player, sc.orange .. S("You are already in the public Chat."))
            
        end

    else
        sc.public[player] = nil
        minetest.chat_send_player(player, sc.orange .. S("The permanent public chat is now off."))

    end


end -- sc["toggle"

sc["t"] = function(player, parameter)

        sc["toggle"](player, parameter)

end -- sc["t"
