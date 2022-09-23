local awful = require("awful")
local bling = require("modules.bling")
local delafthi = require("modules.delafthi")

---@diagnostic disable
local tag = tag
---@diagnostic enable

--- Set the layouts
tag.connect_signal("request::default_layouts", function()
  awful.layout.append_default_layouts({
    delafthi.layout.twopane,
    awful.layout.suit.tile,
    awful.layout.suit.max,
    bling.layout.centered,
  })
end)
