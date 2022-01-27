local sc = smart_chat

if (sc.irc_on) then

--[[
    -- Prepare the Connection to the IRC-Server
    -- You can found now all in the settings.
    local socket = require("socket")
    sc.host_ip = "irc.eu.libera.chat"
    sc.host_port = 6667
    sc.irc_channel = "##Zeitsprung"
    sc.servername = "MT_Zeitsprung"
    sc.irc_topic = "Minetestserver"
    sc.clienttimeout = 0.3

--]]

    minetest.register_on_shutdown(function()
        -- Close the Connection to IRC-Server and close the network
        if (sc.client ~= nil) then
            sc.client:send("QUIT" .. sc.crlf)
            sc.client:close()
            sc.client = nil

        end -- if(sc.client

    end) -- minetest.register_on_shutdown

    sc.client = assert(socket.connect(sc.host_ip, sc.host_port))                            -- connect to irc
    sc.client:settimeout(sc.clienttimeout)                                                  -- and set your own timeout

    sc.client:send("NICK " .. sc.servername .. " " .. sc.crlf)
    sc.client:send("USER ".. sc.servername .. " 0 0 " .. sc.servername .. " " .. sc.crlf)
    sc.client:send("JOIN " .. sc.irc_channel .. sc.crlf)
    sc.client:send("TOPIC :".. sc.irc_topic .. sc.crlf)

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
                    sc.receive_from_irc(line)

                end -- if(string.sub

            elseif ((err ~= nil) and (err ~= "timeout")) then
                minetest.log("action","IRC: " .. err)

            end -- if(line ~= nil

        end -- if(timer >= 0.5

    end) -- minetest.register_globalstep

end -- if(sc.irc_on ==
