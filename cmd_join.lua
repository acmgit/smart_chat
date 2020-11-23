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
    
    if(sc.locks[channel] ~= nil) then                   -- Channel is locked
        if(sc.locks[channel][player] == nil) then       -- The player is not on the list
            sc.print(player, sc.red .. S("Error: the Channel is locked."))
            return
            
        end -- if(sc.locks
            
    end -- if(sc.locks
    
    if( sc.player[player]
    sc.report(player, S("Leaves the Channel."))
    sc.player[player] = channel
    sc.report(player, S("Enter the Channel."))


end -- sc["join"

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc["j"
