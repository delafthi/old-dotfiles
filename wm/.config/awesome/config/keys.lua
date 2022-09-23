local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local naughty = require("naughty")
local decorations = require("ui.decorations")
local bling = require("modules.bling")
local helpers = require("helpers")
local apps = require("config.apps")

---@diagnostic disable
local awesome = awesome
local client = client
---@diagnostic enable

--- Local vars
--- ~~~~~~~~~~

mod = "Mod4" -- Meta key
shift = "Shift" -- Shift key
ctrl = "Control" -- Control key

--- Global keybindings
--- ~~~~~~~~~~~~~~~~~~

awful.keyboard.append_global_keybindings({

  --- Applications
  --- ~~~~~~~~~~~~

  --- Terminal
  awful.key({ mod }, "Return", function()
    awful.spawn(apps.default.terminal)
  end, {
    description = "open terminal",
    group = "app",
  }),

  --- App launcher
  awful.key({ mod, shift }, "Return", function()
    awful.spawn(apps.default.app_launcher)
  end, {
    description = "open app launcher",
    group = "app",
  }),

  --- Password manager
  awful.key({ mod, shift }, "p", function()
    awful.spawn(apps.default.password_manager)
  end, {
    description = "open password manager",
    group = "app",
  }),

  --- Bibliography manager
  awful.key({ mod, shift }, "b", function()
    awful.spawn(apps.default.bibliography_manager)
  end, {
    description = "open bibliography manager",
    group = "app",
  }),

  --- Web browser
  awful.key({ mod }, "b", function()
    awful.spawn(apps.default.web_browser)
  end, {
    description = "open web browser",
    group = "app",
  }),

  --- WM
  --- ~~

  --- Restart
  awful.key({ mod, shift }, "r", function()
    awesome.restart()
  end, {
    description = "reload awesome",
    group = "awesome",
  }),

  --- Quit
  awful.key({ mod, shift }, "q", function()
    awesome.quit()
  end, {
    description = "quit awesome",
    group = "awesome",
  }),

  --- Show help
  awful.key({ mod, shift }, "slash", hotkeys_popup.show_help, {
    description = "show help",
    group = "awesome",
  }),

  --- Client
  --- ~~~~~~

  --- Change focus
  awful.key({ mod }, "j", function()
    awful.client.focus.byidx(1)
  end, {
    description = "focus next client",
    group = "client",
  }),
  awful.key({ mod }, "k", function()
    awful.client.focus.byidx(-1)
  end, {
    description = "focus previous client",
    group = "client",
  }),

  -- Swap client order
  awful.key({ mod, shift }, "j", function()
    awful.client.swap.byidx(1)
  end, {
    description = "swap with next client",
    group = "client",
  }),
  awful.key({ mod, shift }, "k", function()
    awful.client.swap.byidx(-1)
  end, {
    description = "swap with previous client",
    group = "client",
  }),

  --- Resize client
  awful.key({ mod, ctrl }, "k", function()
    helpers.client.resize_client(client.focus, "up")
  end, { description = "resize to the up", group = "client" }),
  awful.key({ mod, ctrl }, "j", function()
    helpers.client.resize_client(client.focus, "down")
  end, { description = "resize to the down", group = "client" }),
  awful.key({ mod, ctrl }, "h", function()
    helpers.client.resize_client(client.focus, "left")
  end, { description = "resize to the left", group = "client" }),
  awful.key({ mod, ctrl }, "l", function()
    helpers.client.resize_client(client.focus, "right")
  end, { description = "resize to the right", group = "client" }),

  --- Hotkeys
  --- ~~~~~~

  --- Brightness Control
  awful.key({}, "XF86MonBrightnessUp", function()
    awful.spawn("brightnessctl set 5%+ -q", false)
    awesome.emit_signal("widget::brightness")
    awesome.emit_signal("module::brightness_osd:show", true)
  end, { description = "increase brightness", group = "hotkeys" }),
  awful.key({}, "XF86MonBrightnessDown", function()
    awful.spawn("brightnessctl set 5%- -q", false)
    awesome.emit_signal("widget::brightness")
    awesome.emit_signal("module::brightness_osd:show", true)
  end, { description = "decrease brightness", group = "hotkeys" }),

  --- Volume control
  awful.key({}, "XF86AudioRaiseVolume", function()
    awful.spawn("amixer sset Speaker 5%+", false)
    awesome.emit_signal("widget::volume")
    awesome.emit_signal("module::volume_osd:show", true)
  end, { description = "increase volume", group = "hotkeys" }),
  awful.key({}, "XF86AudioLowerVolume", function()
    awful.spawn("amixer sset Speaker 5%-", false)
    awesome.emit_signal("widget::volume")
    awesome.emit_signal("module::volume_osd:show", true)
  end, { description = "decrease volume", group = "hotkeys" }),
  awful.key({}, "XF86AudioMute", function()
    awful.spawn("amixer sset Speaker toggle", false)
  end, { description = "mute volume", group = "hotkeys" }),

  --- Screenshot
  awful.key({ mod, ctrl }, "c", function()
    awful.spawn.easy_async_with_shell(
      apps.utils.full_screenshot,
      function() end
    )
  end, { description = "take a full screenshot", group = "hotkeys" }),
  awful.key({ mod, shift }, "c", function()
    awful.spawn.easy_async_with_shell(
      apps.utils.area_screenshot,
      function() end
    )
  end, { description = "take a area screenshot", group = "hotkeys" }),

  --- Info panel
  awful.key({ mod }, "i", function()
    awesome.emit_signal("info_panel::toggle", awful.screen.focused())
  end, { description = "open the notification panel", group = "hotkeys" }),

  --- Info panel
  awful.key({ mod }, "c", function()
    awesome.emit_signal("central_panel::toggle", awful.screen.focused())
  end, { description = "open the notification panel", group = "hotkeys" }),

  --- Notification panel
  awful.key({ mod }, "n", function()
    awesome.emit_signal("notification_panel::toggle", awful.screen.focused())
  end, { description = "open the notification panel", group = "hotkeys" }),

  --- Lockscreen
  awful.key({ mod }, "Escape", function()
    awful.spawn(apps.default.session_locker)
  end, { description = "lock the session", group = "hotkeys" }),
})

