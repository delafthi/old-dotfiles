-- awesome_mode: api-level=4:screen=on
-----------------------------------------------------------
-- Includes {{{1

-- Standard awesome libraries
local gears = require('gears') -- Utilities such as color parsing and objects
local awful = require('awful') -- Everything related to window management
-- Widget and layout library
local wibox = require('wibox') -- Awesome own generic widget framework
-- Theme handling library
local beautiful = require('beautiful') -- Awesome theme module
-- Adjust pixel size to dpi
local dpi = require('beautiful.xresources').apply_dpi
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local M = {}

-----------------------------------------------------------
-- Wibar {{{1

function M.set(s)
  local gap = 2 * beautiful.useless_gap
  -- Create screen specific widgets
  s.mytaglist = require('widgets.taglist').get_widget(s)
  s.mylayoutbox = require('widgets.layoutbox').get_widget(s)
  s.mytasklist = require('widgets.tasklist').get_widget(s)
  -- Create non-specific widgets
  local spacer = require('widgets.spacer').get_widget()
  local menulauncher = require('widgets.menulauncher').get_widget()
  local cpuinfo = require('widgets.cpuinfo').get_widget()
  local meminfo = require('widgets.meminfo').get_widget()
  local time = require('widgets.time').get_widget()
  local systray = require('widgets.systray').get_widget(s)
  -- Remove old wibox
  if s.mywibar ~= nil then s.mywibar:remove() end
  s.mywibar = awful.wibar {
    border_width = 0,
    border_color = 'rgb(00000000)',
    visible = true,
    screen = s,
    shape = gears.shape.rectangle,
    bg = 'rgb(00000000)',
    fg = 'rgb(00000000)',
  }
  -- Set wibox struts
  s.mywibar:struts {
    top = beautiful.wibar_height - gap,
    right = dpi(0),
    left = dpi(0),
    bottom = dpi(0),
  }
  -- Add widgets to the wibox
  s.mywibar:setup {
    {
      {
        {
          { -- Left widgets
            s.mytaglist.widget,
            s.mylayoutbox,
            wibox.widget.separator {
              forced_width = dpi(0),
              color = beautiful.wibar_bg,
            },
            spacing = 3 * beautiful.useless_gap,
            spacing_widget = spacer,
            layout = wibox.layout.fixed.horizontal(),
          },
          {-- Middle widgets
            s.mytasklist,
            spacing = 3 * beautiful.useless_gap,
            spacing_widget = spacer,
            layout = wibox.layout.fixed.horizontal
          },
          { -- Right widgets
            cpuinfo,
            meminfo,
            time,
            systray,
            spacing = 3 * beautiful.useless_gap,
            spacing_widget = spacer,
            layout = wibox.layout.fixed.horizontal(),
          },
          layout = wibox.layout.align.horizontal,
        },
        margins = gap,
        widget = wibox.container.margin,
      },
      bg = beautiful.wibar_bg,
      fg = beautiful.wibar_fg,
      shape = beautiful.wibar_shape,
      widget = wibox.container.background,
    },
    margins = gap,
    widget = wibox.container.margin,
  }
end

return M

-- }}}1
