-- awesome_mode: api-level=4:screen=on
-----------------------------------------------------------
-- Includes {{{1
-- Widget and layout library
local wibox = require("wibox") -- Awesome own generic widget framework
-- Theme handling library
local beautiful = require("beautiful") -- Awesome theme module
-- Adjust pixel size to dpi
local dpi = require("beautiful.xresources").apply_dpi

local M = {}

-----------------------------------------------------------
-- Default spacer {{{1

function M.get_widget()
  local spacer = {
    color = beautiful.wibar_separator_fg,
    forced_width = dpi(0),
    widget = wibox.widget.separator,
  }
  return spacer
end

return M

-- }}}1
