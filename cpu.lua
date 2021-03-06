local awful = require("awful")
local wibox = require("wibox")
local vicious = require("vicious")


cpuwidget = wibox.widget.graph()
cpuwidget:set_width(50)
cpuwidget:set_background_color("#494B4F")
cpuwidget:set_color({
  type = "linear",
  from = { 0, 0 },
  to = { 50, 0 },
  stops = {
    { 0, "#FF5656" },
    { 0.5, "#88A175" },
    { 1, "#AECF96" }
  }
})
vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 3)


cpu_widget = wibox.container.mirror(cpuwidget, {horizontal = true})

cpu_tooltip = awful.tooltip({objects = {cpu_widget}})
vicious.register(cpu_tooltip, vicious.widgets.mem, "CPU: $1%", i)
