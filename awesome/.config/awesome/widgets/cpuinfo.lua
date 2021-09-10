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
-- CPU info {{{1

local cpus = {}

function M.get_widget()
  local cpuinfo = wibox.widget({
    {
      id = "watch_role",
      awful.widget.watch(
        [[bash -c 'grep '^cpu.' /proc/stat']],
        5,
        function(widget, stdout)
          for name, user, nice, system, idle, iowait, irq, softirq, steal in stdout:gmatch(
            "(%w+)%s+(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)"
          ) do
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
                cpus[name]["idle_prev"] == nil and 0 or cpus[name]["idle_prev"]
              )
            local diff_total = total
              - tonumber(
                cpus[name]["total_prev"] == nil and 0
                  or cpus[name]["total_prev"]
              )
            cpus[name]["diff_usage"] = ((diff_total - diff_idle) / diff_total)
              * 100

            cpus[name]["total_prev"] = total
            cpus[name]["idle_prev"] = idle
          end
          widget:set_markup_silently(
            string.format(
              "<span weight='bold' foreground='%s'> </span>%.f%%",
              beautiful.nord11,
              cpus["cpu"]["diff_usage"]
            )
          )
        end
      ),
      layout = wibox.layout.fixed.horizontal,
    },
    left = 6 * beautiful.useless_gap,
    right = 3 * beautiful.useless_gap,
    widget = wibox.container.margin,
  })
  return cpuinfo
end

return M

-- }}}1
