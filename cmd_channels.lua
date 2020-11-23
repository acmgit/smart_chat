local sc = smart_chat
local S = sc.S
local cname = "channels"
local short = "c"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname,
                            Description = S("Lists all channels on the Server."),
                            Parameter = "<>",
                            Shortcut = "/c " .. short
                 })

sc.registered_commands[cname] = function(player)

    local list = {}
    local all_player = minetest.get_connected_players()

    sc.print(player, sc.green .. S("Channels on Server:"))

    for _,players in pairs(all_player) do
        local pname = players:get_player_name()
        local channel = sc.player[pname]
        local power

        if(channel ~= nil) then         -- channel exists
            power = sc.get_channel_power(channel)   -- Get the power of the channel
            local flag = calculate_flag(power)      -- and calculate the flag
            list[channel] = flag                    -- add the channel to list

        end -- if(channel ~= nil)

    end -- for_,players

    for _,channel in pairs(sc.permchannel) do
        local power
        if(list[channel] == nil) then               -- Channel is not in list
                power = sc.get_channel_power(channel)
                local flag = calculate_flag(power)
                list[channel] = flag

        end -- if(list[channel]

    end -- for _,channel

    for _,entry in pairs(list) do -- Write the list on screen.
        sc.print(player, sc.green .. "|" .. sc.yellow .. entry .. sc.green .. "| " .. sc.orange .. _)

    end

end -- sc["list"

function calculate_flag(power)
    local flag = sc.yellow .. ""

    if(power == sc.channel_value["normal"] + sc.channel_value["permanent"] + sc.channel_value["locked"]) then
        flag = flag .. " P L"
    elseif(power == sc.channel_value["normal"] + sc.channel_value["permanent"]) then
        flag = flag .. " P  "
    elseif(power == sc.channel_value["normal"] + sc.channel_value["locked"]) then
        flag = flag .. "   L"
    elseif(power == sc.channel_value["normal"]) then
        flag = flag .. "    "
    end

    return flag .. sc.green

end
sc.registered_commands[short] = function(player, parameter)

        sc.registered_commands[cname](player, parameter)

end -- sc["l"
