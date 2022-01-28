local sc = smart_chat
local S = sc.S

-- sc.irc_on = true
sc.irc_on = minetest.settings:get("smart_chat.irc_on") or false
sc.host_ip = minetest.settings:get("smart_chat.host_ip")
sc.host_port = tonumber(minetest.settings:get("smart_chat.host_port"))
sc.irc_channel = minetest.settings:get("smart_chat.irc_channel")
sc.irc_channel_topic = minetest.settings:get("smart_chat.irc_channel_topic")
sc.automatic_reconnect = minetest.settings:get("smart_chat.automatic_reconnect") or true
sc.servername = minetest.settings:get("smart_chat.servername", "")

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
    sc.client_timeout = 0.03
    local socket = require("socket")

    function sc.connect()

        minetest.log("action", "Try to connect to: " .. sc.host_ip .. ":" .. sc.host_port)
        local cl, err = assert(socket.connect(sc.host_ip, sc.host_port))                        -- connect to irc
        minetest.log("action", "Start connection: ", err)
        sc.client = cl

        err = sc.client:settimeout(sc.client_timeout)                                       -- and set timeout
        minetest.log("action", "Settimeout: ", err)

        local line = "NICK " .. sc.servername .. " " .. sc.crlf
        err = sc.client:send(line)
        minetest.log("action", line, err)

        line = "USER " .. sc.servername .. " 0 0 " .. sc.servername .. sc.crlf
        err = sc.client:send(line)
        minetest.log("action",line, err)

        line = "JOIN " .. sc.irc_channel .. sc.crlf
        err = sc.client:send(line)
        minetest.log("action",line, err)

        line = "TOPIC " .. sc.irc_channel .. " " .. sc.irc_channel_topic .. sc.crlf
        err = sc.client:send(line)
        minetest.log("action", line, err)

    end -- sc.connect

    minetest.register_on_shutdown(function()
        -- Close the Connection to IRC-Server and close the network
        if (sc.client ~= nil) then
            minetest.log("action", "Shutdown IRC.")
            sc.client:send("QUIT" .. sc.crlf)
            sc.client:close()
            sc.client = nil

        end -- if(sc.client

    end) -- minetest.register_on_shutdown

    sc.connect()                                                                            -- connect to IRC

    local timer = 0
    minetest.register_globalstep(function(dtime)
        timer = timer + dtime;
        if (timer >= 0.5) then
            local line, err = sc.client:receive("*l")                                       -- get a line from the IRC
            if (line ~= nil) then
                if(string.sub(line,1,4) == "PING") then                                     -- Line was a Ping
                    local ping = string.sub(line,5)
                    sc.client:send("PONG" .. ping .. "\r\n")                                -- Answer with Pong

                else
                    if(sc.check_join(line)) then                                             -- is it a Join-Report?
                        sc.report("IRC", "*** " .. sc.get_nick_from_irc(line)
                                                .. "@IRC" .. " " .. S("join the channel."))

                    else
                        sc.receive_from_irc(line)                                           -- a line of a user

                    end -- if(sc.check_join

                end -- if(string.sub

            elseif ((err ~= nil) and (err ~= "timeout")) then
                minetest.log("action","IRC: " .. err)
                if(sc.automatic_reconnect) then
                    sc.connect()

                end -- if(sc.automatic_reconnect

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
