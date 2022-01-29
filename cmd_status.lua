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

    local hip = sc.hostip or ""
    local hpo = sc.host_port or 0
    local ct = sc.client_timeout or 0
    local ic = sc.irc_channel or ""
    local it = sc.irc_channel_topic or ""
    local rc = sc.reconnect or 0
    local rc_max = sc.irc_automatic_reconnect_max or 0
    local sn = sc.servername or S("No name given") .. "."

    line = "*** Smart_Chat V " .. sc.yellow .. sc.version .. "." .. sc.revision .. sc.green .." ***"
    say(player, line)

    line = S("IRC-Chat") .. " = "
    if (sc.irc_running) then
        line = line .. sc.yellow .. "on"
        say(player, line)
        line = S("IRC-Server") .. ": " .. sc.yellow .. hip .. ":" .. hpo
        say(player, line)
        line = S("Client-Timeout") .. ": " .. sc.yellow .. ct .. sc.green .. " " .. S("Seconds")
        say(player, line)
        line = S("IRC-Channel") .. ": " .. sc.yellow .. ic .. " "
                                .. sc.green .. S("Topic") .. ": " .. sc.yellow .. it
        say(player,line)
        line = S("Worldname/Servername") .. ": " .. sc.yellow .. sn
        say(player,line)
        line = S("Automatic reconnect") .. ": "
        if(sc.irc_automatic_reconnect) then
            line = line .. sc.yellow .. "on " .. sc.green .. S("Tries") .. ": " .. sc.yellow .. rc
                        .. sc.green .. " " .. S("max.") .. " " .. sc.yellow .. rc_max
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
