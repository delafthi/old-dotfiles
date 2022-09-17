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

-- Nofification library
local naughty = require("naughty") -- Notifications
-- Declarative object management
local ruled = require("ruled")
-- Hotkeys popup
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Custom layout
local twopane = require("modules.twopane")
-- Wibar
local wibar = require("ui.panels.wibar")
local awful = require("awful") -- Everything related to window management
require("awful.autofocus")
-- Theme handling library

-----------------------------------------------------------
-- Error handling {{{1

-- Check if awesome encountered an error during startup and fell back to another
-- config
naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification({
    urgency = "critical",
    title = "Oops, an error happened"
      .. (startup and " during startup!" or "!"),
    message = message,
  })
end)

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then
      return
    end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err),
    })
    in_error = false
  end)
end

-----------------------------------------------------------
-- Variable definitions {{{1

-- Initialize the theme
beautiful.init(
  gears.filesystem.get_configuration_dir() .. "themes/nord/theme.lua"
)

-----------------------------------------------------------
-- Layouts {{{1
tag.connect_signal("request::default_layouts", function()
  awful.layout.append_default_layouts({
    -- awful.layout.suit.floating,
    twopane, -- awful.layout.suit.tile.left,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
  })
end)

-- Client rules {{{1

-- All new appearing clients will match these rules
ruled.client.connect_signal("request::rules", function()
  -- All clients
  ruled.client.append_rule({
    id = "global",
    rule = {},
    properties = {
      border_width = beautiful.border_width_normal,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      raise = true,
      screen = awful.screen.preferred,
      shape = beautiful.shape,
      maximized = false,
      maximized_horizontal = false,
      maximized_vertical = false,
      minimized = false,
      size_hints_honor = false,
    },
  })
  -- Floating clients
  ruled.client.append_rule({
    id = "floating_resized",
    rule_any = {
      class = { "Pavucontrol" },
      type = { "popup_menu", "menu" },
    },
    properties = {
      floating = true,
      placement = awful.placement.centered + awful.placement.no_offscreen,
      width = awful.screen.focused().geometry.width * 0.8,
      height = awful.screen.focused().geometry.height * 0.8,
      size_hints_honor = true,
    },
  })
  ruled.client.append_rule({
    id = "floating_misc",
    rule_any = {
      type = {
        "dialog",
        "toolbar",
        "utility",
        "dropdown_menu",
      },
    },
    properties = {
      floating = true,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      size_hints_honor = true,
    },
  })
end)

-- Special rules
ruled.client.append_rule({
  id = "origin",
  rule_any = {
    class = { "origin.exe" },
  },
  properties = {
    floating = true,
    placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    size_hints_honor = true,
  },
})

-----------------------------------------------------------
-- Notifications {{{1

ruled.notification.connect_signal("request::rules", function()
  -- All notifications
  ruled.notification.append_rule({
    rule = {},
    properties = { screen = awful.screen.preferred, implicit_timeout = 5 },
  })
end)

naughty.connect_signal("request::display", function(n)
  naughty.layout.box({ notification = n })
end)

-----------------------------------------------------------
-- Signals {{{1

-- Focus signals
client.connect_signal("focus", function(c)
  c.skip_taskbar = false
  c.border_color = beautiful.border_color_active
end)
client.connect_signal("unfocus", function(c)
  c.skip_taskbar = true
  if c.floating then
    c.border_color = beautiful.border_color_floating
  else
    c.border_color = beautiful.border_color_normal
  end
end)

-----------------------------------------------------------
-- Create environment {{{1
--
local function set_random_wallpaper(s)
  local wallpaper_path = "~/.local/share/backgrounds"
  local fileending = ".jpg"
  local f =
    io.popen("fd -d 1 --regex " .. fileending .. " " .. wallpaper_path, "r")
  local files = {}
  local length = 0
  local line = "begin"
  while line ~= nil do
    line = f:read("*l")
    table.insert(files, line)
    length = length + 1
  end
  f:close()
  math.randomseed(os.time()) -- Set the random seed
  -- Pop some random numbers, before using the generator
  local tmp = math.random()
  tmp = math.random()
  tmp = math.random()
  return gears.wallpaper.maximized(files[math.random(1, length)], s, true)
end

screen.connect_signal("request::wallpaper", function(s)
  set_random_wallpaper(s)
end)

screen.connect_signal("request::desktop_decoration", function(s)
  -- Create taglist
  -- Each screen has its own tag table
  awful.tag(
    { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
    s,
    awful.layout.layouts[1]
  )
  -- Re/set wibox
  wibar.set(s)
end)

-- }}}1
