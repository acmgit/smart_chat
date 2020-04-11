local sc = smart_chat
local S = sc.S

sc.register_help({
                            Name = "join",
                            Usage = "/c join <channel>",
                            Description = S("Join or change a channel to <channel>."),
                            Parameter = "<channel>",
                            Shortcut = "/c j <channel>",
                        }
                       )

sc["join"] = function(player, parameter)

     if(parameter[2] == nil or parameter[2] == "") then
         sc.print(player, sc.red .. S("Error: No channel to join given."))
         return
     end

    sc.report(player, S("Leaves the Channel."))
    sc.player[player] = parameter[2]
    sc.report(player, S("Enter the Channel."))

end -- sc["join"

sc["j"] = function(player, parameter)

        sc["join"](player, parameter)

end -- sc["j"
