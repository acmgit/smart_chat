local sc = smart_chat
local S = sc.S

sc.crlf = "\r\n"

-- Function forwarding
sc.send_2_irc = function() return end
sc.send_2_matterbridge = function() return end

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
        local message = "*** joins the World."
        local line = "*** <" .. playername .. "@" .. sc.servername .. "> " .. message
        playername = playername or S("unknown")

        sc.send_2_irc(playername, line)
        sc.player[playername] = nil -- the public Chat
        sc.public[playername] = nil
        if(sc.matterbridge) then
            sc.send_2_matterbridge(playername, message)

        end -- if(sc.matterbridge

        minetest.log("action", "[MOD] " .. sc.modname .. " : Module core: <" .. playername
                                        .. "@" .. sc.servername .. "> *** joins the World)")

end) -- register_on_joinplayer()

minetest.register_on_leaveplayer(function(player)
        local playername = player:get_player_name() or S("unknown")
        local line = "*** <" .. playername .. "@" .. sc.modname .. "> leaves the World."

        sc.player[playername] = nil
        sc.public[playername] = nil
        sc.send_2_irc(playername, line)
        if(sc.matterbridge) then
            sc.send_2_matterbridge(playername, "*** leaves the World.")

        end -- if(sc.matterbridge

        minetest.log("action", "[MOD] " .. sc.modname .. " : Module core: <" .. playername
                                        .. "@" .. sc.servername .. "> *** leaves the World)")
end) -- minetest.register_on_leaveplayer
