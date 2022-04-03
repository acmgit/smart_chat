--[[
   ****************************************************************
   *******                                                   ******
   *******        Support for Matterbridge                   ******
   *******    (?) by A.C.M. and Bastrabun on your-land       ******
   *******                                                   ******
   ****************************************************************

]]--

local sc = smart_chat

local matterbridge = ""
local mattersbridge_irc = ""

if(sc.mattersbridge) then
    mattersbridge = "on"
else
    mattersbridge = "off"
end

if(sc.mattersbridge_irc) then
    mattersbridge_irc = "on"
else
    mattersbridge_irc = "off"
    sc.matterbridge_irc = nil
  
end

minetest.log("action","[MOD] " .. sc.modname .. ": Modul mattersbridge :yl_mattersbridge = " .. mattersbridge)
minetest.log("action","[MOD] " .. sc.modname .. ": Modul mattersbridge :yl_mattersbridge_irc = " .. mattersbridge_irc)

if( sc.matterbridge) then

    if( minetest.get_modpath("yl_matterbridge")) then

        --[[
            ****************************************************************
            *******      Function yl_matterbridge.chat_message        ******
            ****************************************************************

            turns the on_register_chat_messages() from matterbridge off
            because smart_chat has register his own event
        ]]--
        yl_matterbridge.chat_message = function() end
        yl_matterbridge.register_chat = function() end

        --[[
            ****************************************************************
            *******    Function yl_matterbridge.receive_from_bridge   ******
            ****************************************************************

            Overwrites the function handle the message about smart_chat
        ]]--

        function yl_matterbridge.receive_from_bridge(user_name, message_text, account)
            local line = "<"..account .."|" .. user_name .. "> " .. message_text
            local all_player = minetest.get_connected_players()

            for _,player in pairs(all_player) do
                local pname = player:get_player_name()
                if(sc.check_global(pname) or sc.public[pname]) then                        -- Player is in Pub-Channel
                    sc.print(pname, line)

                end -- if(lib.check_global

            end -- func(user_name

            minetest.log("action", "[MOD] " .. sc.modname .. " : Module matterbridge: receive_from_bridge: " .. line)

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
            yl_matterbridge.send_to_bridge(user_name, message_text)
            minetest.log("action", "[MOD] " .. sc.modname .. " : Module matterbridge: send_2_bridge: " .. message_text)

        end -- function sc.send_2_bridge

        minetest.log("action", "[MOD] " .. sc.modname ..
                               " : Module matterbridge: Mod yl_matterbridge successfully loaded.")

    else
        minetest.log("action", "[MOD] " .. sc.modname .. " : Module matterbridge: Mod yl_matterbridge not found.")

    end -- if( minetest.get_modpath

end -- if( sc.matterbridge == true
