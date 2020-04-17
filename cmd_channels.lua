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
                            Shortcut = "/c " .. short                        }
                       )

sc[cname] = function(player)

    local list = {}
    local all_player = minetest.get_connected_players()

    sc.print(player, sc.green .. S("Channels on Server:"))

    if(sc.permchannel) then
        -- Adds the permanent Channels
        for _,channel in pairs(sc.permchannel) do
            list[channel] = channel

        end -- for _,channel

    end -- if(sc.permchannel

    for _,players in pairs(all_player) do
        local pname = players:get_player_name()
        if(sc.player[pname] ~= nil) then
            list[sc.player[pname]] = sc.player[pname]

        end -- if(sc.player[pname] ~= nil

    end -- for_,players

    for _,entry in pairs(list) do
        sc.print(player, sc.orange .. entry)

    end

end -- sc["list"

sc[short] = function(player, parameter)

        sc[cname](player, parameter)

end -- sc["l"
