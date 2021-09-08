-- awesome_mode: api-level=4:screen=on
-----------------------------------------------------------
-- Includes {{{1
-- Standard awesome libraries
local awful = require('awful') -- Everything related to window management
-- Widget and layout library
local wibox = require('wibox') -- Awesome own generic widget framework
-- Theme handling library
local beautiful = require('beautiful') -- Awesome theme module

local M = {}

-----------------------------------------------------------
-- Mem info {{{1

local mem = {}

function M.get_widget()
  local meminfo = wibox.widget({
    {
      {
        id = 'watch_role',
        awful.widget.watch(
          [[bash -c 'grep '^Mem.' /proc/meminfo']],
          1,
          function(widget, stdout)
            for line in stdout:gmatch('[^\r\n]+') do
              if line:sub(1, #'Mem') == 'Mem' then
                local name, number, _ = line:match('(%w+):%s+(%d+)%s(%w+)')
                mem[name] = number
              end
            end
            mem['MemUsed'] = tonumber(
              mem['MemTotal'] == nil and 0 or mem['MemTotal']
            ) - tonumber(
              mem['MemAvailable'] == nil and 0 or mem['MemAvailable']
            )
            widget:set_markup_silently(
              string.format(
                ' :%.f%%',
                mem['MemUsed'] / mem['MemTotal'] * 100
              )
            )
          end
        ),
        layout = wibox.layout.fixed.horizontal,
      },
      left = 5 * beautiful.useless_gap,
      right = 5 * beautiful.useless_gap,
      widget = wibox.container.margin,
    },
    bg = beautiful.nord9,
    fg = beautiful.nord0,
    shape = gears.shape.rounded_bar,
    widget = wibox.container.background,
  })
  return meminfo
end

return M

-- }}}1
