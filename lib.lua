local lib = smart_chat
local mn = lib.modname
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
            if(lib[cmd[1]] ~= nil) then
                -- Command is valid, execute it with parameter
                lib[cmd[1]](player, cmd)

            else -- A command is given, but
            -- Command not found, report it.
                if(cmd[1] ~= nil) then
                    lib.print(player, lib.red .. mn ..": Unknown Command \"" ..
                                    lib.orange .. cmd[1] .. lib.red .. "\".")

                else
                    if(lib["help"]) then
                        lib["help"](player, cmd)

                    else
                        lib.print(player, lib.red .. "Unknown Command. No helpsystem available.")

                    end --if(distancer["help"]

                end -- if(cmd[1]

            end -- if(distancer[cmd[1

        else
            lib.print(player, lib.red .. "No Command for " .. mn .. " given.")
            lib.print(player, lib.red .. "Try /c help.")

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
   *******     Function display_chat_message(message)        ******
   ****************************************************************
]]--

function lib.print(player, text)
    local lprint = minetest.chat_send_player
    --local playername = minetest.get_player_by_name(player)
    lprint(player, text)

end -- function distancer.print(

function lib.check_global(cplayer)
    if(lib.player[cplayer] == nil) then
        return true

    else
        return false

    end

end

function lib.check_channel(cplayer, channel)

    if(lib.player[cplayer] == channel) then
       return true

    else
      return false

    end -- if(sc.player[

end -- lib.check_channel

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
                minetest.log("action", "CHAT: # <" .. playername .. "> " .. text)

            end -- if(lib.check_global(

        elseif(lib.check_channel(pname, channel)) then
                minetest.chat_send_player(pname, lib.yellow .. "<" .. lib.orange .. playername .. "@"
                                          .. channel .. lib.yellow .. "> " .. text)
                minetest.log("action", "CHAT: # <" .. playername .. "@" .. channel .. ">" .. text)

        end -- if(channel == nil

    end -- for _,players

    -- Send's the message to all public Players too
    for _,players in pairs(lib.public) do
        if(players ~= playername) then
            minetest.chat_send_player(players, "<" .. playername .. "> " .. text)

        end -- if(players ~= playername

    end -- for _,players

    return true

end -- function chat

--[[
   ****************************************************************
   *******         Function show_version()                   ******
   ****************************************************************
]]--

function lib.show_version()
    print("[MOD]" .. lib.modname .. " v " .. lib.version .. "." .. lib.revision .. " loaded. \n")

end -- lib.show_version
