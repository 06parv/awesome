local wibox = require("wibox")
local http = require("socket.http")
local json = require("json")
local naughty = require("naughty")

local city = "Nantes,fr"
local open_map_key = "79c5694d10214f6452bae47ad29fb4c2"
local path_to_icons = "/home/gagaro/.config/awesome/arc-icon-theme/Arc/status/symbolic/"

local icon_widget = wibox.widget {
    {
        id = "icon",
        resize = false,
        widget = wibox.widget.imagebox,
    },
    layout = wibox.container.margin(brightness_icon, 0, 0, 3),
    set_image = function(self, path)
        self.icon.image = path
    end,
}

local temp_widget = wibox.widget{
    font = "Play 9",
    widget = wibox.widget.textbox,
}

weather_widget = wibox.widget {
    temp_widget,
    icon_widget,
    layout = wibox.layout.fixed.horizontal,
}

-- helps to map openWeatherMap icons to Arc icons
local icon_map = {
    ["01d"] = "weather-clear-symbolic.svg",
    ["02d"] = "weather-few-clouds-symbolic.svg",
    ["03d"] = "weather-clouds-symbolic.svg",
    ["04d"] = "weather-overcast-symbolic.svg",
    ["09d"] = "weather-showers-scattered-symbolic.svg",
    ["10d"] = "weather-showers-symbolic.svg",
    ["11d"] = "weather-storm-symbolic.svg",
    ["13d"] = "weather-snow-symbolic.svg",
    ["50d"] = "weather-fog-symbolic.svg",
    ["01n"] = "weather-clear-night-symbolic.svg",
    ["02n"] = "weather-few-clouds-night-symbolic.svg",
    ["03n"] = "weather-clouds-night-symbolic.svg",
    ["04n"] = "weather-overcast-symbolic.svg",
    ["09n"] = "weather-showers-scattered-symbolic.svg",
    ["10n"] = "weather-showers-symbolic.svg",
    ["11n"] = "weather-storm-symbolic.svg",
    ["13n"] = "weather-snow-symbolic.svg",
    ["50n"] = "weather-fog-symbolic.svg"
}

-- handy function to convert temperature from Kelvin to Celcius
function to_celcius(kelvin)
    return string.format("%.1f", (tonumber(kelvin) - 273.15))
end

local weather_timer = timer({ timeout = 600 })
local resp

weather_timer:connect_signal("timeout", function ()
    local resp_json = http.request("http://api.openweathermap.org/data/2.5/weather?q=" .. city .."&appid=" .. open_map_key)
    if (resp_json ~= nil) then
        resp = json.decode(resp_json)
        icon_widget.image = path_to_icons .. icon_map[resp.weather[1].icon]
        temp_widget:set_text(to_celcius(resp.main.temp) .. "°C ")
    end
end)
weather_timer:start()
weather_timer:emit_signal("timeout")

weather_widget:connect_signal("mouse::enter", function()
    notification = naughty.notify{
        icon = path_to_icons .. icon_map[resp.weather[1].icon],
        icon_size=20,
        text = 
        '<big>' .. resp.weather[1].main .. ' (' .. resp.weather[1].description .. ')</big><br>' .. 
        '<b>Humidity:</b> ' .. resp.main.humidity .. '%<br>' ..
        '<b>Temperature: </b>' .. to_celcius(resp.main.temp) .. ' °C<br>' ..
        '<b>Pressure: </b>' .. resp.main.pressure .. ' hPa<br>' ..
        '<b>Clouds: </b>' .. resp.clouds.all .. '%<br>' ..
        '<b>Wind: </b>' .. resp.wind.speed .. ' m/s',
        timeout = 0,
        width = 200,
    }
end)

weather_widget:connect_signal("mouse::leave", function()
    naughty.destroy(notification, naughty.notificationClosedReason.dismissedByUser)
end)

