local sc = smart_chat
local S = sc.S
local cname = "where"
local short = "w"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname .. " <name>",
                            Description = S("Show's the room, where <name> is."),
                            Parameter = "<>",
                            Shortcut = "/c " .. short .. " <name>",
                        }
                       )

sc.registered_commands[cname] = function(player, parameter)



    if(parameter[2] == "" or parameter[2] == nil) then
        sc.print(player, sc.red .. S("Error: No name given."))

    else
        local pname = parameter[2]
        local channel = sc.player[pname]

        if(minetest.get_player_by_name(pname)) then
            local room = sc.player[pname]
            if(room ~= nil) then
                sc.print(player, sc.green .. S("Player [") .. sc.orange .. pname
                         .. sc.green .. S("] is in Channel {")
                        .. sc.yellow .. channel .. sc.green .. "}.")

            else
                sc.print(player, sc.green .. S("Player [") .. sc.orange .. pname
                         .. sc.green .. S("] is in the public Chat."))

            end -- if(room ~= nil)

        else -- if(minetest.get_player_by_name
            sc.print(player, sc.red .. S("Error: Player is not online."))

        end -- if(minetest.get_player_by_name

    end -- if(paramter[2]

end -- sc["where"

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc["w"
