local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")
local vicious = require("vicious")

date_widget = wibox.widget.textbox()
vicious.register(date_widget, vicious.widgets.date, "%H:%M:%S %d/%m/%Y ", 1)

-- weather_widget:connect_signal("mouse::enter", function()
-- 	awful.spawn.easy_async([[bash -c "ncal -3bC"]], function(stdout, stderr, reason, exit_code)
-- 	    date_notification = naughty.notify{
--         	text = stdout,
-- 	        timeout = 0,
-- 	        width = auto,
-- 	    }
--     end)
-- end)

-- weather_widget:connect_signal("mouse::leave", function()
--     naughty.destroy(date_notification, naughty.notificationClosedReason.dismissedByUser)
-- end)

