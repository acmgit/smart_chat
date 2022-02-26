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

    if(minetest.global_exist(yl_matterbridge)) then

        function yl_matterbridge.chat_message(username, message_text)
        end

        function yl_matterbridge.receive_from_bridge(user_name, message_text, account)
            local line = "<"..account_name.."|" .. user_name .. "> " .. message_text
            sc.send_2_public_channel(line)

        end -- func(user_name

        function sc.send_2_bridge(user_name, message_text)
            local line = "<" .. user_name .. "@" .. sc.servername .. "> " .. message_text
            if(sc.check_global(user_name)) then
                yl_matterbridge.send_to_bridge(username, line)
                
            end -- if(sc.check_global

        end

    end -- if(minetest.global_exist

end -- if( sc.matterbridge

