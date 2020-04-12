local sc = smart_chat
local S = sc.S

sc.register_help({
                            Name = "move",
                            Usage = "/c move <player> <channel>",
                            Description = S("Moves a player to <channel> or to self."),
                            Parameter = "<player> <channel>",
                            Shortcut = "/c m <player> <channel>",
                        }
                       )

sc["move"] = function(player, parameter)

    local power = sc.is_channelmod(player) + sc.is_channeladmin(player)

    -- has the user channelmod
    if(power < 10) then
        sc.print(player, sc.red ..
                 S("Error: You don't have the privileg chanelmod or channeladmin to move players from channels.")
                )
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

    if(player == guest) then
       sc.print(player, sc.red .. S("Error: Use the command /c j <channel> to move yourself into another channel."))
       return

    end

    local old_channel = sc.player[guest]
    local new_channel = parameter[3]

    if(new_channel == nil or new_channel == "") then -- No channel given, so set the
        new_channel = sc.player[player] -- own channel

    end


    if(old_channel == new_channel) then
        sc.print(player, sc.red .. S("Error: The player is already in your channel."))
        return

    end

    sc.player[guest] = new_channel

    sc.channel_report(old_channel,  sc.green .. "*** " .. sc.orange .. guest ..
                                    sc.green .. S(" was moved from the channel. ***")
                     )

    sc.channel_report(new_channel,  sc.green .. "*** " .. sc.orange .. guest ..
                                    sc.green .. S(" was moved into the channel by ") ..
                                    sc.yellow .. player .. sc.green .. ". ***"
                     )

    if(new_channel == nil) then
        new_channel = "the public chat."

    else
        new_channel = "the channel " .. new_channel

    end

    minetest.log("chat", "*** " .. player .. " moves " .. guest .. " into the channel " .. new_channel .. ". ***")

end -- sc["join"

sc["m"] = function(player, parameter)

        sc["move"](player, parameter)

end -- sc["j"
