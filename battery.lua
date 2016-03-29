--Battery

local wibox = require("wibox")
local awful = require("awful")

batterywidget = wibox.widget.textbox()    
batterywidget:set_text(" | Battery | ")    
batterywidgettimer = timer({ timeout = 0.5 })    
batterywidgettimer:connect_signal("timeout",    
				  function()    
				     fh = assert(io.popen("acpi | cut -d, -f 2,3 -", "r"))    
				     batterywidget:set_text("Batt:" .. fh:read("*l"))    
				     fh:close()    
  end    
)    

batterywidgettimer:start()

