-- awesome_mode: api-level=4:screen=on
-----------------------------------------------------------
-- Includes {{{1
-- Standard awesome libraries
local awful = require("awful") -- Everything related to window management
-- Widget and layout library
local wibox = require("wibox") -- Awesome own generic widget framework
-- Theme handling library
local beautiful = require("beautiful") -- Awesome theme module

local M = {}

-----------------------------------------------------------
-- Mem info {{{1

local mem = {}

function M.get_widget()
  local meminfo = wibox.widget({
    {
      {
        id = "watch_role",
        awful.widget.watch(
          [[bash -c 'grep '^Mem.' /proc/meminfo']],
          5,
          function(widget, stdout)
            for name, number in stdout:gmatch("(Mem%w+):%s+(%d+)") do
              mem[name] = number
            end
            mem["MemUsed"] = tonumber(
              mem["MemTotal"] == nil and 0 or mem["MemTotal"]
            ) - tonumber(
              mem["MemAvailable"] == nil and 0 or mem["MemAvailable"]
            )
            widget:set_markup_silently(
              string.format(
                "<span weight='bold' foreground='%s'> </span>%.f%%",
                beautiful.nord13,
                mem["MemUsed"] / mem["MemTotal"] * 100
              )
            )
          end
        ),
        layout = wibox.layout.fixed.horizontal,
      },
      left = 3 * beautiful.useless_gap,
      right = 3 * beautiful.useless_gap,
      widget = wibox.container.margin,
    },
    widget = wibox.container.background,
  })
  return meminfo
end

return M

-- }}}1
