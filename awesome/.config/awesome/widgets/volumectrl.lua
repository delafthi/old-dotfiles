-- awesome_mode: api-level=4:screen=on
-----------------------------------------------------------
-- Includes {{{1
-- Standard awesome libraries
local awful = require("awful") -- Everything related to window management
-- Widget and layout library
local wibox = require("wibox") -- Awesome own generic widget framework
-- Theme handling library
local beautiful = require("beautiful") -- Awesome theme module

-- Default mod key
local modkey = "Mod4" -- Meta key

local M = {}

-----------------------------------------------------------
-- Volume control {{{1

local volumecfg = {
  cardid = 2,
  channel = "Speaker",
}

function M.get_widget()
  local volumectrl = wibox.widget({
    {
      id = "watch_role",
      awful.widget.watch(
        "bash -c 'amixer -c"
          .. volumecfg.cardid
          .. " sget "
          .. volumecfg.channel
          .. " -M'",
        5,
        function(widget, stdout)
          local volume = stdout:match("%[%d+%%%]")
          volume = tonumber(volume:match("%d+"))
          local status = stdout:match("%[o[n|ff]%]")
          local icon = ""
          if status:find("off") then
            icon = "婢"
          elseif volume >= 60 then
            icon = "墳"
          elseif volume >= 10 then
            icon = "奔"
          elseif volume < 10 then
            icon = "奄"
          else
            icon = "ﱝ "
          end
          widget:set_markup_silently(
            string.format(
              "<span weight='bold' foreground='%s'>%s </span>%.f%%",
              beautiful.nord15,
              icon,
              volume
            )
          )
        end
      ),
      buttons = {
        awful.button({}, 1, function()
          os.execute(
            "amixer -c "
              .. volumecfg.cardid
              .. " sset "
              .. volumecfg.channel
              .. " toggle"
          )
        end),
        awful.button({}, 3, function()
          awful.spawn("pavucontrol")
        end),
        awful.button({}, 4, function()
          os.execute(
            "amixer -c "
              .. volumecfg.cardid
              .. " sset "
              .. volumecfg.channel
              .. " 5%+"
          )
        end),
        awful.button({}, 5, function()
          os.execute(
            "amixer -c "
              .. volumecfg.cardid
              .. " sset "
              .. volumecfg.channel
              .. " 5%-"
          )
        end),
      },
      layout = wibox.layout.fixed.horizontal,
    },
    left = 3 * beautiful.useless_gap,
    right = 6 * beautiful.useless_gap,
    widget = wibox.container.margin,
  })
  return volumectrl
end

return M

-- }}}1
