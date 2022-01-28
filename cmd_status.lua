local sc = smart_chat
local S = sc.S
local cname = "status"
local short = "st"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname,
                            Description = S("Writes Information about the Chat."),
                            Parameter = "<>",
                            Shortcut = "/c " .. short,
                        }
                       )
local function say(player, line)
    sc.print(player, sc.green .. line)
end

sc.registered_commands[cname] = function(player, parameter)

    local line
    line = "*** Smart_Chat V " .. sc.yellow .. sc.version .. "." .. sc.revision .. sc.green .." ***"
    say(player, line)

    line = S("IRC-Chat") .. " = "
    if (sc.irc_running) then
        line = line .. sc.yellow .. "on"
        say(player, line)
        line = S("IRC-Server") .. ": " .. sc.yellow .. sc.host_ip .. ":" .. sc.host_port
        say(player, line)
        line = S("IRC-Channel") .. ": " .. sc.yellow .. sc.irc_channel .. " "
                                .. sc.green .. S("Topic") .. ": " .. sc.yellow .. sc.irc_channel_topic
        say(player,line)
        line = S("Worldname/Servername") .. ": " .. sc.yellow .. sc.servername
        say(player,line)
        line = S("Automatic reconnect") .. ": "
        if(sc.irc_automatic_reconnect) then
            line = line .. sc.yellow .. "on " .. sc.green .. S("Tries") .. ": " .. sc.yellow .. sc.irc_reconnect
                        .. sc.green .. " " .. S("max.") .. " " .. sc.yellow .. sc.irc_automatic_reconnect_max
            say(player,line)
        else
            line = line .. sc.yellow .. "off"
            say(player, line)

        end -- if(automatic_reconnect

    else
        line = line .. sc.yellow .. "off"
        say(player, line)

    end -- if(sc.irc_running

end -- sc[template

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc.registered_commands[template_shortcut
