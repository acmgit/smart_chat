local sc = smart_chat
local S = sc.S
local cname = "lock_channel"
local short = "lc"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname .. " <Password>",
                            Description = S("Locks a Channel with <Password>."),
                            Parameter = "<Password>",
                            Shortcut = "/c " .. short .. " <" .. cname .. ">",
                        }
                       )

sc.registered_commands[cname] = function(player, password)

--[[
     *******************************************************
     ***         Insert your code to execute here        ***
     *******************************************************
    parameter = Table with command and parameter(s)
    parameter[1] = command
    parameter[2] = parameter 1
    parameter[3] = parameter 3
    ...
    parameter[x] = parameter x
]]--
    local channel = sc.player[player]
    if(not channel) then
        sc.print(sc.red .. S("You can't lock the public Channel."))
        return

    end

    if(sc.permchannel[channel] ~= nil) then                                               -- Channel is permanent
        channel = sc.lockmark .. channel
        channel[1] = password
        sc.report(player, sc.green .. S("Has locked the Channel with the Password:") .. " " .. sc.green
                                                                                        .. password .. sc.green .. ".")
        sc.permchannel[channel] = channel
        sc.storage:from_table({fields=sc.permchannel})

    else                                                                                   -- Channel is not permanent

        channel = sc.lockmark .. channel
        channel[1] = password
        sc.report(player, sc.green .. S("Has locked the Channel with the Password:") .. " " .. sc.green
                                                                                        .. password .. sc.green .. ".")

    end -- if(sc.permchannel


end -- (not channel)

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc.registered_commands[template_shortcut
