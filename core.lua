local sc = smart_chat
sc.crlf = "\r\n"

minetest.register_on_chat_message(function(player, message)

        if(player ~= "" or player ~= nil) then

            --local playername = minetest.get_player_by_name(player)
            return sc.chat(player, message)


        else

            return false -- Systemmessage, no processing for us.

        end -- if(player ~=

end) -- register_on_chatmessage()


minetest.register_on_joinplayer(function(player)

        local playername = player:get_player_name()
        sc.player[playername] = nil -- the public Chat
        sc.public[playername] = nil

        if(sc.irc_running) then
            local line = "PRIVMSG " .. sc.irc_channel
                        .. ":*** " .. playername .. "@" .. sc.servername .. " join the world." .. sc.crlf
            sc.client:send(line)
            print("Sendet:" .. line)

        end -- if(sc.irc_running

end) -- register_on_joinplayer()

minetest.register_on_leaveplayer(function(player)
        local playername = player:get_player_name()
        sc.player[playername] = nil
        sc.public[playername] = nil
        if(sc.irc_running) then
            local line = "PRIVMSG " .. sc.irc_channel
                            .. ":" .. playername .. "@" .. sc.servername .. " leave the World. ***" .. sc.crlf
            sc.client:send(line)
            print("Sendet:" .. line)

        end -- if(sc.irc_running

end) -- minetest.register_on_leaveplayer

