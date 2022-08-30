-- awesome_mode: api-level=4:screen=on
-----------------------------------------------------------
-- Includes {{{1
-- Widget and layout library
local wibox = require("wibox") -- Awesome own generic widget framework
-- Standard awesome libraries
local gears = require("gears") -- Utilities such as color parsing and objects
-- Theme handling library
local beautiful = require("beautiful") -- Awesome theme module
-- Adjust pixel size to dpi
local dpi = require("beautiful.xresources").apply_dpi

local M = {}

-----------------------------------------------------------
-- Wibar {{{1

function M.set(s)
  local gap = beautiful.useless_gap

  -- Remove old wibox in case of a restart
  if s.mywibar ~= nil then
    s.mywibar.visible = false
    s.mywibar:detach_cb()
  end
  -- Set new wibar
  s.mywibar = wibox({
    border_width = beautiful.wibar_border_width,
    border_color = beautiful.wibar_border_color,
    ontop = beautiful.wibar_ontop,
    cursor = beautiful.wibar_cursor,
    visible = true,
    opacity = beautiful.wibar_opacity,
    type = beautiful.wibar_type,
    x = s.geometry.x,
    y = s.geometry.y,
    width = s.geometry.width - 2 * beautiful.wibar_border_width,
    height = beautiful.wibar_height,
    screen = s,
    shape = beautiful.wibar_shape,
    bg = beautiful.wibar_bg,
    bgimage = beautiful.wibar_bgimage,
    fg = beautiful.wibar_fg,
  })

  s.mywibar:struts({
    top = beautiful.wibar_height + 2 * beautiful.wibar_border_width,
  })

  -- Create screen specific widgets
  s.mytaglist = require("ui.panels.taglist").get_widget(s)
  s.mylayoutbox = require("ui.panels.layoutbox").get_widget(s)
  s.mytasklist = require("ui.panels.tasklist").get_widget(s)
  -- Create non-specific widgets
  local spacer = require("ui.panels.spacer").get_widget()
  local cpuinfo = require("ui.panels.cpuinfo").get_widget()
  local meminfo = require("ui.panels.meminfo").get_widget()
  local systray = require("ui.panels.systray").get_widget(s)
  local time = require("ui.panels.time").get_widget()

  -- Add widgets to the wibox
  s.mywibar:setup({
    { -- Left widgets
      time,
      spacing = beautiful.wibar_spacing,
      spacing_widget = spacer,
      layout = wibox.layout.fixed.horizontal,
    },
    { -- Middle widgets
      {
        s.mytaglist.widget,
        valign = "center",
        halign = "center",
        widget = wibox.container.place,
      },
      spacing = beautiful.wibar_spacing,
      spacing_widget = spacer,
      layout = wibox.layout.flex.horizontal,
    },
    { -- Right widgets
      {
        {
          cpuinfo,
          meminfo,
          systray,
          s.mylayoutbox,
          layout = wibox.layout.fixed.horizontal,
        },
        bg = beautiful.nord3,
        fg = beautiful.nord4,
        shape = gears.shape.rounded_bar,
        widget = wibox.container.background,
      },
      spacing = beautiful.wibar_spacing,
      spacing_widget = spacer,
      layout = wibox.layout.align.horizontal,
    },
    spacing = beautiful.wibar_spacing,
    spacing_widget = spacer,
    layout = wibox.layout.align.horizontal,
  })
end

return M

-- }}}1
