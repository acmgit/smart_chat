local sc = smart_chat
local S = sc.S

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
        local message = "joins the World."
        playername = playername or S("unknown")

        sc.send_2_irc(playername, "*** " ..message)
        sc.player[playername] = nil -- the public Chat
        sc.public[playername] = nil
        minetest.log("action", "[MOD] " .. sc.modname .. " : Module core: *** " .. message)
end) -- register_on_joinplayer()

minetest.register_on_leaveplayer(function(player)
        local playername = player:get_player_name() or S("unknown")
        local line = "leaves the World."

        sc.player[playername] = nil
        sc.public[playername] = nil
        sc.send_2_irc(playername, "*** " .. line .. ".")
        minetest.log("action", "[MOD] " .. sc.modname .. " : Module core: *** " .. line)
end) -- minetest.register_on_leaveplayer

minetest.override_chatcommand("me", {

privs = {},
func = function(name, param)
            sc.me(name, param)
            return true
        end

})
