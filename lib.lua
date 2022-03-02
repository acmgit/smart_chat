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
                minetest.log("action", "[MOD] " .. lib.modname .. " : Module lib: " .. player .. " executes " .. cmd[1])

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
   Send message to the player
]]--

function lib.print(player, text)
    local lprint = minetest.chat_send_player
    lprint(player, text)
    minetest.log("action", "[MOD] " .. lib.modname .. " : Module lib: " .. text .. " to " .. player)

end -- function lib.print(

--[[
   ****************************************************************
   *******         Function check_global(player)             ******
   ****************************************************************
   returns true if player is in public channel
]]--

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
   Is the player in the channel?
]]--

function lib.check_channel(cplayer, channel)

    if(lib.player[cplayer] == channel) then
       return true

    else
      return false

    end -- if(lib.player[

end -- lib.check_channel

--[[
   ****************************************************************
   *******              Function channel_report()            ******
   ****************************************************************

   Something happens in the Channel like leave the channel.
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
    minetest.log("action", "[MOD] " .. lib.modname .. " : Module lib: channel_report: " .. channel .. ": " .. message)

end -- lib.report(

--[[
   ****************************************************************
   *******              Function report()                    ******
   ****************************************************************

   Player is doing something in the Channel like leave the channel.
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

    minetest.log("action", "[MOD] " .. lib.modname .. " : Module lib: report" .. player .. " " .. message)

end -- lib.report(

--[[
   ****************************************************************
   *******          Function receive_from_irc                ******
   ****************************************************************

Writes the Text from IRC to the Public Channel
]]--

function lib.receive_from_irc()
    if(not lib.irc_running) then return end

    local line = lib.irc_line
    local playername
    local pos1, pos2

    pos1 = string.find(line,"!",2)
    pos2 = string.find(line,":",3,true)

    if((pos1 ~= nil) and (pos2 ~= nil)) then
        playername = string.sub(line, pos1+1,pos2-1)
        line = string.sub(line,pos2 +1)
        _, pos2 = string.find(line,sc.irc_channel,1,true)
        if(pos2 ~= nil) then
            line = string.sub(line, pos2+3)
            
        end -- if(pos2
        
        local a, e = string.find(line, "ACTION")                                            -- was /ME-Command from irc
        if( (a) and (a >= 1) ) then
            line = string.sub(line, e + 1)
            line = lib.orange .. "* " .. playername .. "@IRC " .. line

        else
            line =  lib.white .. "<" .. playername .. "@IRC> " .. line                     -- <player@IRC> Message

        end -- if(a >= 1

        local all_player = minetest.get_connected_players()
        for _,player in pairs(all_player) do
            local pname = player:get_player_name()
            if(lib.check_global(pname) or lib.public[pname]) then                          -- Player in Pub. Channel
                lib.print(pname, line)

            end -- if(lib.check_global

        end -- for _,player in

    end -- if((pos1 ~= 1

    minetest.log("action", "[MOD] " .. lib.modname .. " : Module lib: receive_from_irc: <"
                                    .. (playername or "...") .. "> " .. line)

end -- function lib.receive()

--[[
   ****************************************************************
   *******             Function send_2_irc                   ******
   ****************************************************************

Sends a Text as playername to the IRC
]]--

function lib.send_2_irc(playername, text)

    if(not lib.irc_on) then return end                                                     -- IRC isn't on

    if(lib.player[playername] ~= nil) then return end                                      -- Player is in channel

    if(lib.irc_message ~= text) then
        if(not lib.irc_running) then return end

        local line = string.gsub(text, "\27%([^()]*%)", "")
        line = "PRIVMSG "   .. lib.irc_channel .. " :<" .. playername .. "> " .. line .. lib.crlf
        lib.client:send(line)
        lib.irc_message_count = 0   -- This prevents for IRC-Echos of multiple player
        lib.irc_message = text      -- and remembers the last message
        minetest.log("action", "[MOD] " .. lib.modname .. " : Module lib: send_2_irc: " .. line)

    else
        local line = string.gsub(text, "\27%([^()]*%)", "")
        line = "PRIVMSG "   .. lib.irc_channel .. " :<" .. playername .. "> " .. line .. lib.crlf
        lib.irc_message_count = lib.irc_message_count + 1                                  -- IRC-Message was the same
        if( (lib.irc_message.count == 1) and
            (lib.irc.message == line) ) then                                               -- clear counter after second
            minetest.after(2,   function()                                                 -- last message automatical
                                    lib.irc_message_count = 0

                                end) -- function
            minetest.log("action", "[MOD] " .. lib.modname .. " : Module lib: Message counts: "
                                            .. lib.irc_message_count)

        else -- if(lib.irc_message > 1
            return                                                                         -- do nothing

        end -- if(lib.irc_message_count

    end -- if(lib.irc_message ~=

end -- function send_2_irc

--[[
   ****************************************************************
   *******           Function get_nick_from_irc              ******
   ****************************************************************

Extract the nickname from a received line from irc
]]--

function lib.get_nick_from_irc(line)
    local nick

    nick = string.sub(line,2,string.find(line,"!",2,true)-1)
    return nick

end -- get_nick_from_irc()


--[[
   ****************************************************************
   *******            Function chat()                        ******
   ****************************************************************
   Send's a message to public or channel
]]--

local message = ""
local message_count = 0

function lib.chat(playername, text)
    local all_player = minetest.get_connected_players()
    local channel = lib.player[playername] -- Get the Channel of the player

    if( (message == text) and (message_count >= 1)) then
        message_count = message_count + 1
            minetest.after(5,   function()                                                 -- last message automatical
                        lib.irc_message_count = 0

            end) -- function

        minetest.log("action", "[MOD] " .. lib.modname .. " : Module lib: Msg twice: <" .. playername .. "> " .. text)
        return true

    else
        message_count = 0
        message = text

    end -- if (message ==

    for _,players in pairs(all_player) do
        local pname = players:get_player_name()

        if(channel == nil) then
            if(lib.check_global(pname)) then
                minetest.chat_send_player(pname, "<" .. playername .. "> " .. text)

            end -- if(lib.check_global(

            if(lib.public[pname] and pname ~= playername) then -- name is in public-mode and not the player self
                minetest.chat_send_player(pname, "<" .. playername .. "> " .. text)
            end

            if(lib.irc_on) then
                lib.send_2_irc(playername, text)

            end -- if(lib.client

            if(lib.matterbridge) then
               lib.send_2_bridge(playername, text)

            end -- if(lib.matterbridge)

            minetest.log("action", "[MOD] " .. lib.modname .. " : Module lib: chat: <" .. playername .. "> " .. text)

         elseif(lib.check_channel(pname, channel)) then
                minetest.chat_send_player(pname, lib.yellow .. "<" .. lib.orange .. playername .. "@"
                                                            .. channel .. lib.yellow .. "> " .. text)
                minetest.log("action", "[MOD] " .. lib.modname .. " : Module lib: chat: <"
                                                .. playername .. "@" .. channel .. "> " .. text)

        end -- if(channel == nil

    end -- for _,players

    return true

end -- function chat

--[[
   ****************************************************************
   *******           Function is_channelmod()                ******
   ****************************************************************

if player is channelmod, power is 10, else 0
]]--

function lib.is_channelmod(player)
    local power = 0
    if(minetest.get_player_privs(player).channelmod) then
        power = 10
    end

    return power

end

--[[
   ****************************************************************
   *******           Function is_channeladmin()              ******
   ****************************************************************

if player is channelmod, power is 20, else 0
]]--

function lib.is_channeladmin(player)
    local power = 0
    if(minetest.get_player_privs(player).channeladmin) then
        power = 20

    end

    return power

end
