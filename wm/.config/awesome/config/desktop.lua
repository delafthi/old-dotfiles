local awful = require("awful")
require("awful.autofocus")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local bling = require("modules.bling")

---@diagnostic disable
local awesome = awesome
local client = client
local screen = screen
---@diagnostic enable

client.connect_signal("request::manage", function(c)
  --- Add missing icon to client
  if not c.icon then
    local icon = gears.surface(
      beautiful.theme_assets.awesome_icon(24, beautiful.color8, beautiful.black)
    )
    c.icon = icon._native
    icon:finish()
  end

  --- Set the windows at the slave,
  if
    awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position
  then
    --- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

--- Hide all windows when a splash is shown
awesome.connect_signal("widgets::splash::visibility", function(vis)
  local t = screen.primary.selected_tag
  if vis then
    for _, c in ipairs(t:clients()) do
      c.hidden = true
    end
  else
    for _, c in ipairs(t:clients()) do
      c.hidden = false
    end
  end
end)

--- Wallpapers
--- ~~~~~~~~~~

awful.screen.connect_for_each_screen(function(s)
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper

    if type(wallpaper) == "function" then
      wallpaper = wallpaper()
    end

    gears.wallpaper.maximized(wallpaper, s, false, nil)
  end
end)

--- Tag preview
--- ~~~~~~~~~~~

bling.widget.tag_preview.enable({
  show_client_content = true,
  scale = 0.25,
  honor_workarea = true,
  honor_padding = true,
  placement_fn = function(c)
    awful.placement.top(c, {
      margins = {
        top = dpi(60),
      },
      parent = awful.screen.focused(),
    })
  end,
  background_widget = wibox.widget({
    image = beautiful.wallpaper(),
    horizontal_fit_policy = "fit",
    vertical_fit_policy = "fit",
    widget = wibox.widget.imagebox,
  }),
})
