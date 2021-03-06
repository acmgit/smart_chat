local sc = smart_chat
local S = sc.S
local cname = "invite"
local short = "i"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname .. " <player>",
                            Description = S("Invites a <player> to your Channel."),
                            Parameter = "<player>",
                            Shortcut = "/c " .. short .. " <player>",
                        }
                       )

sc.registered_commands[cname] = function(player, parameter)

    if(parameter[2] == nil or parameter[2] == "") then
        sc.print(player, sc.red .. S("Error: No playername given."))
        return
    end

    local guest = parameter[2]
    local channel = sc.player[player]

    if(channel == nil) then
        sc.print(player, sc.red .. S("Error: You can not invite a player in the public chat."))
        return
    end

    if(minetest.get_player_by_name(guest)) then
        minetest.chat_send_player(guest, sc.yellow .. "[" .. sc.yellow .. player .. "@" .. channel .. sc.yellow .. "] "
                                  .. sc.green .. S("Invites you in the channel: ") .. sc.orange .. channel .. ". "
                                  .. sc.green .. S("Enter /c j ") .. sc.green .. channel .. S(" to join the Channel.")
                                 )
        sc.report(player,sc.green .. player .. S(" invites ") .. sc.orange .. guest
                  .. sc.green .. S(" to join the Channel."))

    else
        sc.print(player, sc.red .. S("Error: No Player with the name found."))

    end

end -- sc["invite"

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc["i"
