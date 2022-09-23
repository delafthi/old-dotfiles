--- Awesome Configuration
--- ~~~~~~~~~~~~~~~~~~~~~
--- based on https://github.com/rxyhn/yoru

pcall(require, "luarocks.loader")
local gears = require("gears")
local beautiful = require("beautiful")

--- Theme
--- ~~~~~

local theme_dir = gears.filesystem.get_configuration_dir() .. "themes/"
beautiful.init(theme_dir .. "theme.lua")

--- Configurations
--- ~~~~~~~~~~~~~~

require("config")

--- Modules
--- ~~~~~~~

require("modules")

--- UI
--- ~~

require("ui")

--- Garbage
--- ~~~~~~~

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
gears.timer({
  timeout = 5,
  autostart = true,
  call_now = true,
  callback = function()
    collectgarbage("collect")
  end,
})
