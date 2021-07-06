-- awesome_mode: api-level=4:screen=on
-----------------------------------------------------------
-- Includes {{{1

pcall(require, 'luarocks.loader')
-- Standard awesome libraries
local gears = require('gears') -- Utilities such as color parsing and objects
require('awful.autofocus')
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
-- Clock {{{1

function M.get_widget()
  local time = wibox.widget {
    {
      {
        format = '<span color="' .. beautiful.purple .. '"> : %a %d. %b %Y %H:%M</span>',
        widget = wibox.widget.textclock,
      },
      top = 2 * beautiful.useless_gap,
      bottom = 2 * beautiful.useless_gap,
      left = 5 * beautiful.useless_gap,
      right = 5 * beautiful.useless_gap,
      widget = wibox.container.margin,
    },
    bg = beautiful.nord1,
    fg = beautiful.fg_normal,
    shape = gears.shape.rounded_bar,
    widget = wibox.container.background,
  }
  return time
end

return M

-- }}}1
