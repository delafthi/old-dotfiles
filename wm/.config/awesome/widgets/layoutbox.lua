-- awesome_mode: api-level=4:screen=on
-----------------------------------------------------------
-- Includes {{{1
-- Standard awesome libraries
local gears = require("gears") -- Utilities such as color parsing and objects
local awful = require("awful") -- Everything related to window management
-- Widget and layout library
local wibox = require("wibox") -- Awesome own generic widget framework
-- Theme handling library
local beautiful = require("beautiful") -- Awesome theme module
-- Adjust pixel size to dpi
local dpi = require("beautiful.xresources").apply_dpi

local M = {}

-----------------------------------------------------------
-- Layoutbox {{{1

function M.get_widget(s)
  local layoutbox = wibox.widget({
    {
      {
        id = "icon_role",
        awful.widget.layoutbox({
          screen = s,
          buttons = {
            awful.button({}, 4, function()
              awful.layout.inc(1)
            end),
            awful.button({}, 5, function()
              awful.layout.inc(-1)
            end),
          },
        }),
        opacity = 0.5,
        layout = wibox.layout.fixed.horizontal,
      },
      margins = 3 * beautiful.useless_gap,
      widget = wibox.container.margin,
    },
    bg = beautiful.nord3,
    fg = beautiful.nord7,
    shape = gears.shape.rounded_bar,
    widget = wibox.container.background,
  })
  -- M.get_popup(layoutbox, s)
  return layoutbox
end

-----------------------------------------------------------
-- Layoutlist {{{1

function M.get_popup(widget, s)
  local p = awful.popup({
    widget = wibox.widget({
      awful.widget.layoutlist({
        -- source = awful.widget.layoutlist.source.default_layouts,
        screen = s,
        base_layout = wibox.widget({
          spacing = dpi(5),
          forced_num_cols = dpi(3),
          layout = wibox.layout.grid.vertical,
        }),
        widget_template = {
          {
            {
              id = "clienticon",
              forced_height = 22,
              forced_width = 22,
              widget = wibox.widget.imagebox,
            },
            margins = dpi(4),
            widget = wibox.container.margin,
          },
          id = "background_role",
          forced_width = dpi(24),
          forced_height = dpi(24),
          shape = gears.shape.rounded_rect,
          widget = wibox.container.background,
        },
      }),
      margins = dpi(4),
      widget = wibox.container.margin,
    }),
    preferred_anchors = "middle",
    border_color = beautiful.border_color,
    border_width = beautiful.border_width,
    shape = gears.shape.infobubble,
  })
  p:bind_to_widget(widget)
  return p
end

return M

-- }}}1
