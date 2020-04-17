local sc = smart_chat
local S = sc.S
local cname = "template"
local short = "t"
local activate = minetest.settings:get_bool("smart_chat.cmd_" .. cname, true)

if(not activate) then return end

sc.register_help({
                            Name = cname,
                            Usage = "/c " .. cname .. " <" .. cname .. ">",
                            Description = S("Template Command with Parameter <" .. cname .. ">."),
                            Parameter = "<" .. cname .. ">",
                            Shortcut = "/c " .. short .. " <" .. cname .. ">",
                        }
                       )

sc[cname] = function(player, parameter)

--[[
     *******************************************************
     ***         Insert your code to execute here        ***
     *******************************************************
    parameter = Table with command and parameter(s)
    parameter[1] = command
    parameter[2] = parameter 1
    parameter[3] = parameter 3
    ...
    parameter[x] = parameter x
]]--


end -- sc[template

sc[short] = function(player, parameter)

        sc[cname](player, parameter)

end -- sc[template_shortcut
