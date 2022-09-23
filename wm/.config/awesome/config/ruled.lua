local awful = require("awful")
local beautiful = require("beautiful")
local ruled = require("ruled")
local helpers = require("helpers")

--- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

ruled.client.connect_signal("request::rules", function()
  --- Global
  ruled.client.append_rule({
    id = "global",
    rule = {},
    properties = {
      raise = true,
      --- Disable maximization and minimization of windows
      maximized = false,
      maximized_horizontal = false,
      maximized_vertical = false,
      minimized = false,

      size_hints_honor = false,
      honor_workarea = true,
      honor_padding = true,
      screen = awful.screen.focused,
      focus = awful.client.focus.filter,
      titlebars_enabled = beautiful.titlebar_enabled,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  })

  --- Tasklist order
  ruled.client.append_rule({
    id = "tasklist_order",
    rule = {},
    properties = {},
    callback = awful.client.setslave,
  })

  --- Float
  ruled.client.append_rule({
    id = "floating",
    rule_any = {
      class = {
        "Nm-connection-editor",
        "origin",
        "Pavucontrol",
      },
      role = {
        "AlarmWindow",
        "conversation",
        "GtkFileChooserDialog",
        "pop-up",
      },
      type = {
        "dialog",
      },
    },
    properties = {
      floating = true,
      placement = helpers.client.centered_client_placement,
    },
  })

  --- Centered
  ruled.client.append_rule({
    id = "centered",
    rule_any = {
      type = {
        "dialog",
      },
      role = {
        "conversation",
        "GtkFileChooserDialog",
      },
    },
    properties = { placement = helpers.client.centered_client_placement },
  })
end)
