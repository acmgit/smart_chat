--[[
   ****************************************************************
   *******                                                   ******
   *******        Support for Matterbridge                   ******
   *******    (?) by A.C.M. and Bastrabun on your-land       ******
   *******                                                   ******
   ****************************************************************

]]--

local sc = smart_chat

if(sc.matterbridge == true) then
    if(sc.matterbridge_irc) then
        minetest.log("action","[MOD] " .. sc.modname .. " : Module matterbridge: yl_matterbridge_irc is on.")

    else
        minetest.log("action","[MOD] " .. sc.modname .. " : Module matterbridge: yl_matterbridge_irc is off.")

    end -- if(sc.matterbridge_irc

    --[[
        ****************************************************************
        *******      Function yl_matterbridge.chat_message        ******
        ****************************************************************

        turns the on_register_chat_messages() from matterbridge off
        because smart_chat has register his own event
    ]]--

    function yl_matterbridge.chat_message(username, message_text)
        yl_matterbridge.receive_from_bridge(user_name, message_text)
        
    end

    --[[
        ****************************************************************
        *******    Function yl_matterbridge.receive_from_bridge   ******
        ****************************************************************

        Overwrites the function handle the message about smart_chat
    ]]--

    function yl_matterbridge.receive_from_bridge(user_name, message_text, account)

        local line = "<"..account .."|" .. user_name .. "> " .. message_text
        minetest.log("action", "[MOD] " .. sc.modname .. " : Module matterbridge: From Bridge: " .. line)
        local all_player = minetest.get_connected_players()

        for _,player in pairs(all_player) do
            local pname = player:get_player_name()
            if(sc.check_global(pname) or sc.public[pname] and (user_name ~= pname)) then   -- Player is in Pub-Channel
                sc.print(pname, line)

            end -- if(lib.check_global

        end -- func(user_name

    end -- function yl_matterbridge

    --[[
        ****************************************************************
        *******      Function yl_matterbridge.send_2_bridge       ******
        ****************************************************************

        Function to send a message to the matterbridge
    ]]--

    function sc.send_2_bridge(user_name, message_text)

        if(sc.player[user_name] ~= nil) then return end                                -- is User in public-channel?

        --local line = "<" .. user_name .. "@" .. sc.servername .. "> " .. message_text
        minetest.log("action", "[MOD] " .. sc.modname .. " Module matterbridge: To Bridge : " .. message_text)
        yl_matterbridge.send_to_bridge(user_name, message_text)

    end -- function sc.send_2_bridge

    minetest.log("action", "[MOD] " .. sc.modname .. " Module matterbridge: : yl_matterbridge loaded.")

end -- if(ylmatterbridge exist