--- Client key bindings
--- ~~~~~~~~~~~~~~~~~~~

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({

    --- Toggle titlebars (for all visible clients in selected tag)
    awful.key({ mod, shift }, "t", function()
      local clients = awful.screen.focused().clients
      for _, c in pairs(clients) do
        decorations.cycle(c)
      end
    end, { description = "toggle titlebar", group = "client" }),

    --- Toggle floating
    awful.key(
      { mod },
      "f",
      awful.client.floating.toggle,
      { description = "toggle floating", group = "client" }
    ),

    --- Toggle fullscreen
    awful.key({ mod, shift }, "m", function()
      client.focus.fullscreen = not client.focus.fullscreen
      client.focus:raise()
    end, {
      description = "toggle fullscreen",
      group = "client",
    }),

    --- Keep on top
    awful.key({ mod, shift }, "t", function(c)
      c.ontop = not c.ontop
    end, { description = "toggle ontop", group = "client" }),

    --- Sticky
    awful.key({ mod, shift }, "s", function(c)
      c.sticky = not c.sticky
    end, { description = "toggle sticky", group = "client" }),

    --- Close window
    awful.key({ mod }, "d", function(c)
      c:kill()
    end, {
      description = "kill current client",
      group = "client",
    }),

    --- Center window
    awful.key({ mod }, "c", function(c)
      awful.placement.centered(
        c,
        { honor_workarea = true, honor_padding = true }
      )
    end, { description = "center window", group = "client" }),

    --- Window switcher
    awful.key({ mod }, "Tab", function()
      awesome.emit_signal("window_switcher::turn_on")
    end, { description = "toggle window switcher", group = "client" }),

    --- Move or swap by direction
    awful.key({ mod }, "m", function(c)
      awful.client.setmaster(c)
    end, {
      description = "set the current client as master",
      group = "client",
    }),
  })
end)

--- Layout
--- ~~~~~~

