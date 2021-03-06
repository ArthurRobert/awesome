-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")
-- Themes define colours, icons, and wallpapers
beautiful.init("~/.config/awesome/themes/zenburn/theme.lua")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local vicious = require("vicious")
local net_widgets = require("net_widgets")
local volume = require("volume")

local cpuwidget = require("cpuwidget")

local orglendar = require("orglendar")
--orglendar.files = { "~/org/work.org" }
orglendar.files = { "/home/arthur/org/work.org" }



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

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "emacs -nw"
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
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({01, 02, 03, 05, 08, 13, 21}, s, layouts[2])
end
-- }}}


client.add_signal("focus", function(c)
                              c.border_color = beautiful.border_focus
                              c.opacity = 1
                           end)
client.add_signal("unfocus", function(c)
                                c.border_color = beautiful.border_normal
                                c.opacity = 0.5
                             end)



-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

--new terminal
--mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
--                                    { "open terminal", terminal },
--                                    { "reboot", "reboot" },
--				    { "powerOff", "poweroff" }                                   
--                                  }
--                        })


myawesomemenu = {
  {"edit config",           editor .." ~/.config/awesome/rc.lua"},
  {"edit theme",            editor .." ~/.config/awesome/themes/powerarrow/theme.lua"},
  {"hibernate",             "sudo pm-hibernate"},
  {"restart",               awesome.restart },
  {"reboot",                "sudo reboot"},
  {"quit",                  awesome.quit }
}
mydevmenu = {
-- --  {" Android SDK Updater",  "android", beautiful.android_icon},
   {" Eclipse",              "/home/arthur/eclipse/eclipse", beautiful.eclipse_icon},
   {" Emacs",                "emacs", beautiful.emacs_icon},
--   {" GHex",                 "ghex", beautiful.ghex_icon},	
--   {" IntellijIDEA",         "/home/rom/Tools/idea-IU-123.72/bin/idea.sh", beautiful.ideaUE_icon},
--   {" Kdiff3",               "kdiff3", beautiful.kdiff3_icon},
--   {" Meld",                 "meld", beautiful.meld_icon},
--   {" pgAdmin",              "pgadmin3", beautiful.pgadmin3_icon},
--   {" Qt Creator",           "qtcreator", beautiful.qtcreator_icon},
--   {" RubyMine",             "/home/rom/Tools/rubymine.run", beautiful.rubymine_icon},
--   {" SublimeText",          "sublime_text", beautiful.sublime_icon},
--   {" Tkdiff",               "tkdiff", beautiful.tkdiff_icon}
}
 mygraphicsmenu = {
  -- {" Character Map",        "gucharmap", beautiful.gucharmap_icon},
  -- {" Fonty Python",         "fontypython", beautiful.fontypython_icon},
  -- {" gcolor2",              "gcolor2", beautiful.gcolor_icon},
  -- {" Gpick",                "gpick", beautiful.gpick_icon},
   {" Gimp",                 "gimp", beautiful.gimp_icon},
  -- {" Inkscape",             "inkscape", beautiful.inkscape_icon},
  -- {" recordMyDesktop",      "gtk-recordMyDesktop", beautiful.recordmydesktop_icon},
  -- {" Screengrab",           "screengrab", beautiful.screengrab_icon},
  -- {" Xmag",                 "xmag", beautiful.xmag_icon},
  -- {" XnView",               "/home/rom/Tools/XnView/xnview.sh", beautiful.xnview_icon
  }
mymultimediamenu = {
  -- {" Audacious",            "audacious", beautiful.audacious_icon},
  -- {" DeadBeef",             "deadbeef", beautiful.deadbeef_icon},
  -- {" UMPlayer",             "umplayer", beautiful.umplayer_icon},
   {" VLC",                  "vlc", beautiful.vlc_icon}
}
myofficemenu = {
   {" Acrobat Reader",       "acroread", beautiful.acroread_icon},
  -- {" DjView",               "djview", beautiful.djview_icon},
  -- {" KChmViewer",           "kchmviewer", beautiful.kchmviewer_icon},
  -- {" Leafpad",              "leafpad", beautiful.leafpad_icon},
   {" LibreOffice Base",     "libreoffice --base", beautiful.librebase_icon},
   {" LibreOffice Calc",     "libreoffice --calc", beautiful.librecalc_icon},
   {" LibreOffice Draw",     "libreoffice --draw", beautiful.libredraw_icon},
   {" LibreOffice Impress",  "libreoffice --impress", beautiful.libreimpress_icon},
   {" LibreOffice Math",     "libreoffice --math", beautiful.libremath_icon},	
   {" LibreOffice Writer",   "libreoffice --writer", beautiful.librewriter_icon},
  -- {" Qpdfview",             "qpdfview", beautiful.qpdfview_icon},
  -- {" ScanTailor",           "scantailor", beautiful.scantailor_icon},
  -- {" Sigil",                "sigil", beautiful.sigil_icon}, 
  -- {" TeXworks",             "texworks", beautiful.texworks_icon}
}

mywebmenu = {
   {" Chromium",             "chromium-browser", beautiful.chromium_icon},
  -- {" Droppox",              "dropbox", beautiful.dropbox_icon},
  -- {" Dwb",                  "dwb", beautiful.dwb_icon},
  -- {" Filezilla",            "filezilla", beautiful.filezilla_icon},
  -- {" Firefox",              "firefox", beautiful.firefox_icon},
  -- {" Gajim",                "gajim", beautiful.gajim_icon},
  -- {" QuiteRSS",             "quiterss", beautiful.quiterss_icon},
  -- {" Luakit",               "luakit", beautiful.luakit_icon},
  -- {" Opera",                "opera", beautiful.opera_icon},
  -- {" Qbittorrent",          "qbittorrent", beautiful.qbittorrent_icon},
   {" Skype",                "skype", beautiful.skype_icon},
  -- {" Tor",                  "/home/rom/Tools/tor-browser_en-US/start-tor-browser", beautiful.vidalia_icon},
  -- {" Thunderbird",          "thunderbird", beautiful.thunderbird_icon},
  -- {" Weechat",              "lilyterm -x weechat-curses", beautiful.weechat_icon}
}

mysettingsmenu = {
  -- {" CUPS Settings",        "sudo system-config-printer", beautiful.cups_icon},
  -- {" JDK6 Settings",        "/opt/sun-jdk-1.6.0.37/bin/ControlPanel", beautiful.java_icon},
  -- {" JDK7 Settings",        "/opt/oracle-jdk-bin-1.7.0.9/bin/ControlPanel", beautiful.java_icon},
  -- {" Nvidia Settings",      "sudo nvidia-settings", beautiful.nvidia_icon},
  -- {" Qt Configuration",     "qtconfig", beautiful.qt_icon},    
  -- {" WICD",                 terminal .. " -x wicd-curses", beautiful.wicd_icon}
}



 mymainmenu = awful.menu({ items = { 
   { " Awesome",             myawesomemenu, beautiful.awesome_icon },
--   {" books",                mybooksmenu, beautiful.books_icon},
   {" development",          mydevmenu},
--   {" education",            myedumenu, beautiful.myedu_icon},
  {" graphics",             mygraphicsmenu},
  {" multimedia",           mymultimediamenu},	    
  {" office",               myofficemenu},
--  {" tools",                mytoolsmenu, beautiful.mytoolsmenu_icon},
  {" web",                  mywebmenu},
--  {" settings",             mysettingsmenu, beautiful.mysettingsmenu_icon},
--  {" calc",                 "/usr/bin/gcalctool", beautiful.galculator_icon},
--  {" htop",                 terminal .. " -x htop", beautiful.htop_icon},
--  {" sound",                "qasmixer", beautiful.wmsmixer_icon},
--  {" file manager",         "spacefm", beautiful.spacefm_icon},
--  {" root terminal",        "sudo " .. terminal, beautiful.terminalroot_icon},
--  {" terminal",             terminal, beautiful.terminal_icon} 
}
})




mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()
orglendar.register(mytextclock)


-- Keyboard map indicator and changer
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { {"fr", ""}, { "us", "" }, {"ca",""}, {"it", ""}, { "de", "" } }
kbdcfg.current = 1  -- us is our default layout
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.widget:set_text(" " .. kbdcfg.layout[kbdcfg.current][1] .. " ")
kbdcfg.switch = function ()
   kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
   local t = kbdcfg.layout[kbdcfg.current]
   kbdcfg.widget:set_text(" " .. t[1] .. " ")
   os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end

screenTimer = timer({ timeout = 5})
screenTimer:connect_signal("timeout", 
				function()
				  io.popen("sh /home/arthur/test.sh")
				end
				)

screenTimer:start()

--Separator
sepWidget = wibox.widget.textbox()
sepWidget:set_text(" | ")

--Net widget
net_wireless = net_widgets.wireless({interface="wlp6s0", timeout = 1})

--Memory usage
-- Initialize widget
memwidget = wibox.widget.textbox()
-- Register widget
vicious.register(memwidget, vicious.widgets.mem, "MEM: $1%", 10)

-- Mouse bindings
kbdcfg.widget:buttons(
   awful.util.table.join(awful.button({ }, 1, function () kbdcfg.switch() end))
)


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
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    -- Add widget to your layout
    right_layout:add(net_wireless)
    right_layout:add(sepWidget)
    right_layout:add(volumewidget)
    right_layout:add(sepWidget)
    right_layout:add(memwidget)
    right_layout:add(sepWidget)
    right_layout:add(cpuwidget)
    right_layout:add(sepWidget)
    right_layout:add(kbdcfg.widget)
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

    -- Volume
    awful.key({ }, "XF86AudioRaiseVolume", function ()
		 awful.util.spawn("amixer set Master 9%+") end),
    awful.key({ }, "XF86AudioLowerVolume", function ()
		 awful.util.spawn("amixer set Master 9%-") end),
    awful.key({ }, "XF86AudioMute", function ()
		 awful.util.spawn("amixer sset Master toggle") end),
    
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
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
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
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
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
