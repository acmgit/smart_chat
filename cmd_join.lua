local sc = smart_chat
local S = sc.S
local cname = "join"
local short = "j"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname .. " <channel>",
                            Description = S("Join or change a channel to <channel>."),
                            Parameter = "<channel>",
                            Shortcut = "/c " .. short .. " <channel>",
                        }
                       )

sc.registered_commands[cname] = function(player, parameter)

    if(sc.join_with_priv) then
        local power = sc.is_channeluser(player)
        if(power < 5) then
            sc.print(player,sc.orange .. S("You have not the power to join channels."))
            return

        end

    end

     if(parameter[2] == nil or parameter[2] == "") then
         sc.print(player, sc.red .. S("Error: No channel to join given."))
         return
     end

    sc.report(player, S("Leaves the Channel."))
    sc.player[player] = parameter[2]
    sc.report(player, S("Enter the Channel."))

end -- sc["join"

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc["j"
