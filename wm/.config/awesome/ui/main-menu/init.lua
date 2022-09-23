local awful = require("awful")
local beautiful = require("beautiful")
local menu = require("ui.widgets.menu")
local hotkeys_popup = require("awful.hotkeys_popup")
local apps = require("config.apps")
local focused = awful.screen.focused()

---@diagnostic disable
local awesome = awesome
---@diagnostic enable

--- Beautiful right-click menu
--- ~~~~~~~~~~~~~~~~~~~~~~~~~~

local instance = nil

local function awesome_menu()
  return menu({
    menu.button({
      icon = { icon = " ", font = beautiful.font },
      text = "Show Help",
      on_press = function()
        hotkeys_popup.show_help(nil, awful.screen.focused())
      end,
    }),
    menu.button({
      icon = { icon = " ", font = beautiful.font },
      text = "Manual",
      on_press = function()
        awful.spawn(apps.default.terminal .. " -e man awesome")
      end,
    }),
    menu.button({
      icon = { icon = " ", font = beautiful.font },
      text = "Edit Config",
      on_press = function()
        awful.spawn(apps.default.text_editor .. " " .. awesome.conffile)
      end,
    }),
    menu.button({
      icon = { icon = " ", font = beautiful.font },
      text = "Restart",
      on_press = function()
        awesome.restart()
      end,
    }),
    menu.button({
      icon = { icon = " ", font = beautiful.font },
      text = "Quit",
      on_press = function()
        awesome.quit()
      end,
    }),
  })
end

local function widget()
  return menu({
    menu.button({
      icon = { icon = " ", font = beautiful.font },
      text = "Applications",
      on_press = function()
        awful.spawn(apps.default.app_launcher, false)
      end,
    }),
    menu.button({
      icon = { icon = " ", font = beautiful.font },
      text = "Terminal",
      on_press = function()
        awful.spawn(apps.default.terminal, false)
      end,
    }),
    menu.button({
      icon = { icon = " ", font = beautiful.font },
      text = "Web Browser",
      on_press = function()
        awful.spawn(apps.default.web_browser, false)
      end,
    }),
    menu.button({
      icon = { icon = " ", font = beautiful.font },
      text = "File Manager",
      on_press = function()
        awful.spawn(apps.default.file_manager, false)
      end,
    }),
    menu.separator(),
    menu.button({
      icon = { icon = " ", font = beautiful.font },
      text = "Dashboard",
      on_press = function()
        awesome.emit_signal("central_panel::toggle", focused)
      end,
    }),
    menu.button({
      icon = { icon = " ", font = beautiful.font },
      text = "Info Center",
      on_press = function()
        awesome.emit_signal("info_panel::toggle", focused)
      end,
    }),
    menu.button({
      icon = { icon = " ", font = beautiful.font },
      text = "Notification Center",
      on_press = function()
        awesome.emit_signal("notification_panel::toggle", focused)
      end,
    }),
    menu.separator(),
    menu.sub_menu_button({
      icon = { icon = " ", font = beautiful.font },
      text = "AwesomeWM",
      sub_menu = awesome_menu(),
    }),
  })
end

if not instance then
  instance = widget()
end
return instance
