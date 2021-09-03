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
require('awful.hotkeys_popup.keys')

local M = {}

-----------------------------------------------------------
-- CPU info {{{1

local cpus = {}

function M.get_widget()
  local cpuinfo = wibox.widget({
    {
      {
        id = 'watch_role',
        awful.widget.watch(
          [[bash -c 'grep '^cpu.' /proc/stat']],
          1,
          function(widget, stdout)
            for line in stdout:gmatch('[^\r\n]+') do
              if line:sub(1, #'cpu') == 'cpu' then
                local name, user, nice, system, idle, iowait, irq, softirq, steal, _, _ =
                  line:match(
                    '(%w+)%s+(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)'
                  )
                local total = user
                  + nice
                  + system
                  + idle
                  + iowait
                  + irq
                  + softirq
                  + steal

                if cpus[name] == nil then
                  cpus[name] = {}
                end
                local diff_idle = idle
                  - tonumber(
                    cpus[name]['idle_prev'] == nil and 0
                      or cpus[name]['idle_prev']
                  )
                local diff_total = total
                  - tonumber(
                    cpus[name]['total_prev'] == nil and 0
                      or cpus[name]['total_prev']
                  )
                cpus[name]['diff_usage'] = (
                    (diff_total - diff_idle) / diff_total
                  ) * 100

                cpus[name]['total_prev'] = total
                cpus[name]['idle_prev'] = idle
              end
            end
            widget:set_markup_silently(
              string.format(' :%.f%%', cpus['cpu']['diff_usage'])
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
  return cpuinfo
end

return M

-- }}}1
