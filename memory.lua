local awful = require("awful")
local wibox = require("wibox")
local vicious = require("vicious")


memwidget = wibox.widget.graph()
memwidget:set_width(50)
memwidget:set_background_color("#494B4F")
memwidget:set_color({
  type = "linear",
  from = { 0, 0 },
  to = { 50, 0 },
  stops = {
    { 0, "#569fff" },
    { 0.5, "#88A175" },
    { 1, "#AECF96" }
  }
})
vicious.register(memwidget, vicious.widgets.mem, "$1", 5)


mem_widget = wibox.container.mirror(memwidget, {horizontal = true})
