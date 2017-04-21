local awful = require("awful")
local wibox = require("wibox")
local vicious = require("vicious")


swapwidget = wibox.widget.graph()
swapwidget:set_width(15)
swapwidget:set_background_color("#494B4F")
swapwidget:set_color({
  type = "linear",
  from = { 0, 0 },
  to = { 15, 0 },
  stops = {
    { 0, "#ff5688" },
    { 0.5, "#88A175" },
    { 1, "#AECF96" }
  }
})
vicious.register(swapwidget, vicious.widgets.mem, "$5", 7)


swap_widget = wibox.container.mirror(swapwidget, {horizontal = true})
