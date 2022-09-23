local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")

---@diagnostic disable
local awesome = awesome
local mod = mod
local screen = screen
---@diagnostic enable

--- Layout list
--- ~~~~~~~~~~~

local layout_list = awful.widget.layoutlist({
  source = awful.widget.layoutlist.source.default_layouts, --- DOC_HIDE
  spacing = dpi(24),
  base_layout = wibox.widget({
    spacing = dpi(24),
    forced_num_cols = 4,
    layout = wibox.layout.grid.vertical,
  }),
  widget_template = {
    {
      {
        id = "icon_role",
        forced_height = dpi(68),
        forced_width = dpi(68),
        widget = wibox.widget.imagebox,
      },
      margins = dpi(24),
      widget = wibox.container.margin,
    },
    id = "background_role",
    forced_width = dpi(68),
    forced_height = dpi(68),
    widget = wibox.container.background,
  },
})

screen.connect_signal("request::desktop_decoration", function(s)
  local s = s or {}
  s.show_layout_osd = false

  s.layout_osd_overlay = awful.popup({
    type = "notification",
    screen = s,
    widget = wibox.widget({
      { layout_list, margins = dpi(24), widget = wibox.container.margin },
      bg = beautiful.layoutlist_bg,
      shape = helpers.ui.rrect(beautiful.border_radius),
      widget = wibox.container.background,
    }),
    placement = awful.placement.centered,
    ontop = true,
    visible = false,
    bg = beautiful.layoutlist_bg .. "00",
  })

  -- Reset timer on mouse hover
  s.layout_osd_overlay:connect_signal("mouse::enter", function()
    awful.screen.focused().show_layout_osd = true
    awesome.emit_signal("module::layout_osd:rerun")
  end)
end)

local hide_osd = gears.timer({
  timeout = beautiful.osd_timeout,
  autostart = true,
  callback = function()
    local focused = awful.screen.focused()
    focused.layout_osd_overlay.visible = false
    focused.show_layout_osd = false
  end,
})

awesome.connect_signal("module::layout_osd:rerun", function()
  if hide_osd.started then
    hide_osd:again()
  else
    hide_osd:start()
  end
end)

local placement_placer = function()
  local focused = awful.screen.focused()
  local layout_osd = focused.layout_osd_overlay
  awful.placement.centered(layout_osd)
end

awesome.connect_signal("module::layout_osd:show", function(bool)
  placement_placer()
  awful.screen.focused().layout_osd_overlay.visible = bool
  if bool then
    awesome.emit_signal("module::layout_osd:rerun")
    awesome.emit_signal("module::brightness_osd:show", false)
    awesome.emit_signal("module::volume_osd:show", false)
  else
    if hide_osd.started then
      hide_osd:stop()
    end
  end
end)
