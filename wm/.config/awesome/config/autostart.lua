local awful = require("awful")
local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local helpers = require("helpers")

local function autostart_apps()
  --- Compositor
  helpers.run.check_if_running("picom --experimental-backends", nil, function()
    awful.spawn(
      "picom --experimental-backends --config "
        .. config_dir
        .. "configuration/picom.conf",
      false
    )
  end)
  --- Other stuff
  helpers.run.run_once_grep("blueman-applet")
  helpers.run.run_once_grep("nm-applet")
end

autostart_apps()
