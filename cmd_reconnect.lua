local sc = smart_chat
local S = sc.S
local cname = "reconnect"
local short = "rc"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname,
                            Description = S("Starts the counter for automatic reconnect."),
                            Parameter = "<>",
                            Shortcut = "/c " .. short,
                        }
                       )

sc.registered_commands[cname] = function(player)

    if(sc.is_channelmod(player) < 10) then
        sc.print(player, sc.red .. S("Error: You are not a channelmod."))
        return

    end -- if(not privs.channelmod

    if(sc.irc_on) then
        sc.print(player, sc.red .. S("IRC is already connected."))
        return

    end -- if(sc.irc_on

    if(sc.automatic_reconnect) then
        if (sc.reconnect > sc.reconnect_max) then
            sc.reconnect = 0
            sc.print(player, sc.green .. S("Automatic reconnect started."))

        end -- if(sc.reconnect
    else
        sc.irc_connect()
        sc.print(player, sc.green .. S("New connect to irc started."))

    end -- if(sc.automatic_reconnect

end -- sc[template

sc.registered_commands[short] = function(player)

        sc.registered_commands[cname](player)

end -- sc.registered_commands[template_shortcut
