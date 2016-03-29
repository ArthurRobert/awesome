--Volume widget
local wibox = require("wibox")
local awful = require("awful")

volumewidget = wibox.widget.textbox()
volumewidget:set_align("right")

function update_volume(widget)
   local fd = io.popen("amixer sget Master")
   local status = fd:read("*all")
   fd:close()

   local volume = tonumber(string.match(status, "(%d?%d?%d)%%")) / 100
   -- volume = string.format("% 3d", volume

--   local volumedb = string.match(status, "(%d%d%.%d%d)")
   
   status = string.match(status, "%[(o[^%]]*)%]")
 
   -- starting colour
   local sr, sg, sb = 0xFF, 0x00, 0x00
   -- ending colour
   local er, eg, eb = -0xFF, 0xFF, 0x00

--   local ir = math.floor(volume * (er - sr) + sr)
--   local ig = math.floor(volume * (eg - sg) + sg)
--   local ib = math.floor(volume * (eb - sb) + sb)

   local ir = math.floor(sr + (volume *  er))
   local ig = math.floor(sg + (volume *  eg))
   local ib = math.floor(sb + (volume *  eb))

interpol_colour = string.format("%.2x%.2x%.2x", ir, ig, ib)
   if string.find(status, "on", 1, true) then
--       volume = "Vol: <span color='#" .. interpol_colour .. "'>" .. volume .. " </span>"
         volume = "Vol: " .. volume
   else
       volume = "Vol: <span color='red' >M</span>"
   end
   widget:set_markup(volume)
end

update_volume(volumewidget)

mytimer = timer({ timeout = 0.2 })
mytimer:connect_signal("timeout", function () update_volume(volumewidget) end)
mytimer:start()