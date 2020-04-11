local lib = smart_chat
local S = lib.S

lib.register_help({
                            Name = "help",
                            Usage = "/c help <> | <command>",
                            Description = S("Helpsystem for ") .." " .. lib.modname .. ".",
                            Parameter = "<> | " .. S("<command>") .. lib.green .. "." ..
                                        "\n" .. lib.orange .. "<>" ..
                                        lib.green.. " - " .. S("Shows you the entire help for ") .. lib.modname ..
                                        "." .. "\n" .. lib.orange .. S("<command>") ..
                                        lib.green .. " - " .. S("Shows you the help for ") ..
                                        lib.modname .. "-" .. S("command") .. ".",
                            Shortcut = "/c h <> | <command>",
                        }
                       )

lib["help"] = function(player, parameter)
    if(parameter[2] == "" or parameter[2] == nil) then
        lib.print(player, lib.green .. S("Commands for ") .. lib.modname .. " " .. lib.orange ..
                        lib.version .. "." .. lib.revision .. lib.green .. ".")
        for _,value in pairs(lib.helpsystem) do
            lib.print(player, lib.yellow .. "---------------")
            lib.print(player, lib.green .. S("Name: ") .. lib.orange .. value.Name)
            lib.print(player, lib.green .. S("Description: ") .. lib.yellow .. value.Description)
            lib.print(player, lib.green .. S("Usage: ") .. lib.orange .. value.Usage)
            lib.print(player, lib.green .. S("Parameter: ") .. lib.orange .. value.Parameter)
            lib.print(player, lib.green .. S("Shortcut: ") .. lib.orange .. value.Shortcut)

        end -- for _,value

        lib.print(player, lib.yellow .. "---------------")

    else
        if(lib.helpsystem[parameter[2]] ~= nil) then
            lib.print(player, lib.green .. S("Name: ") .. lib.orange ..
                            lib.helpsystem[parameter[2]].Name)
            lib.print(player, lib.green .. S("Description: ") .. lib.yellow ..
                            lib.helpsystem[parameter[2]].Description)
            lib.print(player, lib.green .. S("Usage: ") .. lib.orange ..
                            lib.helpsystem[parameter[2]].Usage)
            lib.print(player, lib.green .. S("Parameter: ") .. lib.orange ..
                            lib.helpsystem[parameter[2]].Parameter)
            lib.print(player, lib.green .. S("Shortcut: ") .. lib.orange ..
                            lib.helpsystem[parameter[2]].Parameter)

        else
            lib.print(player, lib.red .. S("No entry in help for command") .. " <" ..
                            lib.orange .. parameter[2] .. lib.red .. "> " .. S("found" .. "."))

        end -- if(lib.help[parameter[2

    end -- if(parameter[2]

end -- function help

lib["h"] = function(player, parameter)

        lib["help"](player, parameter)

end -- lib["h"
