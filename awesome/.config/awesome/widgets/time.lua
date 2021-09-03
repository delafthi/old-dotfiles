-- awesome_mode: api-level=4:screen=on
-----------------------------------------------------------
-- Includes {{{1
pcall(require, 'luarocks.loader')
-- Standard awesome libraries
local gears = require('gears') -- Utilities such as color parsing and objects
local awful = require('awful') -- Everything related to window management
require('awful.autofocus')
-- Widget and layout library
local wibox = require('wibox') -- Awesome own generic widget framework
-- Theme handling library
local beautiful = require('beautiful') -- Awesome theme module
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require('awful.hotkeys_popup.keys')

local M = {}

-----------------------------------------------------------
-- Clock {{{1

function M.get_widget()
  local time = wibox.widget({
    {
      { format = ' :%a %d. %b %Y %H:%M', widget = wibox.widget.textclock },
      left = 5 * beautiful.useless_gap,
      right = 5 * beautiful.useless_gap,
      widget = wibox.container.margin,
    },
    bg = beautiful.nord9,
    fg = beautiful.nord0,
    shape = gears.shape.rounded_bar,
    widget = wibox.container.background,
  })
  return time
end

-----------------------------------------------------------
-- Calendar {{{1

function M.get_popup(widget)
  local p = awful.popup({
    widget = wibox.widget({
      date = os.date('*t'),
      font = beautiful.font,
      widget = wibox.widget.calendar.year,
    }),
    preferred_anchors = 'middle',
    border_color = beautiful.border_color,
    border_width = beautiful.border_width,
    shape = gears.shape.infobubble,
  })
  p:bind_to_widget(widget)
  return p
end

return M

-- }}}1
