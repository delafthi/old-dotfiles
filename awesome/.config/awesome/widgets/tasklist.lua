-- awesome_mode: api-level=4:screen=on
-----------------------------------------------------------
-- Includes {{{1
-- Standard awesome libraries
local awful = require("awful") -- Everything related to window management
-- Widget and layout library
local wibox = require("wibox") -- Awesome own generic widget framework
-- Theme handling library
local beautiful = require("beautiful") -- Awesome theme module
-- Adjust pixel size to dpi
local dpi = require("beautiful.xresources").apply_dpi

local M = {}

-----------------------------------------------------------
-- Tasklist {{{1

function M.get_widget(s)
  local tasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    tasklist_plain_task_name = true,
    buttons = {
      awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
      end),
      awful.button({}, 4, function()
        awful.client.focus.byidx(1)
      end),
      awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
      end),
    },
    layout = {
      spacing = dpi(1),
      spacing_widget = {
        {
          forced_width = dpi(3),
          color = beautiful.separator_fg,
          widget = wibox.widget.separator,
        },
        valign = "center",
        halign = "center",
        widget = wibox.container.place,
      },
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = {
      {
        {
          {
            { id = "icon_role", resize = true, widget = wibox.widget.imagebox },
            margins = 2,
            widget = wibox.container.margin,
          },
          { id = "text_role", widget = wibox.widget.textbox },
          spacing = 2 * beautiful.useless_gap,
          layout = wibox.layout.fixed.horizontal,
        },
        left = 3 * beautiful.useless_gap,
        right = 5 * beautiful.useless_gap,
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
    },
  })
  return tasklist
end

return M

-- }}}1
