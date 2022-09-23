local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local wbutton = require("ui.widgets.button")

---@diagnostic disable
local awesome = awesome
---@diagnostic enable

--- Clock Widget
--- ~~~~~~~~~~~~

return function(s)
  local accent_color = beautiful.white
  local clock = wibox.widget({
    widget = wibox.widget.textclock,
    format = "%a %b %e %l:%M %p",
    align = "center",
    valign = "center",
    font = beautiful.font_bold .. beautiful.font_size,
  })

  clock.markup = helpers.ui.colorize_text(clock.text, accent_color)
  clock:connect_signal("widget::redraw_needed", function()
    clock.markup = helpers.ui.colorize_text(clock.text, accent_color)
  end)

  local widget = wbutton.elevated.state({
    child = wibox.widget({
      clock,
      margins = { left = dpi(8), right = dpi(8) },
      widget = wibox.container.margin,
    }),
    normal_bg = beautiful.black,
    paddings = dpi(0),
    on_release = function()
      awesome.emit_signal("info_panel::toggle", s)
    end,
  })

  return wibox.widget({
    widget,
    margins = { top = dpi(5), bottom = dpi(5) },
    widget = wibox.container.margin,
  })
end
