local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local naughty = require("naughty")
local decorations = require("ui.decorations")
local bling = require("modules.bling")
local playerctl_daemon = require("signal.playerctl")
local machi = require("modules.layout-machi")
local helpers = require("helpers")
local apps = require("configuration.apps")

-- Local vars
-- ~~~~~~~~~~
local modkey = "Mod4" -- Meta key

-- Global keybindings
-- ~~~~~~~~~~~~~~~~~~
awful.keyboard.append_global_keybindings({

  -- WM
  -- ~~
  awful.key({ modkey }, "Escape", function()
    awful.spawn("slock")
  end, {
    description = "lock the session",
    group = "awesome",
  }),
  awful.key({ modkey, "Control" }, "d", function()
    awesome.quit()
  end, {
    description = "quit awesome",
    group = "awesome",
  }),
  awful.key({ modkey, "Shift" }, "r", function()
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

  -- Applications
  -- ~~~~~~~~~~~~
  awful.key({ modkey }, "Return", function()
    awful.spawn("wezterm")
  end, {
    description = "open a terminal",
    group = "launcher",
  }),
  awful.key({ modkey, "Shift" }, "Return", function()
    awful.spawn("rofi -show run")
  end, {
    description = "open rofi",
    group = "launcher",
  }),
  awful.key({ modkey, "Shift" }, "p", function()
    awful.spawn("bwmenu --auto-lock 300 -c 15")
  end, {
    description = "open bitwarden-rofi",
    group = "launcher",
  }),
  awful.key({ modkey, "Shift" }, "b", function()
    awful.spawn("papis --pick-lib -s picktool rofi open title:*")
  end, {
    description = "open bibliography database",
    group = "launcher",
  }),
  awful.key({ modkey, "Shift" }, "g", function()
    awful.spawn("eidolon menu")
  end, {
    description = "open game-launcher menu",
    group = "launcher",
  }),
  awful.key({ modkey }, "b", function()
    awful.spawn("luakit")
  end, {
    description = "open a browser",
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
  awful.key({ modkey }, "comma", function()
    awful.tag.incmwfact(-0.03, nil)
  end, {
    description = "minmize the master pane",
    group = "layout",
  }),
  awful.key({ modkey }, "period", function()
    awful.tag.incmwfact(0.03, nil)
  end, {
    description = "maximize the master pane",
    group = "layout",
  }),
  awful.key({ modkey, "Shift" }, "comma", function()
    awful.tag.incnmaster(-1, nil, true)
  end, {
    description = "decrease number of master clients",
    group = "layout",
  }),
  awful.key({ modkey, "Shift" }, "period", function()
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
  awful.key({ modkey }, "h", function()
    awful.screen.focus_bydirection("left", awful.screen.focused())
  end, {
    description = "focus left screen",
    group = "screen",
  }),
  awful.key({ modkey }, "l", function()
    awful.screen.focus_bydirection("right", awful.screen.focused())
  end, {
    description = "focus right screen",
    group = "screen",
  }),
})

local volumecfg = {
  device = "default",
  channel = "Speaker",
}

-- Volume control keybindings
awful.keyboard.append_global_keybindings({
  awful.key({}, "XF86AudioRaiseVolume", function()
    os.execute(
      "amixer -D "
        .. volumecfg.device
        .. " sset "
        .. volumecfg.channel
        .. " 5%+"
    )
  end, {
    description = "raise volume",
    group = "system",
  }),
  awful.key({}, "XF86AudioLowerVolume", function()
    os.execute(
      "amixer -D "
        .. volumecfg.device
        .. " sset "
        .. volumecfg.channel
        .. " 5%-"
    )
  end, {
    description = "lower volume",
    group = "system",
  }),
  awful.key({}, "XF86AudioMute", function()
    os.execute(
      "amixer -D "
        .. volumecfg.device
        .. " sset "
        .. volumecfg.channel
        .. " toggle"
    )
  end, {
    description = "toggle mute",
    group = "system",
  }),
})

-- Set client related key bindings
client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({ modkey }, "s", function(c)
      local name = "scratchpad"
      if c.name ~= name then
        -- Returns the existing client if it exists
        c = awful.spawn.raise_or_spawn("wezterm" .. " -T=" .. name, {
          name = name,
          floating = true,
          skip_taskbar = true,
          placement = awful.placement.centered + awful.placement.no_offscreen,
          width = awful.screen.focused().geometry.width * 0.8,
          height = awful.screen.focused().geometry.height * 0.8,
        }, function(c)
          return c.name == name
        end, name)
        -- Set minimized to false if we get the existing client
        if c then
          c.minimized = false
        end
      else
        c.minimized = true
      end
    end, {
      description = "open a scratchpad terminal",
      group = "launcher",
    }),
    awful.key({ modkey }, "d", function(c)
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
    awful.key({ modkey }, "f", function(c)
      c.floating = not c.floating
      c:raise()
    end, {
      description = "toggle floating for the current client",
      group = "client",
    }),
    awful.key({ modkey, "Shift" }, "h", function(c)
      local sel = c.screen
      local target = sel:get_next_in_direction("left")
      if target then
        return c:move_to_screen(target)
      end
    end, {
      description = "move focused client to the left screen",
      group = "client",
    }),
    awful.key({ modkey, "Shift" }, "l", function(c)
      local sel = c.screen
      local target = sel:get_next_in_direction("right")
      c:move_to_screen(target)
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
      c:activate({
        context = "mouse_click",
        raise = true,
        switch_to_tag = true,
      })
    end),
    awful.button({ modkey }, 1, function(c)
      c:activate({
        context = "mouse_click",
        raise = true,
        switch_to_tag = true,
        action = "mouse_move",
      })
    end),
    awful.button({ modkey }, 3, function(c)
      c:activate({
        context = "mouse_click",
        raise = true,
        switch_to_tag = true,
        action = "mouse_resize",
      })
    end),
  })
end)
