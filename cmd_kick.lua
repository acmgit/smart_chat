local sc = smart_chat
local S = sc.S
local cname = "kick"
local short = "k"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname .. " <player>",
                            Description = S("Kicks a player from the channel."),
                            Parameter = "<player>",
                            Shortcut = "/c " .. short .. " <player>",
                        }
                       )

sc.registered_commands[cname] = function(player, parameter)

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

    local troublemaker = parameter[2]

    if(minetest.get_player_by_name(troublemaker) == nil) then
       sc.print(player, sc.red .. S("Error: Player ") .. sc.orange .. troublemaker .. sc.red .. S(" not found."))
       return

    end -- if(minetest.get_player_by_name

    if(sc.player[troublemaker] == nil) then
        sc.print(player, sc.red .. S("Error: You can't kick a player from the public chat."))
        return

    end -- if(sc.player[troublemaker]

    local troublemakerpower = sc.is_channelmod(troublemaker) + sc.is_channeladmin(troublemaker)

    if(power > troublemakerpower) then
        local channel = sc.player[troublemaker]
        sc.channel_report(channel,  sc.red .. "*** " .. sc.yellow .. troublemaker ..
                                    sc.red .. S(" was kicked by ") .. sc.green .. player ..
                                    sc.red .. S(" from the channel ") .. sc.orange .. channel ..
                                    sc.red .. ". ***"
                        )

        sc.print(player,
                    sc.green .. S("*** You kicked ") .. sc.yellow .. troublemaker ..
                    sc.green .. S(" from channel: ") .. sc.orange .. channel ..
                    sc.green .. " . ****"
                )

        sc.print(troublemaker,
                    sc.red .. S("*** You were kicked by ") .. sc.yellow .. player ..
                    sc.red .. S(" from the channel.") .. " ****"
                )

        minetest.log("chat", " *** " .. player .. " kicked " .. troublemaker .. " from channel: " .. channel .. ". ***")

        sc.registered_commands["l"](troublemaker)
    elseif(power < sc.channelmod) and (troublemakerpower < sc.channelmod) then
        sc.print(player, sc.red .. S("Error: you can't kick a channelowner from the channel."))
        
    elseif(power < sc.admin) and (troublemakerpower < sc.admin) then
        sc.print(player, sc.red .. S("Error: You can not kick a channelmod from the channel."))

    else
        sc.print(player, sc.red .. S("Error: You can't kick a channeladmin from the channel."))

    end -- if(power > troublemakerpower)

end -- sc["kick"

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc["j"
