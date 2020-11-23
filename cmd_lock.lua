local sc = smart_chat
local S = sc.S
local cname = "lock"
local short = "lo"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname .. " <" .. S("Channelname") .. ">",
                            Description = S("Locks the current channel channel."),
                            Parameter = "<" .. S("Channelname") .. ">",
                            Shortcut = "/c " .. short .. " <" .. S("Channelname") .. ">",
                        }
                       )

sc.registered_commands[cname] = function(player, parameter)

--[[
     *******************************************************
     ***         Insert your code to execute here        ***
     *******************************************************
    parameter = Table with command and parameter(s)
    parameter[1] = command
    parameter[2] = parameter 1
    parameter[3] = parameter 2
    ...
    parameter[x] = parameter x
]]--

    local channel = sc.player[player]

    if(sc.player[player] == nil) then
        sc.print(player, sc.red .. S("Error: You're in the public chat."))
        return

    else
        if(sc.is_channel_locked(channel)) then
            sc.print(player, sc.red .. S("Error: The channel is already locked."))
            return

        end

        if(sc.is_channel_permanent(channel)) then
            local power = sc.is_channelmod(player) + sc.is_channeladmin(player)
            if(power < sc.moderator) then
                sc.print(player.sc.red .. S("Error: You have not the privileg to lock a permanent Channel."))
                return

            end -- if(power <

        end --if(sc.is_channel_permanent

        sc.report(player, sc.green .. "Player: " .. sc.orange .. player .. sc.green ..
        " has locked the channel: " .. sc.orange .. channel .. sc.green .. ".")
        sc.locks[channel] = {}
        sc.locks[channel][player] = player

    end


end -- sc[template

sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc.registered_commands[template_shortcut
