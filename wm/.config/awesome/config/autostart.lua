local awful = require("awful")
local helpers = require("helpers")

local function autostart_apps()
  --- Mouse
  awful.spawn("xsetroot -cursor_name left_ptr", false)
  helpers.run.run_once_grep("unclutter --timeout 10")

  -- Lockscreen
  helpers.run.run_once_grep("xss-lock slock &")

  --- Compositor
  helpers.run.check_if_running("picom --experimental-backends", nil, function()
    awful.spawn("picom --experimental-backends", false)
  end)

  --- Other stuff
  helpers.run.run_once_grep("blueman-applet")
  helpers.run.run_once_grep("nm-applet")
  helpers.run.run_once_grep("pcmanfm -d")
end

autostart_apps()
