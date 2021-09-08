-- awesome_mode: api-level=4:screen=on
-----------------------------------------------------------
-- Includes {{{1
-- Widget and layout library
local wibox = require('wibox') -- Awesome own generic widget framework
-- Standard awesome libraries
local gears = require('gears') -- Utilities such as color parsing and objects
-- Theme handling library
local beautiful = require('beautiful') -- Awesome theme module
-- Adjust pixel size to dpi
local dpi = require('beautiful.xresources').apply_dpi

local M = {}

-----------------------------------------------------------
-- Wibar {{{1

function M.set(s)
  local gap = 2 * beautiful.useless_gap

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
    x = s.geometry.x + gap,
    y = s.geometry.y + gap,
    width = s.geometry.width - 2 * gap,
    height = beautiful.wibar_height,
    screen = s,
    shape = beautiful.wibar_shape,
    bg = beautiful.wibar_bg,
    bgimage = beautiful.wibar_bgimage,
    fg = beautiful.wibar_fg,
  })

  s.mywibar:struts({ top = beautiful.wibar_height + gap })

  -- Create screen specific widgets
  s.mytaglist = require('widgets.taglist').get_widget(s)
  s.mylayoutbox = require('widgets.layoutbox').get_widget(s)
  s.mytasklist = require('widgets.tasklist').get_widget(s)
  -- Create non-specific widgets
  local spacer = require('widgets.spacer').get_widget()
  local cpuinfo = require('widgets.cpuinfo').get_widget()
  local meminfo = require('widgets.meminfo').get_widget()
  local time = require('widgets.time').get_widget()
  local systray = require('widgets.systray').get_widget(s)

  -- Add widgets to the wibox
  s.mywibar:setup({
    {
      { -- Left widgets
        s.mytaglist.widget,
        s.mylayoutbox,
        wibox.widget.separator({
          forced_width = dpi(0),
          color = beautiful.wibar_bg,
        }),
        spacing = beautiful.wibar_spacing,
        spacing_widget = spacer,
        layout = wibox.layout.fixed.horizontal(),
      },
      { -- Middle widgets
        s.mytasklist,
        spacing = beautiful.wibar_spacing,
        spacing_widget = spacer,
        layout = wibox.layout.fixed.horizontal,
      },
      { -- Right widgets
        cpuinfo,
        meminfo,
        time,
        systray,
        spacing = beautiful.wibar_spacing,
        spacing_widget = spacer,
        layout = wibox.layout.fixed.horizontal(),
      },
      layout = wibox.layout.align.horizontal,
    },
    margins = gap,
    widget = wibox.container.margin,
  })
end

return M

-- }}}1
