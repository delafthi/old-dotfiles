local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")

--- Quick Settings
--- ~~~~~~~~~~~~~~

local quick_settings_text = wibox.widget({
  font = beautiful.font .. beautiful.font_size,
  markup = helpers.ui.colorize_text("Quick Settings", beautiful.lighter_grey),
  valign = "center",
  widget = wibox.widget.textbox,
})

--- Widgets
local bluetooth = require("ui.panels.central-panel.quick-settings.bluetooth")
local blue_light = require("ui.panels.central-panel.quick-settings.blue-light")
local microphone = require("ui.panels.central-panel.quick-settings.microphone")
local floating_mode =
  require("ui.panels.central-panel.quick-settings.floating-mode")
local screenshot_area =
  require("ui.panels.central-panel.quick-settings.screenshot").area
local screenshot_full =
  require("ui.panels.central-panel.quick-settings.screenshot").full

--- 4x4 grid of button
local buttons = wibox.widget({
  blue_light,
  floating_mode,
  screenshot_area,
  bluetooth,
  microphone,
  screenshot_full,
  horizontal_expand = true,
  spacing = 24,
  forced_num_cols = 3,
  forced_num_rows = 3,
  layout = wibox.layout.grid,
})

local widget = wibox.widget({
  {
    {
      {
        quick_settings_text,
        helpers.ui.vertical_pad(dpi(20)),
        {
          buttons,
          left = dpi(18),
          right = dpi(18),
          widget = wibox.container.margin,
        },
        layout = wibox.layout.fixed.vertical,
      },
      top = dpi(9),
      bottom = dpi(9),
      left = dpi(10),
      right = dpi(10),
      widget = wibox.container.margin,
    },
    widget = wibox.container.background,
    forced_height = dpi(210),
    forced_width = dpi(350),
    bg = beautiful.widget_bg,
    shape = helpers.ui.rrect(beautiful.border_radius),
  },
  margins = dpi(10),
  color = "#FF000000",
  widget = wibox.container.margin,
})

return widget
