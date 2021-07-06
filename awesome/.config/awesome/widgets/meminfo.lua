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
-- Adjust pixel size to dpi
local dpi = require('beautiful.xresources').apply_dpi
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local M = {}

-----------------------------------------------------------
-- Mem info {{{1

local mem = {}

function M.get_widget()
  local meminfo = wibox.widget {
    {
      {
        id = 'watch_role',
        awful.widget.watch([[bash -c 'grep '^Mem.' /proc/meminfo']], 1,
          function(widget, stdout)
            for line in stdout:gmatch('[^\r\n]+') do
              if line:sub(1, #'Mem') == 'Mem' then
                local name, number, _ = line:match('(%w+):%s+(%d+)%s(%w+)')
                mem[name] = number
              end
            end
            mem['MemUsed'] = tonumber(mem['MemTotal'] == nil and 0 or mem['MemTotal']) - tonumber(mem['MemAvailable'] == nil and 0 or mem['MemAvailable'])
            widget:set_markup_silently(string.format('<span color=%q> : %2.f%%</span>', beautiful.yellow, mem['MemUsed']/mem['MemTotal']*100))
          end),
        layout = wibox.layout.fixed.horizontal,
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
  return meminfo
end

return M

-- }}}1
