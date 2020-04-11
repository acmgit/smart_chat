local sc = smart_chat
local S = sc.S

sc.register_help({
                            Name = "all",
                            Usage = "/c all <message>",
                            Description = S("Send's a message on all."),
                            Parameter = "<message>",
                            Shortcut = "/c a <message>",
                        }
                       )

sc["all"] = function(player, parameter)

    local pprivs = minetest.get_player_privs(player)

    if not pprivs.basic_privs then
		minetest.chat_send_player(player,sc.red .. S("Error - require 'basic_privs' privilege."))
		return
	end

    if(parameter[2] == nil or parameter[2] == "") then
        sc.print(player, sc.red .. S("Error: No Message given."))
        return
    end
    local message = ""

    for i = 2, #parameter, 1 do
        message = message .. " " .. parameter[i]

    end

    local channel = sc.player[player]

    if(sc.player[player] ~= nil) then
        minetest.chat_send_all(sc.yellow .. "[" .. sc.yellow .. player .. "@" .. channel
                               .. sc.yellow .. "] " .. sc.green .. message)

    else
        minetest.chat_send_all(sc.yellow .. "[" .. sc.yellow .. player
                               .. sc.yellow .. "] " .. sc.green .. message)

    end

end -- sc["all"


sc["a"] = function(player, parameter)

        sc["all"](player, parameter)

end -- sc["a"
