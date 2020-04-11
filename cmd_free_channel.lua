local sc = smart_chat
local S = sc.S

sc.register_help({
                            Name = "free_channel",
                            Usage = "/c free_channel",
                            Description = S("Set a channel from permanent free."),
                            Parameter = "",
                            Shortcut = "/c fc",
                        }
                       )

sc["free_channel"] = function(player)
        local channel = sc.player[player]
        local privs = minetest.get_player_privs(player)

        if(not privs.channelmod) then
            sc.print(player, sc.red .. S("Error: You don't have the privileg to change channels."))
            return

        end -- if(not privs.channelmod

        if(sc.player[player] ~= nil) then
            if(sc.permchannel[channel] ~= nil) then
                sc.permchannel[channel] = nil
                sc.report(player, sc.orange .. player .. sc.green .. S(" removes the Channel [") .. sc.yellow .. channel
                          .. sc.green .. S("] from permanent."))
                sc.storage:from_table({fields=sc.permchannel})

            else
                sc.print(player, sc.red .. S("Error: Permanent Channels not found."))

            end -- if(sc.permchannel[channel]

        else
            sc.print(player, sc.red .. S("Error: You can't free the public Chat from permanent."))

        end -- if(sc.player

end -- sc["free_channel"

sc["fc"] = function(player, parameter)

        sc["free_channel"](player, parameter)

end -- sc["l"
