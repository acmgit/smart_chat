local lib = smart_chat
local mn = lib.modname
local S = lib.S

--[[
   ****************************************************************
   *******        Function split(parameter)                  ******
   ****************************************************************
    Split Command and Parameter and write it to a table
--]]
function lib.split(parameter)
        local cmd = {}
        for word in string.gmatch(parameter, "[%w%-%:%.2f%_]+") do
            table.insert(cmd, word)

        end -- for word

        return cmd

end -- function lib.split

--[[
   ****************************************************************
   *******        Function check(command)                    ******
   ****************************************************************
    Check if the command is valid
--]]
function lib.check(player, cmd)

        if(cmd ~= nil and cmd[1] ~= nil) then
            if(lib.registered_commands[cmd[1]] ~= nil) then
                -- Command is valid, execute it with parameter
                lib.registered_commands[cmd[1]](player, cmd)

            else -- A command is given, but
            -- Command not found, report it.
                if(cmd[1] ~= nil) then
                    lib.print(player, lib.red .. mn ..": " .. S("Unknown Command") .. " \"" ..
                                    lib.orange .. cmd[1] .. lib.red .. "\".")

                else
                    if(lib.registered_commands["help"]) then
                        lib.registered_commands["help"](player, cmd)

                    else
                        lib.print(player, lib.red .. S("Unknown Command. No helpsystem available."))

                    end --if(distancer["help"]

                end -- if(cmd[1]

            end -- if(distancer[cmd[1

        else
            lib.print(player, lib.red .. S("No Command for ") .. mn .. S(" given."))
            lib.print(player, lib.red .. S("Try /c help."))

        end -- if(not cmd)

end -- function lib.check(cmd

--[[
   ****************************************************************
   *******         Function register_help()                  ******
   ****************************************************************
    Registers a new Entry in the Helpsystem for an Command.
]]--
function lib.register_help(entry)

    lib.helpsystem[entry.Name] = {
                                Name = entry.Name,
                                Usage = entry.Usage,
                                Description = entry.Description,
                                Parameter = entry.Parameter,
                                Shortcut = entry.Shortcut,
                            }

end

--[[
   ****************************************************************
   *******         Function print(player, message)           ******
   ****************************************************************
]]--

function lib.print(player, text)
    local lprint = minetest.chat_send_player
    --local playername = minetest.get_player_by_name(player)
    lprint(player, text)

end -- function distancer.print(

-- Is player in the public channel?
function lib.check_global(cplayer)
    if(lib.player[cplayer] == nil) then
        return true

    else
        return false

    end

end

--[[
   ****************************************************************
   *******              Function check_channel()             ******
   ****************************************************************
]]--

function lib.check_channel(cplayer, channel)

    if(lib.player[cplayer] == channel) then
       return true

    else
      return false

    end -- if(sc.player[

end -- lib.check_channel

--[[
   ****************************************************************
   *******              Function channel_report()            ******
   ****************************************************************

   Send a message to a channel.
   channel = nil: Send a message to the public channel.
]]--

function lib.channel_report(channel, message, color)
    local all_player = minetest.get_connected_players()
    if(color ~= nil) then
        color = lib.orange

    end -- if(color

    for _,players in pairs(all_player) do
        local pname = players:get_player_name()

        if(lib.check_channel(pname, channel)) then
            lib.print(pname, color .. message)

        end -- if(check_channel

    end -- for _,players

end -- lib.report(

--[[
   ****************************************************************
   *******              Function report()                    ******
   ****************************************************************
]]--
function lib.report(player, message)
    local all_player = minetest.get_connected_players()
    local channel = lib.player[player]

    for _,players in pairs(all_player) do
        local pname = players:get_player_name()

        if(lib.check_channel(pname, channel)) then
            lib.print(pname, lib.orange .. "<" .. lib.yellow .. player .. lib.orange .. "> " .. message)

        end -- if(check_channel

    end -- for _,players

end -- lib.report(

--[[
   ****************************************************************
   *******          Function receive_from_irc                ******
   ****************************************************************

Writes the Text from IRC to the Public Channel
]]--

function lib.receive_from_irc(line)
    if(not lib.irc_running) then return end

    local playername, msg

    local pos1, pos2
    pos1 = string.find(line,"!",2)
    pos2 = string.find(line,":",3,true)

    if((pos1 ~= nil) and (pos2 ~= nil)) then
        playername = lib.get_nick_from_irc(line)
        msg = string.sub(line, string.find(line,":",3,true)+1)
        line =  lib.white .. "<" .. playername .. "@IRC> " .. msg               -- <player@IRC> Message
        local all_player = minetest.get_connected_players()

        for _,player in pairs(all_player) do
            local pname = player:get_player_name()
            if(lib.check_global(pname) or lib.public[pname]) then               -- Player is in Public Channel
                lib.print(pname, line)

            end -- if(lib.check_global

        end -- for _,player in

    end -- if((pos1 ~= 1

end -- function lib.receive()

--[[
   ****************************************************************
   *******           Function send_2_public()                  ******
   ****************************************************************

Sends a Text as playername to the IRC
]]--
function lib.send_2_public(playername, text)

    lib.print(playername, text)
    lib.send_2_irc(playername, text)

end -- lib.send_2_public

--[[
   ****************************************************************
   *******           Function send_2_irc()                   ******
   ****************************************************************

Sends a Text as playername to the IRC
]]--

function lib.send_2_irc(playername, text)

    if(lib.irc_message ~= text) then
        if(not lib.irc_running) then return end

        --local line = minetest.strip_colors(text)
        local line = string.gsub(text, "\27%([^()]*%)", "")

        --print(line)
        line = "PRIVMSG "   .. lib.irc_channel .. " :<" .. playername
                            .. "@" .. lib.servername .. "> " .. line .. lib.crlf
        lib.client:send(line)
        lib.irc_message_count = 0   -- This prevents for IRC-Echos of multiple player
        lib.irc_message = text      -- and remembers the last message

    else
        lib.irc_message_count = lib.irc_message_count + 1        -- IRC-Message was the same as the lasts
        if(lib.irc_message.count == 1) then                      -- clear the counter after 2 second from the
            minetest.after(2,   function()                       -- last message automatical
                                    lib.irc_message_count = 0

                                end) -- function

        else                                                     -- if(lib.irc_message > 1
            return                                               -- do nothing

        end -- if(lib.irc_message_count

    end -- if(lib.irc_message ~=

end -- function send_2_irc

function lib.get_nick_from_irc(line)
    local nick

    nick = string.sub(line,2,string.find(line,"!",2)-1)
    return nick

end -- get_nick_from_irc()


function lib.send_2_public_channel(user, message)
    if(not check_global(user)) then return end

    local all_player = minetest.get_connected_players()
    for _,player in pairs(all_player) do
        local pname = player:get_player_name()                                             -- get Playername
        if( lib.check_global(pname) )then                                                  -- Player in Public Channel?
            if(user ~= pname) then                                                         -- don't send yourself
                minetest.chat_send_player(pname, lib.white .. message)
                if( minetest.global_exist(yl_matterbridge) ) then                          -- Matterbridge available?
                    lib.send_2_bridge(pname, message)

                end -- lib.send_2_bridge

            end -- if(user

        end -- if(lib.check_global

    end -- for _, player

end -- lib.send_2_public_channel

--[[
   ****************************************************************
   *******            Function print_all()                   ******
   ****************************************************************
]]--
function lib.chat(playername, text)
    local all_player = minetest.get_connected_players()
    local channel = lib.player[playername] -- Get the Channel of the player

    for _,players in pairs(all_player) do
        local pname = players:get_player_name()

        if(channel == nil) then
            if(lib.check_global(pname)) then
                minetest.chat_send_player(pname, "<" .. playername .. "> " .. text)

            end -- if(lib.check_global(

            if(lib.public[pname] and pname ~= playername) then -- name is in public-mode and not the player self
                minetest.chat_send_player(pname, "<" .. playername .. "> " .. text)
            end

            if(lib.client ~= nil) then
                lib.send_2_irc(playername, text)

            end -- if(sc.client

        elseif(lib.check_channel(pname, channel)) then
                minetest.chat_send_player(pname, lib.yellow .. "<" .. lib.orange .. playername .. "@"
                                          .. channel .. lib.yellow .. "> " .. text)

        end -- if(channel == nil

    end -- for _,players

    -- Logging of the Chat
    if(channel == nil) then
        minetest.log("action", "CHAT: # <" .. playername .. "> " .. text)
    else
        minetest.log("action", "CHAT: # <" .. playername .. "@" .. channel .. "> " .. text)
    end

    return true

end -- function chat

function lib.is_channelmod(player)
    local power = 0
    if(minetest.get_player_privs(player).channelmod) then
        power = 10
    end

    return power

end

function lib.is_channeladmin(player)
    local power = 0
    if(minetest.get_player_privs(player).channeladmin) then
        power = 20

    end

    return power

end

--[[
   ****************************************************************
   *******         Function show_version()                   ******
   ****************************************************************
]]--

function lib.show_version()
    print("[MOD]" .. lib.modname .. " v " .. lib.version .. "." .. lib.revision .. " loaded. \n")

end -- lib.show_version
