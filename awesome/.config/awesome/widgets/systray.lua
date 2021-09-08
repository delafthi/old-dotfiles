-- awesome_mode: api-level=4:screen=on
-----------------------------------------------------------
-- Includes {{{1
-- Standard awesome libraries
local gears = require("gears") -- Utilities such as color parsing and objects
-- Widget and layout library
local wibox = require("wibox") -- Awesome own generic widget framework
-- Theme handling library
local beautiful = require("beautiful") -- Awesome theme module

local M = {}

-----------------------------------------------------------
-- Systray {{{1

function M.get_widget(s)
  if s == screen.primary then
    local systray = wibox.widget({
      {
        { widget = wibox.widget.systray },
        top = 2 * beautiful.useless_gap,
        bottom = 2 * beautiful.useless_gap,
        left = 5 * beautiful.useless_gap,
        right = 5 * beautiful.useless_gap,
        widget = wibox.container.margin,
      },
      bg = beautiful.bg_systray,
      fg = beautiful.fg_normal,
      shape = gears.shape.rounded_bar,
      widget = wibox.container.background,
    })
    return systray
  else
    return
  end
end

return M

-- }}}1
