-- awesome_mode: api-level=4:screen=on
-----------------------------------------------------------
-- Includes {{{1
pcall(require, "luarocks.loader")
-- Standard awesome libraries
local gears = require("gears") -- Utilities such as color parsing and objects
local awful = require("awful") -- Everything related to window management
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful") -- Awesome theme module
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
local twopane = require("layouts.twopane")
-- Wibar
local wibar = require("wibar")

-----------------------------------------------------------
-- Error handling {{{1

-- Check if awesome encountered an error during startup and fell back to another
-- config
naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification({
    urgency = "critical",
    title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
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

-- Default applications
local terminal = "kitty" -- default terminal
local browser = "brave" -- default browser
local visual_filemanager = "pcmanfm" -- default graphical fm
local filemanager = "ranger" -- default fm
local filemanager_cmd = terminal .. " -e " .. filemanager -- command to open the fm
local editor = os.getenv("EDITOR") or "nvim" -- default editor
local editor_cmd = terminal .. " -e " .. editor -- command to open the editor

-- Default mod key
local modkey = "Mod4" -- Meta key

-----------------------------------------------------------
-- Layouts {{{1
tag.connect_signal("request::default_layouts", function()
  awful.layout.append_default_layouts({
    -- awful.layout.suit.floating,
    awful.layout.suit.tile,
    twopane, -- awful.layout.suit.tile.left,
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

-----------------------------------------------------------
-- Key bindings {{{1

-- General Awesome keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ modkey }, "Escape", function()
    awful.spawn("slock")
  end, {
    description = "lock the session",
    group = "awesome",
  }),
  awful.key({ modkey, "Control" }, "q", function()
    awesome.quit()
  end, {
    description = "quit awesome",
    group = "awesome",
  }),
  awful.key({ modkey, "Shift" }, "q", function()
    awesome.restart()
  end, {
    description = "restart awesome",
    group = "awesome",
  }),
  awful.key({ modkey, "Shift" }, "slash", function()
    hotkeys_popup.show_help(nil, awful.screen.focused())
  end, {
    description = "display help",
    group = "awesome",
  }),
  awful.key({ modkey }, "Return", function()
    awful.spawn(terminal)
  end, {
    description = "open a terminal",
    group = "launcher",
  }),
  awful.key({ modkey }, "s", function()
    awful.spawn(terminal)
  end, {
    description = "open a scratchpad terminal",
    group = "launcher",
  }),
  awful.key({ modkey, "Shift" }, "Return", function()
    awful.spawn("rofi -show run")
  end, {
    description = "open rofi",
    group = "launcher",
  }),
  awful.key({ modkey }, "b", function()
    awful.spawn(browser)
  end, {
    description = "open a browser",
    group = "launcher",
  }),
  awful.key({ modkey }, "f", function()
    awful.spawn(filemanager_cmd)
  end, {
    description = "open a file manager",
    group = "launcher",
  }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ modkey }, "space", function()
    local screen = awful.screen.focused()
    awful.layout.inc(1, screen)
  end, {
    description = "next layout",
    group = "layout",
  }),
  awful.key({ modkey, "Shift" }, "space", function()
    local screen = awful.screen.focused()
    awful.layout.inc(-1, screen)
  end, {
    description = "previous layout",
    group = "layout",
  }),
  awful.key({ modkey }, "h", function()
    awful.tag.incmwfact(-0.03, nil)
  end, {
    description = "minmize the master pane",
    group = "layout",
  }),
  awful.key({ modkey }, "l", function()
    awful.tag.incmwfact(0.03, nil)
  end, {
    description = "maximize the master pane",
    group = "layout",
  }),
  awful.key({ modkey }, "comma", function()
    awful.tag.incnmaster(-1, nil, true)
  end, {
    description = "decrease number of master clients",
    group = "layout",
  }),
  awful.key({ modkey }, "period", function()
    awful.tag.incnmaster(1, nil, true)
  end, {
    description = "increase number of master clients",
    group = "layout",
  }),
})

-- Tag  related key bindings
for i = 1, 9 do
  awful.keyboard.append_global_keybindings({
    -- View tag only
    awful.key({ modkey }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, {
      description = "switch tag ",
      group = "tag",
    }), -- Toggle tag display
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
      local tag = client.focus.screen.tags[i]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end, {
      description = "move client tag ",
      group = "tag",
    }),
  })
end
awful.keyboard.append_global_keybindings({
  awful.key({ modkey, "Shift" }, "t", function()
    awful.screen.focused().mytaglist.prompt:run()
  end),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ modkey }, "Tab", function()
    awful.client.focus.byidx(1)
  end, {
    description = "focus next client",
    group = "client",
  }),
  awful.key({ modkey, "Shift" }, "Tab", function()
    awful.client.focus.byidx(-1)
  end, {
    description = "focus previous client",
    group = "client",
  }),
  awful.key({ modkey }, "j", function()
    awful.client.focus.byidx(1)
  end, {
    description = "focus next client",
    group = "client",
  }),
  awful.key({ modkey }, "k", function()
    awful.client.focus.byidx(-1)
  end, {
    description = "focus previous client",
    group = "client",
  }),
  awful.key({ modkey, "Shift" }, "j", function()
    awful.client.swap.byidx(1)
  end, {
    description = "swap with next client",
    group = "client",
  }),
  awful.key({ modkey, "Shift" }, "k", function()
    awful.client.swap.byidx(-1)
  end, {
    description = "swap with previous client",
    group = "client",
  }),
})

-- Screen related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ modkey }, "w", function()
    awful.screen.focus_bydirection("left", awful.screen.focused())
  end, {
    description = "focus left screen",
    group = "screen",
  }),
  awful.key({ modkey }, "e", function()
    awful.screen.focus_bydirection("right", awful.screen.focused())
  end, {
    description = "focus right screen",
    group = "screen",
  }),
})

-- Volume control keybindings
awful.keyboard.append_global_keybindings({
  awful.key({}, "XF86AudioRaiseVolume", function()
    os.execute("amixer -c 1 sset Speaker 5%+")
  end, {
    description = "raise volume",
    group = "system",
  }),
  awful.key({}, "XF86AudioLowerVolume", function()
    os.execute("amixer -c 1 sset Speaker 5%-")
  end, {
    description = "lower volume",
    group = "system",
  }),
  awful.key({}, "XF86AudioMute", function()
    os.execute("amixer -c 1 sset Speaker toggle")
  end, {
    description = "toggle mute",
    group = "system",
  }),
})

-- Set client related key bindings
client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({ modkey }, "q", function(c)
      c:kill()
    end, {
      description = "kill the current client",
      group = "client",
    }),
    awful.key({ modkey }, "m", function(c)
      awful.client.setmaster(c)
    end, {
      description = "set the current client as master",
      group = "client",
    }),
    awful.key({ modkey, "Shift" }, "m", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, {
      description = "toggle fullscreen mode for the current client",
      group = "client",
    }),
    awful.key({ modkey }, "p", function(c)
      c.floating = not c.floating
      c:raise()
    end, {
      description = "toggle floating for the current client",
      group = "client",
    }),
    awful.key({ modkey, "Shift" }, "w", function(c)
      c:move_to_screen(c.screen.index - 1)
    end, {
      description = "move focused client to the left screen",
      group = "client",
    }),
    awful.key({ modkey, "Shift" }, "e", function(c)
      c:move_to_screen(c.screen.index + 1)
    end, {
      description = "move focused client to the right screen",
      group = "client",
    }),
  })
end)

-----------------------------------------------------------
-- Mouse bindings {{{1

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c)
      c:activate({ context = "mouse_click" })
    end),
    awful.button({ modkey }, 1, function(c)
      c:activate({ context = "mouse_click", action = "mouse_move" })
    end),
    awful.button({ modkey }, 3, function(c)
      c:activate({ context = "mouse_click", action = "mouse_resize" })
    end),
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
      border_width = beautiful.border_width,
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
    },
  })
  -- Floating clients
  ruled.client.append_rule({
    id = "floating",
    rule_any = { class = { "Pavucontrol", "Xmessage" }, type = { "dialog" } },
    properties = { floating = true },
  })
end)

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
  c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
  c.skip_taskbar = true
  if c.floating == true then
    c.border_color = beautiful.border_floating
  else
    c.border_color = beautiful.border_normal
  end
end)

-----------------------------------------------------------
-- Create environment {{{1
--
local function set_random_wallpaper(s)
  local wallpaper_path = "~/.local/share/backgrounds"
  local fileending = ".jpg"
  local f = io.popen(
    "fd -d 1 --regex " .. fileending .. " " .. wallpaper_path,
    "r"
  )
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
  math.random()
  math.random()
  math.random() -- Pop some random numbers, before using the generator
  return gears.wallpaper.maximized(files[math.random(0, length)], s, true)
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
