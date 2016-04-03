--Volume widget
local wibox         = require("wibox")
local awful         = require("awful")
local beautiful     = require("beautiful")

volumewidget = wibox.widget.textbox()

function update_volume(widget)

   local font = beautiful.font
   
   local fd = io.popen("amixer sget Master")
   local status = fd:read("*all")
   fd:close()

   local volume = tonumber(string.match(status, "(%d?%d?%d)%%"))

   status = string.match(status, "%[(o[^%]]*)%]")
 
   if string.find(status, "on", 1, true) then   
      msg = "Vol: "..volume.."%"
      
   else
      msg = "Vol: <span color='red' >M</span>"
   end

   widget:set_text(msg)
      
end

update_volume(volumewidget, ...)

mytimer = timer({ timeout = 0.5 })
mytimer:connect_signal("timeout", function () update_volume(volumewidget) end)
mytimer:start()

return volumewidget