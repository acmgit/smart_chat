local sc = smart_chat
local S = sc.S

-- sc.irc_on = true
sc.irc_on = minetest.settings:get_bool("smart_chat.irc_on") or false
sc.host_ip = minetest.settings:get("smart_chat.host_ip") or "localhost"
sc.host_port = tonumber(minetest.settings:get("smart_chat.host_port")) or 6667
sc.irc_channel = minetest.settings:get("smart_chat.irc_channel") or "MT_Local"
sc.irc_channel_topic = minetest.settings:get("smart_chat.irc_channel_topic") or "MT_Server_Local"
sc.servername = minetest.settings:get("smart_chat.servername") or "Local"
sc.client_timeout = tonumber(minetest.settings:get("smart_chat.client_timeout")) or 0.03
sc.irc_automatic_reconnect = minetest.settings:get_bool("smart_chat.irc_automatic_reconnect") or false
sc.irc_automatic_reconnect_max = tonumber(minetest.settings:get("smart_chat.irc_automatic_reconnect_max")) or 5
sc.irc_password = minetest.settings:get("smart_chat.password") or ""

sc.irc_running = false                                                                          -- IRC is off
sc.irc_message_count = 0
sc.irc_message = ""

if (sc.irc_on) then
--[[
    -- Prepare the Connection to the IRC-Server
    -- You can found now all in the settings.
    local socket = require("socket")
    sc.host_ip = "irc.eu.libera.chat"
    sc.host_port = 6667
    sc.irc_channel = "##Zeitsprung"
    sc.servername = "MT_Zeitsprung"
    sc.irc_channel_topic = "Minetestserver"
    sc.clienttimeout = 0.3
]]--
    --sc.client_timeout = 0.03
    local socket = require("socket")
    sc.reconnect = 0                                                                            -- counter Reconnect

    function sc.irc_connect()
        if(not sc.irc_running) then
            sc.irc_running = true
            minetest.log("action", "Try to connect to: " .. sc.host_ip .. ":" .. sc.host_port)
            local cl, err = assert(socket.connect(sc.host_ip, sc.host_port))                        -- connect to irc
            minetest.log("action", "Start connection: ", err)
            sc.client = cl

            minetest.log("action", "Set client_timeout to: " .. sc.client_timeout)
            err = sc.client:settimeout(sc.client_timeout)                                           -- and set timeout
            minetest.log("action", "Settimeout: ", err)

            minetest.log("action", "Set Nick: " .. sc.servername)
            local line = "NICK " .. sc.servername .. " " .. sc.crlf
            err = sc.client:send(line)
            minetest.log("action", line, err)

            minetest.log("action", "Set User: " .. sc.servername .. " 0 0 " .. sc.servername)
            line = "USER " .. sc.servername .. " 0 0 " .. sc.servername .. sc.crlf
            err = sc.client:send(line)
            minetest.log("action",line, err)

            minetest.log("action", "Join Channel: " .. sc.irc_channel)
            if(sc.irc_password ~= "") then
                line = "JOIN " .. sc.irc_channel .. " " .. sc.irc_password .. sc.crlf

            else
                line = "JOIN " .. sc.irc_channel .. sc.crlf

            end -- if(not sc.irc_password

            err = sc.client:send(line)
            minetest.log("action",line, err)

            minetest.log("action", "Set Channeltopic: " .. sc.irc_channel_topic)
            line = "TOPIC " .. sc.irc_channel .. " :" .. sc.irc_channel_topic .. sc.crlf
            err = sc.client:send(line)
            minetest.log("action", line, err)
        else
            sc.report("SYS", "IRC is already connected.")

        end -- if(−sc.irc_running

    end -- sc.connect

    minetest.register_on_shutdown(function()
        -- Close the Connection to IRC-Server and close the network
        if (sc.client ~= nil) then
            minetest.log("action", "Shutdown IRC.")
            sc.client:send("QUIT" .. sc.crlf)
            sc.client:close()
            sc.client = nil
            sc.irc_running = false

        end -- if(sc.client

    end) -- minetest.register_on_shutdown

    sc.irc_connect()                                                                                -- connect to IRC

    local timer = 0
    minetest.register_globalstep(function(dtime)
        timer = timer + dtime;
        if (timer >= 0.5) then
            local line, err = sc.client:receive("*l")                                           -- get line from the IRC
            if (line ~= nil) then
                if(string.sub(line,1,4) == "PING") then                                         -- Line was a Ping
                    local ping = string.sub(line,5)
                    sc.client:send("PONG" .. ping .. "\r\n")                                    -- Answer with Pong
                else
                    if(sc.check_join(line)) then                                                -- is it a Join-Report?
                        sc.report(  "IRC", "*** " .. sc.get_nick_from_irc(line)
                                    .. "@IRC" .. " " .. S("join the channel."))

                    else
                        sc.receive_from_irc(line)                                               -- a line of a user

                    end -- if(sc.check_join

                end -- if(string.sub

            elseif ((err ~= nil) and (err ~= "timeout")) then
                if(err == "closed") then                                                        -- Connection closed?
                    minetest.log("action","IRC: " .. err)
                    sc.client:close()                                                           -- Close the Connection
                    sc.irc_running = false

                    if ((sc.irc_automatic_reconnect) and (sc.reconnect < sc.irc_automatic_reconnect_max)) then
                        sc.irc_connect()
                        sc.report("IRC", "*** Disconnected")
                        sc.reconnect = sc.reconnect + 1
                    else
                        if(sc.reconnect < 1)  then
                            sc.report("IRC", "*** Disconnected")
                            sc.reconnect = sc.reconnect + 1

                        end -- if(sc.reconnect

                    end -- if(sc.automatic_reconnect

                end -- if(err == "closed"

            end -- if(line ~= nil

            timer = 0
        end -- if(timer >= 0.5

    end) -- minetest.register_globalstep

end -- if(sc.irc_on ==


function sc.check_join(line)
    local start, stop = string.find(line, "JOIN", 3)
    if(stop ~= nil) then
        return true

    else
        return false

    end -- if(stop ~= nil

end -- sc.check_join()
