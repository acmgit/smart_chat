local sc = smart_chat
local S = sc.S
local cname = "store_channel"
local short = "sc"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname,
                            Description = S("Marks a channel permanent."),
                            Parameter = "",
                            Shortcut = "/c " .. short,
                        }
                       )

sc.registered_commands[cname] = function(player)
        local channel = sc.player[player]
        local privs = minetest.get_player_privs(player)

        if(not privs.channelmod) then
            sc.print(player, sc.red .. S("Error: You don't have the privileg to change channels."))
            return

        end -- if(not privs.channelmod

        if(sc.player[player] ~= nil) then
            if (sc.is_channel_permanent(channel)) then     -- Channel exist
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

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc["l"