awful.keyboard.append_global_keybindings({

  --- Change layouts
  awful.key({ mod }, "space", function()
    local screen = awful.screen.focused()
    awesome.emit_signal("module::layout_osd:show", true)
    awful.layout.inc(1, screen)
  end, {
    description = "next layout",
    group = "layout",
  }),
  awful.key({ mod, shift }, "space", function()
    local screen = awful.screen.focused()
    awesome.emit_signal("module::layout_osd:show", true)
    awful.layout.inc(-1, screen)
  end, {
    description = "previous layout",
    group = "layout",
  }),

  --- Change number of master clients
  awful.key({ mod }, "comma", function()
    awful.tag.incnmaster(-1, nil, true)
  end, {
    description = "decrease number of master clients",
    group = "layout",
  }),
  awful.key({ mod }, "period", function()
    awful.tag.incnmaster(1, nil, true)
  end, {
    description = "increase number of master clients",
    group = "layout",
  }),
})

--- Move through workspaces
--- ~~~~~~~~~~~~~~~~~~~~~~~

awful.keyboard.append_global_keybindings({

  --- Switch workspaces
  awful.key({
    modifiers = { mod },
    keygroup = "numrow",
    description = "only view tag",
    group = "tags",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  }),

  --- View toggle workspaces
  awful.key({
    modifiers = { mod, ctrl },
    keygroup = "numrow",
    description = "toggle tag",
    group = "tags",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  }),

  --- Shift clients and move to workspaces
  awful.key({
    modifiers = { mod, shift },
    keygroup = "numrow",
    description = "move focused client to tag",
    group = "tags",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  }),
})

--- Screen
--- ~~~~~~

--- Switch screens
awful.keyboard.append_global_keybindings({
  awful.key({ mod }, "h", function()
    awful.screen.focus_bydirection("left", awful.screen.focused())
  end, {
    description = "focus left screen",
    group = "screen",
  }),
  awful.key({ mod }, "l", function()
    awful.screen.focus_bydirection("right", awful.screen.focused())
  end, {
    description = "focus right screen",
    group = "screen",
  }),
})

--- Switch screens with clients
client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({ mod, shift }, "h", function(c)
      local sel = c.screen
      local target = sel:get_next_in_direction("left")
      if target then
        return c:move_to_screen(target)
      end
    end, {
      description = "move focused client to the left screen",
      group = "client",
    }),
    awful.key({ mod, shift }, "l", function(c)
      local sel = c.screen
      local target = sel:get_next_in_direction("right")
      c:move_to_screen(target)
    end, {
      description = "move focused client to the right screen",
      group = "client",
    }),
  })
end)

--- Mouse bindings on desktop
--- ~~~~~~~~~~~~~~~~~~~~~~~~~

local main_menu = require("ui.main-menu")

awful.mouse.append_global_mousebindings({

  --- Left click
  awful.button({}, 1, function()
    naughty.destroy_all_notifications()
    awesome.emit_signal("info_panel::toggle_off", awful.screen.focused())
    awesome.emit_signal("central_panel::toggle_off", awful.screen.focused())
    awesome.emit_signal(
      "notification_panel::toggle_off",
      awful.screen.focused()
    )
  end),

  --- Middle click
  awful.button({}, 2, function()
    awesome.emit_signal("central_panel::toggle", awful.screen.focused())
  end),

  --- Right click
  awful.button({
    modifiers = {},
    button = 3,
    on_press = function()
      main_menu:toggle()
    end,
  }),
})

--- Mouse buttons on the client
--- ~~~~~~~~~~~~~~~~~~~~~~~~~~~

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c)
      c:activate({ context = "mouse_click" })
      awesome.emit_signal("info_panel::toggle_off", awful.screen.focused())
      awesome.emit_signal("central_panel::toggle_off", awful.screen.focused())
      awesome.emit_signal(
        "notification_panel::toggle_off",
        awful.screen.focused()
      )
    end),
    awful.button({ mod }, 1, function(c)
      c:activate({ context = "mouse_click", action = "mouse_move" })
      awesome.emit_signal("info_panel::toggle_off", awful.screen.focused())
      awesome.emit_signal("central_panel::toggle_off", awful.screen.focused())
      awesome.emit_signal(
        "notification_panel::toggle_off",
        awful.screen.focused()
      )
    end),
    awful.button({ mod }, 3, function(c)
      c:activate({ context = "mouse_click", action = "mouse_resize" })
      awesome.emit_signal("info_panel::toggle_off", awful.screen.focused())
      awesome.emit_signal("central_panel::toggle_off", awful.screen.focused())
      awesome.emit_signal(
        "notification_panel::toggle_off",
        awful.screen.focused()
      )
    end),
  })
end)
