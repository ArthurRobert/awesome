local wibox         = require("wibox")
local awful         = require("awful")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local module_path = (...):match ("(.+/)[^/]+$") or ""
local vicious = require("vicious")

function initWidget(widget)
   -- Initialize widget 
   local font = beautiful.font

   local cputext = wibox.widget.textbox()
   cputext:set_text("CPU: ")

   cpugraph = awful.widget.graph()

   cpugraph:set_width(50)
   cpugraph:set_background_color("#494B4F")
   cpugraph:set_color({ type = "linear", from = { 0, 0 }, to = { 10,0 }, stops = { {0, "#FF5656"}, {0.5, "#88A175"}, 
   {1, "#AECF96" }}})

   vicious.register(cpugraph, vicious.widgets.cpu, "$1")

   widget:add(cputext)
   widget:add(cpugraph)

end

cpuwidget = wibox.layout.fixed.horizontal()
initWidget(cpuwidget)
return cpuwidget
