local sc = smart_chat
local S = sc.S

sc.register_help({
                            Name = "leave",
                            Usage = "/c leave",
                            Description = S("Leaves a channel"),
                            Parameter = "",
                            Shortcut = "/c l",
                        }
                       )

sc["leave"] = function(player)
    if(sc.player[player] ~= nil) then
        sc.report(player, S("Leaves the Channel."))
        sc.player[player] = nil
        sc.public[player] = nil -- Turns the public Chat off (Echo)
        sc.report(player, S("Enter the public Chat."))
    else
        sc.print(player, sc.red .. S("Error: You're already in the public chat."))

    end -- if(sc.player[player]

end -- sc["leave"

sc["l"] = function(player, parameter)

        sc["leave"](player, parameter)

end -- sc["l"
