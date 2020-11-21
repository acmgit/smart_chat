local sc = smart_chat
local S = sc.S
local cname = "leave"
local short = "l"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname,
                            Description = S("Leaves a channel"),
                            Parameter = "",
                            Shortcut = "/c " .. short,
                        }
                       )

sc.registered_commands[cname] = function(player)
    if(sc.player[player] ~= nil) then
        sc.report(player, S("Leaves the Channel."))
        sc.player[player] = nil
        sc.public[player] = nil -- Turns the public Chat off (Echo)
        sc.report(player, S("Enter the public Chat."))
    else
        sc.print(player, sc.red .. S("Error: You're already in the public chat."))

    end -- if(sc.player[player]

end -- sc["leave"

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc["l"
