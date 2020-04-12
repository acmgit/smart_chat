local sc = smart_chat
local S = sc.S

sc.register_help({
                            Name = "kick",
                            Usage = "/c kick <player>",
                            Description = S("Kicks a player from the channel."),
                            Parameter = "<player>",
                            Shortcut = "/c k <player>",
                        }
                       )

sc["kick"] = function(player, parameter)

    local power = sc.is_channelmod(player) + sc.is_channeladmin(player)

    -- has the user channelmod
    if(power < 10) then
        sc.print(player, sc.red..
                 S("Error: You don't have the privileg chanelmod or channeladmin to kick players from channels."))
        return

    end -- if(not privs.channelmod

    if(parameter[2] == nil or parameter[2] == "") then
        sc.print(player, sc.red .. S("Error: No playername given."))
        return

    end -- if(parameter[2] == nil

    local guest = parameter[2]

    if(minetest.get_player_by_name(guest) == nil) then
       sc.print(player, sc.red .. S("Error: Player ") .. sc.orange .. guest .. sc.red .. S(" not found."))
       return

    end -- if(minetest.get_player_by_name

    if(sc.player[guest] == nil) then
        sc.print(player, sc.red .. S("Error: You can't kick a player from the public chat."))
        return

    end -- if(sc.player[guest]

    local guestpower = sc.is_channelmod(guest) + sc.is_channeladmin(guest)

    if(power > guestpower) then
        local channel = sc.player[guest]
        sc.channel_report(channel,  sc.red .. "*** " .. sc.yellow .. guest ..
                                    sc.red .. S(" was kicked by ") .. sc.green .. player ..
                                    sc.red .. S(" from the channel ") .. sc.orange .. channel ..
                                    sc.red .. ". ***"
                        )

        sc.print(player,
                    sc.green .. S("*** You kicked ") .. sc.yellow .. guest ..
                    sc.green .. S(" from channel: ") .. sc.orange .. channel ..
                    sc.green .. " . ****"
                )

        sc.print(guest,
                    sc.red .. S("*** You were kicked by ") .. sc.yellow .. player ..
                    sc.red .. S(" from the channel.") .. " ****"
                )

        minetest.log("chat", " *** " .. player .. " kicked " .. guest .. " from channel: " .. channel .. ". ***")

        sc["l"](guest)

    elseif(power < 20) and (guestpower < 20) then
        sc.print(player, sc.red .. S("Error: You can not kick a channelmod from the channel."))

    else
        sc.print(player, sc.red .. S("Error: You can't kick a channeladmin from the channel."))

    end -- if(power > guestpower)

end -- sc["join"

sc["k"] = function(player, parameter)

        sc["kick"](player, parameter)

end -- sc["j"
