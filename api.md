## API for smart_chat
<br>
The smart_chat is mod, which works with modules. So you only have to take the module cmd_pattern,<br>
fill it with your code and add a dofile(path .. "/cmd_your_cool_command.lua") in the init.lua.<br>

When you fill out the part for the help-system in the pattern, it integrates automatically in the<br> helpsystem of smart_chat.<br>

## Methods:
<br>

#### void smart_chat.channel_report(string channel, string message)
Send's the message to all player in channel as report. For example, the player leaves the channel.
<br>

#### boolean smart_chat.check_channel(string, player, string channel)
Checks, if the player is in the channel.<br>
True, the player is in channel, false, the player is in another channel.
<br>

#### boolean smart_chat.check_global(string player)
Checks, if the player is in a channel or in the public chat.<br>
True, the player is in public chat, false, the player is in a channel.
<br>

#### integer smart_chat.is_channeladmin(string playername)
Checks the status of playername, if the player is a admin, the you get 20 as power back.<br>
Else you get 0 as power back.
<br>

#### integer smart_chat.is_channelmod(string playername)
Checks the status of playername, if the player is a moderator, then you get 10 as power back.<br>
Else you get 0 as power back.
<br>

#### void smart_chat.print(string player, string message)
Prints a message to the player. You can use the colorcodes too.
<br>

#### void smart_chat.register_help(table entry)
Adds the entry to the integrated Helpsystem.
<br>

#### void smart_chat.report(string playername, string message)
You send a report to the channel, where you are. For example: playername invites player in the channel.
<br>

#### table smart_chat.split(string parameter)
Splits your string into individual words. A space works as separator.<br>
The function give you a table with the words back.
<br>

### void receive_from_irc()
Receives a Line from the IRC and prints it, if it was from an user on the irc, on the chat in Minetest.
<br>

### void send_2_irc(string playername, string text)
Sends text to the IRC.
<br>

## Tables:

### Help-Entry
<br>
        Name        = Name of the command.<br>
        Usage       = Short description, how to use the command.<br>
        Description = Fully Description of the command.<br>
        Parameter   = "" if there are no parameter, else short description for the typ of parameter.<br>
        Shortcut    = name of a shortcut of the command, like "/c a" for "/c all"
<br>

## Variables:
<br>

#### string smart_chat.modname
Name of the mod.
<br>

#### string smart_chat.modpath
Path of the mod.
<br>

#### integer smart_chat.version
Version of smart_chat.
<br>

#### string smart_chat.last_command
Last command of chat.
<br>

#### function smart_chat.S
Boilerplate for translation.
<br>

#### table smart_chat.player[string Name] = string channelname
This array of playernames stores for each player the Channelname. Nil when the player is in the public chat.
<br>

#### table smart_chat.permchannel[string channelname]
This array holds the permanent channels.
<br>

#### table smart_chat.helpsystem[Help-Entry]
Stores the entries for the helpsystem of smart_chat.
<br>

#### table smart_chat.registered_commands[function]
Stores the command, which you can use about /c ..
<br>

### handle smart_chat.client
Handle for communication with the IRC.
<br>

## Colors of smart_chat:
<br>
The smart_chat provides some colors for your messages and use it for reports or error-messages.
The colors are escape-sequences of minetest.
<br>

#### smart_chat.black
#### smart_chat.blue
#### smart_chat.green
#### smart_chat.grey
#### smart_chat.light_blue
#### smart_chat.light_green
#### smart_chat.light_red
#### smart_chat.orange
#### smart_chat.pink
#### smart_chat.purple
#### smart_chat.red
#### smart_chat.white
#### smart_chat.yellow
<br>

## Network of Smart_chat
Smart_chat has now the ability to connect to an IRC-Server, log in with an given name and join to an given channel. 
At a Ping from the IRC, Smart_chat anwers automatically with a Pong. You can see then the members of the IRC in
your Minetest that they write: Name@IRC. On the other side, a player of your world will answer with: Name@Worldname.
And you can switch on or off your Network, if you dont need this kind of network.
The settings, you can find it at Settingtypes.txt.

## Important for Admins
You have to install the LUA-Socket in your System, for running the irc on your server.

