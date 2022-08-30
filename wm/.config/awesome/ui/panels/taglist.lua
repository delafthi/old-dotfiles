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
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Default mod key
local modkey = "Mod4" -- Meta key

local M = {}

-----------------------------------------------------------
-- Tag rename prompt {{{1

function M.get_prompt()
  local prompt = awful.widget.prompt({
    prompt = " Rename tag: ",
    exe_callback = function(input)
      if not input or #input == 0 then
        return
      end
      awful.screen.focused().selected_tag.name = awful.screen.focused().selected_tag.index
        .. "_"
        .. input
    end,
  })
  return prompt
end

-----------------------------------------------------------
-- Taglist {{{1

function M.get_widget(s)
  local taglist = {}
  taglist.prompt = M.get_prompt()
  taglist.widget = wibox.widget({
    {
      awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = {
          awful.button({}, 1, function(t)
            t:view_only()
          end),
          awful.button({ modkey }, 1, function(t)
            if client.focus then
              client.focus:move_to_tag(t)
            end
          end),
          awful.button({}, 3, awful.tag.viewtoggle),
          awful.button({ modkey }, 3, function(t)
            if client.focus then
              client.focus:toggle_tag(t)
            end
          end),
          awful.button({}, 4, function(t)
            awful.tag.viewnext(t.screen)
          end),
          awful.button({}, 5, function(t)
            awful.tag.viewprev(t.screen)
          end),
        },
      }),
      taglist.prompt,
      layout = wibox.layout.fixed.horizontal(),
      widget_template = {
        widget = wibox.container.margin,
        forced_width = dpi(40),
        forced_height = dpi(40),
      },
    },
    bg = beautiful.taglist_bg_empty,
    fg = beautiful.fg_normal,
    shape = gears.shape.rounded_bar,
    widget = wibox.container.background,
  })
  return taglist
end

return M

-- }}}1
