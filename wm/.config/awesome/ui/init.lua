require("ui.notifications")
require("ui.popups")

local decorations = require("ui.decorations")
decorations.init()
decorations.enable_rounding()

local top_panel = require("ui.panels.top-panel")
local central_panel = require("ui.panels.central-panel")
local info_panel = require("ui.panels.info-panel")
local notification_panel = require("ui.panels.notification-panel")

local awful = require("awful")
awful.screen.connect_for_each_screen(function(s)
  --- Panels
  top_panel(s)
  central_panel(s)
  info_panel(s)
  notification_panel(s)
end)
