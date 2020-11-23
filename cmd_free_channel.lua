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

sc.registered_commands[cname] = function(player)
        local channel = sc.player[player]
        local power = sc.is_channelmoderator(player) + sc.is_channeladmin(player)

        if(power < sc.channelmod) then
            sc.print(player, sc.red .. S("Error: You don't have the privileg to change channels."))
            return

        end -- if(power < sc.channelmod

        if(sc.player[player] ~= nil) then
            if(sc.is_channel_permanent(channel)) then
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

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc["l"
