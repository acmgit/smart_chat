local sc = smart_chat
local S = sc.S

sc.register_help({
                            Name = "store_channel",
                            Usage = "/c store_channel",
                            Description = S("Marks a channel permanent."),
                            Parameter = "",
                            Shortcut = "/c sc",
                        }
                       )

sc["store_channel"] = function(player)
        local channel = sc.player[player]
        local privs = minetest.get_player_privs(player)

        if(not privs.channelmod) then
            sc.print(player, sc.red .. S("Error: You don't have the privileg to change channels."))
            return

        end -- if(not privs.channelmod

        if(sc.player[player] ~= nil) then
            if((sc.permchannel ~= nil) and (sc.permchannel[channel] ~= nil) ) then     -- Channel exist
                sc.print(player, sc.red .. S("Error: Permanent Channels exist."))

            else
                sc.permchannel[channel] = channel
                sc.report(player, sc.orange .. player .. sc.green .. S(" marks the Channel [") .. sc.yellow .. channel
                          .. sc.green .. S("] as permanent."))
                sc.storage:from_table({fields=sc.permchannel})

            end -- if(sc.permchannel[channel]

        else
            sc.print(player, sc.red .. S("Error: You can't set the public Chat as permanent."))

        end -- if(sc.player

end -- sc["store_channel"

sc["sc"] = function(player, parameter)

        sc["store_channel"](player, parameter)

end -- sc["l"
