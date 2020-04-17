local sc = smart_chat
local S = sc.S
local cname = "free_channel"
local short = "fc"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname,
                            Description = S("Set a channel from permanent free."),
                            Parameter = "",
                            Shortcut = "/c " .. short,
                        }
                       )

sc[cname] = function(player)
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

sc[short] = function(player, parameter)

        sc[cname](player, parameter)

end -- sc["l"
