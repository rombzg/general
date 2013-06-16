-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- Widgets library
local vicious = require("vicious")

-- Self written and others utility functions
local utils = require("utils.utils")
local calendar = require("utils.calendar")
local quake = require("utils.quake")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "terminator"
editor = os.getenv("EDITOR") or "emacs"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
tags = {
     names = { "home", "term", "web", "down" },
     layout = { layouts[2], layouts[2], layouts[1], layouts[2]}
     }
 
for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Conky bar
mystatusbar = awful.wibox({ position = "bottom", screen = 1, ontop = false, width = 1, height = 16 })

-- {{{ Wibox
-- Create a textclock widget
os.setlocale("fr_FR.UTF-8") -- Français
mytextclock = awful.widget.textclock(" %a %d %b  %H:%M ")

-- Color tables for foreground and background
local color = { blue="\"blue\"", cyan="\"cyan\"", green="\"#00DC3B\"",
                orange="\"orange\"", red="\"red\"", turquoise="\"turquoise\"",
                white="\"white\"", yellow="\"yellow\"" }

-- {{ Battery widget
local batwidget = wibox.widget.textbox()
vicious.register(batwidget, vicious.widgets.bat,
    function(widget, args)
        local ret = ' Bat:' .. args[1] .. '<span color='
       if args[2] < 15  then
            ret = ret .. color.red
        elseif args[2] < 25 then
            ret = ret .. color.orange
        elseif args[2] < 35 then
            ret = ret .. color.yellow
        else
            ret = ret .. color.green
       end
        return ret .. '>' .. args[2] .. '</span>% (' .. args[3] .. ')  '
    end, 3, "BAT0")
-- }}

-- {{ Volume widget
local volwidget = wibox.widget.textbox()
volwidget:buttons(awful.util.table.join(
        awful.button({ }, 1, function () volumectl("mute") end),
        awful.button({ }, 3,
        function ()
            awful.util.spawn(terminal .. " -e alsamixer")
        end),
        awful.button({ }, 4, function () volumectl("up") end),
        awful.button({ }, 5, function () volumectl("down") end)
 ))
vicious.register(volwidget, vicious.widgets.volume,
    function(widget, args)
        local ret =  ' Vol: <span color='
        if args[1] == 0 or args[2] == "♩" then
            ret = ret .. color.red
        else
            ret = ret .. color.green
        end
        return ret .. '>'.. args[1] .. '</span>%  '
    end, 1, "Master")
-- }}

-- {{ Pacman widget
local pacmanwidget = wibox.widget.textbox()
local pacmantip = awful.tooltip({ objects = { pacmanwidget }, })
pacmantip:set_text('<span color=' .. color.white ..
                '><b><u>Updates:</u></b>\n\n' .. pacupdates() ..
                '</span>')

vicious.register(pacmanwidget, vicious.widgets.pkg,
    function(widget, args)
        local ret = '<span color=' .. color.yellow ..
                    '>C</span> - <span color=' .. color.turquoise ..
                    '>o</span>: <span color='
        if args[1] == 0 then
            ret = ret .. color.green
        elseif args[1] < 6 then
            ret = ret .. color.yellow
        elseif args[1] < 16 then
            ret = ret .. color.orange
        else
            ret = ret .. color.red
        end

        return ret .. '>' .. args[1] .. '</span>  '
    end, 7, "Arch")
-- }}

-- {{ RAM widget
local ramwidget = wibox.widget.textbox()
local ramtip = awful.tooltip({ objects = { ramwidget }, })
local ramtimer = timer({ timeout = 2})

ramwidget:connect_signal("mouse::enter", function() ramtimer:start() end)
ramwidget:connect_signal("mouse::leave", function() ramtimer:stop() end)
ramtimer:connect_signal("timeout",
    function()
        ramtip:set_text('<span color=' .. color.white ..
                        '><b><u>RAM Usage Information:</u></b>\n\n' .. ramusg() ..
                        '</span>')
    end)

vicious.cache(vicious.widgets.mem)
vicious.register(ramwidget, vicious.widgets.mem,
    function(widget, args)
        local ret = ' RAM: <span color='
	if args[1] < 51 then
            ret = ret .. color.green
        elseif args[1] < 71 then
            ret = ret .. color.yellow
        elseif args[1] < 86 then
            ret = ret .. color.orange
        else
            ret = ret .. color.red
        end
        return ret .. '>' .. string.format("%02d", args[1]) .. '</span>%  '
    end, 3)
-- }}

-- {{ CPU widget
local cpuwidget = wibox.widget.textbox()
local cputip = awful.tooltip({ objects = { cpuwidget }, })
local cputimer = timer({ timeout = 2})

cpuwidget:connect_signal("mouse::enter", function() cputimer:start() end)
cpuwidget:connect_signal("mouse::leave", function() cputimer:stop() end)
cputimer:connect_signal("timeout",
    function()
        cputip:set_text('<span color=' .. color.white ..
                '><b><u>CPU Usage Information:</u></b>\n\n' .. cpuusg() ..
                '</span>')
    end)

cpuwidget:buttons(awful.util.table.join(
        awful.button({ }, 3,
        function ()
            awful.util.spawn(terminal .. " -e htop")
        end)
 ))
vicious.register(cpuwidget, vicious.widgets.cpu,
    function(widget, args)
        local ret = ' CPU: <span color='
        if args[1] < 31 then
            ret = ret .. color.green
        elseif args[1] < 51 then
            ret = ret .. color.yellow
	    elseif args[1] < 70 then
            ret = ret .. color.orange
        else
            ret = ret .. color.red
        end
        return ret .. '>' .. string.format("%02d", args[1]) .. '</span>%  '
    end, 2)

local cputempwidget = wibox.widget.textbox()
cputempwidget:buttons(awful.util.table.join(
        awful.button({ }, 3,
        function ()
            awful.util.spawn(terminal .. " -e watch sensors")
        end)
 ))
vicious.register(cputempwidget, vicious.widgets.thermal,
    function(widget, args)
        local ret = '<span color='
        if args[1] < 46 then
            ret = ret .. color.turquoise
        elseif args[1] < 61 then
            ret = ret .. color.yellow
        elseif args[1] < 76 then
            ret = ret .. color.orange
        else
            ret = ret .. color.red
        end
        return ret .. '>' .. args[1] .. '</span>°C  '
    end, 2, "thermal_zone0")
-- }}

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(pacmanwidget)
    right_layout:add(cpuwidget)
    --right_layout:add(cputempwidget)
    right_layout:add(ramwidget)
    right_layout:add(volwidget)    
    right_layout:add(batwidget)
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),
    awful.key({ modkey,"Mod4"}, "f", function () awful.util.spawn("firefox") end),
    awful.key({ modkey,"Mod4"}, "g", function () awful.util.spawn("google-chrome") end),
    awful.key({ modkey,"Mod4"}, "t", function () awful.util.spawn("transmission-gtk") end),
    awful.key({ modkey,"Mod4"}, "m", function () awful.util.spawn("thunderbird") end),
    awful.key({ modkey,"Mod4"}, "!", function () awful.util.spawn("pcmanfm") end),
    awful.key({ modkey,"Mod4"}, "l", function () awful.util.spawn("xscreensaver-command --lock") end),

    -- Multimedia keys
    awful.key({ }, "XF86AudioRaiseVolume", function () volumectl("up") end),
    awful.key({ }, "XF86AudioLowerVolume", function () volumectl("down") end),
    awful.key({ }, "XF86AudioMute", function () volumectl("mute") end),
    awful.key({ }, "XF86AudioNext", function () mpdctl("next") end),
    awful.key({ }, "XF86AudioPrev", function () mpdctl("prev") end),
    awful.key({ }, "XF86AudioStop", function () mpdctl("stop") end),
    awful.key({ }, "XF86AudioPlay", function () mpdctl("toggle") end),


    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 3 of screen 1.
    { rule = { class = "Firefox" },
      properties = { tag = tags[1][3] } },
    -- Set Google-Chrome to always map on tags number 3 of screen 1.
    { rule = { instance = "google-chrome" },
      properties = { tag = tags[1][3] } },
    -- Set Transmission to always map on tags number 5 of screen 1.
     { rule = { instance = "transmission-gtk" },
      properties = { tag = tags[1][4] } },
    -- Set Terminator to always map on tags number 2 of screen 1.
     { rule = { instance = "terminator" },
      properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Démarrage
   awful.util.spawn("setxkbmap fr &")
   os.execute("wicd-gtk &")
   os.execute("conky -d &")
   os.execute("python2.7 pynetsoul.py &")
   os.execute("./QNetSoul &")
   os.execute("dropboxd &")
   os.execute("xscreensaver -no-splash &")
-- }}}

