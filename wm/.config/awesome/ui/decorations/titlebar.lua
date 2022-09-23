local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

---@diagnostic disable
local client = client
---@diagnostic enable

--- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  awful
    .titlebar(c, {
      position = "top",
      size = beautiful.titlebar_size.top,
      bg = beautiful.transparent,
    })
    :setup({
      bg = beautiful.titlebar_bg,
      shape = helpers.ui.prrect(
        beautiful.border_radius,
        true,
        true,
        false,
        false
      ),
      widget = wibox.container.background,
    })

  awful
    .titlebar(c, {
      position = "bottom",
      size = beautiful.titlebar_size.bottom,
      bg = beautiful.transparent,
    })
    :setup({
      bg = beautiful.titlebar_bg,
      shape = helpers.ui.prrect(
        beautiful.border_radius,
        false,
        false,
        true,
        true
      ),
      widget = wibox.container.background,
    })

  awful
    .titlebar(c, {
      position = "left",
      size = beautiful.titlebar_size.left,
      bg = beautiful.transparent,
    })
    :setup({
      bg = beautiful.titlebar_bg,
      shape = helpers.ui.prrect(
        beautiful.border_radius,
        false,
        false,
        false,
        false
      ),
      widget = wibox.container.background,
    })

  awful
    .titlebar(c, {
      position = "right",
      size = beautiful.titlebar_size.right,
      bg = beautiful.transparent,
    })
    :setup({
      bg = beautiful.titlebar_bg,
      shape = helpers.ui.prrect(
        beautiful.border_radius,
        false,
        false,
        false,
        false
      ),
      widget = wibox.container.background,
    })
end)
