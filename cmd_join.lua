local sc = smart_chat
local S = sc.S
local cname = "join"
local short = "j"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname .. " <channel>",
                            Description = S("Join or change a channel to <channel>."),
                            Parameter = "<channel>",
                            Shortcut = "/c " .. short .. " <channel>",
                        }
                       )

sc.registered_commands[cname] = function(player, parameter)

     if(parameter[2] == nil or parameter[2] == "") then
         sc.print(player, sc.red .. S("Error: No channel to join given."))
         return
     end
    local channel = parameter[2]
<<<<<<< HEAD

    if(sc.locks[channel] ~= nil) then                   -- Channel is locked
        if(sc.is_channelmod(player) < sc.moderator) or
          (sc.is_channeladmin(player) < sc.admin) then -- is player a moderator or admin?

            if(sc.locks[channel][player] == nil) then       -- The player is not on the list
                sc.print(player, sc.red .. S("Error: the Channel is locked."))
                return

            end -- if(sc.locks

        end -- if(sc.is_channelmod()

    end -- if(sc.locks

=======
    
    if(sc.locks[channel] ~= nil) then                   -- Channel is locked
        if(sc.locks[channel][player] == nil) then       -- The player is not on the list
            sc.print(player, sc.red .. S("Error: the Channel is locked."))
            return
            
        end -- if(sc.locks
            
    end -- if(sc.locks
    
    if( sc.player[player]
>>>>>>> d92e6ca99ef18074cba34b9d1c139bac8935e34e
    sc.report(player, S("Leaves the Channel."))
    sc.player[player] = channel
    sc.report(player, S("Enter the Channel."))


end -- sc["join"

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc["j"
