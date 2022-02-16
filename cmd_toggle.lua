local sc = smart_chat
local S = sc.S
local cname = "toggle"
local short = "t"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname,
                            Description = S("Turns the permanent public Chat on or off."),
                            Parameter = "<>",
                            Shortcut = "/c " .. short,
                        }
                       )

sc.registered_commands[cname] = function(player)

    local status = sc.public[player]

    if(status == nil) then
        if(sc.player[player] ~= nil) then
            sc.public[player] = player
            minetest.chat_send_player(player, sc.green .. S("The permanent public chat is now on."))
        else
            minetest.chat_send_player(player, sc.orange .. S("You are already in the public Chat."))

        end

    else
        sc.public[player] = nil
        minetest.chat_send_player(player, sc.orange .. S("The permanent public chat is now off."))

    end


end -- sc["toggle"

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc["t"
