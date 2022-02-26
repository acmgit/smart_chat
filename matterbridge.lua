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

    if(minetest.global_exists(yl_matterbridge)) then

        --[[
            ****************************************************************
            *******      Function yl_matterbridge.chat_message        ******
            ****************************************************************

            turns the on_register_chat_messages() from matterbridge off
            because smart_chat has register his own event
        ]]--

        function yl_matterbridge.chat_message(username, message_text)
        end

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
                    sc.chat(pname, line)

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

            if(not sc.check_global(user_name) then return end                                -- is User in public-channel?

            local line = "<" .. user_name .. "@" .. sc.servername .. "> " .. message_text
            yl_matterbridge.send_to_bridge(user_name, line)

        end -- function sc.send_2_bridge

    end -- if(minetest.global_exist

end -- if( sc.matterbridge

