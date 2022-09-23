--- Theme
--- ~~~~~

local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local theme = dofile(themes_path .. "default/theme.lua")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local icons = require("icons")

--- Fonts
--- ~~~~~

--- Ui Fonts
theme.font_name = "Victor Mono Nerd Font "
theme.font = theme.font_name .. "Medium "
theme.font_bold = theme.font_name .. "Bold "
theme.font_italic = theme.font_name .. "Italic "
theme.font_size_small = 10
theme.font_size = 12
theme.font_size_big = 16
theme.font_size_very_big = 24

--- Colors
--- ~~~~~~

--- Nord color palette
-- Polar night
local nord0_dark = "#282d37" -- An even darker `nord0`
local nord0 = "#2e3440" -- The origin color or the Polar Night palette
local nord1 = "#3b4252" -- A brighter shade color based on `nord0`
local nord2 = "#434c5e" -- An even more brighter shade color of `nord0`
local nord3 = "#4c566a" -- The brightest shade color based on `nord0`
local nord3_bright = "#616e88" -- An even brighter `nord3`
local nord3_brightened = {
  nord3,
  "#4e586d",
  "#505b70",
  "#525d73",
  "#556076",
  "#576279",
  "#59647c",
  "#5b677f",
  "#5d6982",
  "#5f6c85",
  nord3_bright,
  "#63718b",
  "#66738e",
  "#687591",
  "#6a7894",
  "#6d7a96",
  "#6f7d98",
  "#72809a",
  "#75829c",
  "#78859e",
  "#7b88a1",
}

-- Snow Storm
local nord4 = "#d8dee9" -- The origin color or the Snow Storm palette
local nord5 = "#e5e9f0" -- A brighter shade color of `nord4`
local nord6 = "#eceff4" -- The brightest shade color based on `nord4`

-- Frost
local nord7 = "#8fbcbb" -- A calm and highly contrasted color reminiscent of frozen polar water
local nord8 = "#88c0d0" -- The bright and shiny primary accent color reminiscent of pure and clear ice
local nord9 = "#81a1c1" -- A more darkened and less saturated color reminiscent of arctic waters
local nord10 = "#5e81ac" -- A dark and intensive color reminiscent of the deep arctic ocean

-- Aurora
local nord11 = "#bf616a"
local nord12 = "#d08770"
local nord13 = "#ebcb8b"
local nord14 = "#a3be8c"
local nord15 = "#b48ead"

--- Special
theme.darker_black = nord0_dark
theme.black = nord0
theme.lighter_black = nord1
theme.darker_grey = nord3
theme.grey = nord3_bright
theme.lighter_grey = nord3_brightened[14]
theme.lightest_grey = nord3_brightened[19]
theme.white = nord4
theme.red = nord11
theme.orange = nord12
theme.green = nord14
theme.yellow = nord13
theme.darker_blue = nord10
theme.blue = nord9
theme.magenta = nord15
theme.cyan = nord8
theme.lighter_cyan = nord7

theme.transparent = "#00000000"

--- Black
theme.color0 = nord0
theme.color8 = nord3

--- Red
theme.color1 = nord11
theme.color9 = nord11

--- Green
theme.color2 = nord14
theme.color10 = nord14

--- Yellow
theme.color3 = nord13
theme.color11 = nord13

--- Blue
theme.color4 = nord9
theme.color12 = nord9

--- Magenta
theme.color5 = nord15
theme.color13 = nord15

--- Cyan
theme.color6 = nord8
theme.color14 = nord7

--- White
theme.color7 = nord5
theme.color15 = nord6

--- Background Colors
theme.bg_normal = theme.black
theme.bg_focus = theme.black
theme.bg_urgent = theme.black
theme.bg_minimize = theme.black

--- Foreground Colors
theme.fg_normal = theme.fg
theme.fg_focus = theme.accent
theme.fg_urgent = theme.color1
theme.fg_minimize = theme.color0

--- Accent colors
function theme.random_accent_color()
  local accents = {
    theme.color9,
    theme.color10,
    theme.color11,
    theme.color12,
    theme.color13,
    theme.color14,
  }

  local i = math.random(1, #accents)
  return accents[i]
end

theme.accent = theme.color4

--- UI events
theme.leave_event = theme.transparent
theme.enter_event = "#ffffff" .. "10"
theme.press_event = "#ffffff" .. "15"
theme.release_event = "#ffffff" .. "10"

--- Widgets
theme.widget_bg = theme.black

--- Titlebars
theme.titlebar_enabled = true
theme.titlebar_size = {
  top = dpi(0),
  bottom = dpi(0),
  left = dpi(0),
  right = dpi(0),
}
theme.titlebar_bg = theme.black
theme.titlebar_fg = theme.white

--- Wibar
theme.wibar_bg = theme.black
theme.wibar_height = dpi(36)

--- UI Elements
--- ~~~~~~~~~~~
local function select_random_wallpaper()
  local wallpaper_path = gfs.get_configuration_dir() .. "themes/nord/assets"
  local fileending = ".jpg"
  local f =
    io.popen("fd -d 1 --regex " .. fileending .. " " .. wallpaper_path, "r")
  local files = {}
  local length = 0
  if f ~= nil then
    local line = "begin"
    while line ~= nil do
      line = f:read("*l")
      table.insert(files, line)
      length = length + 1
    end
    f:close()
  end
  math.randomseed(os.time()) -- Set the random seed
  -- Subtract 1 from length since we get an empty line
  local wallpaper = files[math.random(0, length - 1)]
  return gears.surface.load_uncached(wallpaper)
end

theme.wallpaper = select_random_wallpaper

--- Layout
theme.layout_icon_color = theme.white
theme.layout_twopane = gears.color.recolor_image(
  require("modules.delafthi.icons").twopanew,
  theme.layout_icon_color
)
theme.layout_tile = gears.color.recolor_image(
  themes_path .. "default/layouts/tilew.png",
  theme.layout_icon_color
)
theme.layout_max = gears.color.recolor_image(
  themes_path .. "default/layouts/maxw.png",
  theme.layout_icon_color
)

theme.layout_centered =
  gears.color.recolor_image(icons.layout.centered, theme.layout_icon_color)

--- Icon Theme
--- Define the icon theme for application icons. If not set then the icons
--- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Papirus-Dark"

--- Borders
theme.border_width = dpi(3)
theme.oof_border_width = dpi(3)
theme.border_color_marked = theme.magenta
theme.border_color_active = theme.blue
theme.border_color_normal = theme.black
theme.border_color_new = theme.black
theme.border_color_urgent = theme.red
theme.border_color_floating = theme.lighter_black
theme.border_color_maximized = theme.black
theme.border_color_fullscreen = theme.black

--- Corner Radius
theme.border_radius = 12

--- Edge snap
theme.snap_bg = theme.darker_blue
theme.snap_shape = helpers.ui.rrect(0)

--- Main Menu
theme.main_menu_bg = theme.lighter_black

--- Tooltip
theme.tooltip_bg = theme.lighter_black
theme.tooltip_fg = theme.white
theme.tooltip_font = theme.font

--- Hotkeys Pop Up
theme.hotkeys_bg = theme.lighter_black
theme.hotkeys_fg = theme.green
theme.hotkeys_modifiers_fg = theme.magenta
theme.hotkeys_font = theme.font
theme.hotkeys_description_font = theme.font
theme.hotkeys_shape = helpers.ui.rrect(theme.border_radius)
theme.hotkeys_group_margin = dpi(50)

--- Tag list
local taglist_square_size = dpi(0)
theme.taglist_squares_sel =
  theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel =
  theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

--- Tag preview
theme.tag_preview_widget_margin = dpi(10)
theme.tag_preview_widget_border_radius = theme.border_radius
theme.tag_preview_client_border_radius = theme.border_radius / 2
theme.tag_preview_client_opacity = 1
theme.tag_preview_client_bg = theme.lighter_black
theme.tag_preview_client_border_color = theme.lighter_black
theme.tag_preview_client_border_width = 0
theme.tag_preview_widget_bg = theme.lighter_black
theme.tag_preview_widget_border_color = theme.border_color_active
theme.tag_preview_widget_border_width = theme.border_width

--- Layout List
theme.layoutlist_shape_selected = helpers.ui.rrect(theme.border_radius)
theme.layoutlist_bg = theme.lighter_black
theme.layoutlist_bg_selected = theme.blue

--- Gaps
theme.useless_gap = dpi(2)

--- Systray
theme.systray_icon_size = dpi(20)
theme.systray_icon_spacing = dpi(10)
theme.bg_systray = theme.wibar_bg
--- theme.systray_max_rows = 2

--- Notifications
theme.notification_spacing = dpi(4)
theme.notification_bg = theme.black
theme.notification_bg_alt = theme.lighter_black

--- Notif center
theme.notif_center_notifs_bg = theme.lighter_black
theme.notif_center_notifs_bg_alt = theme.darker_grey

--- OSD timeout
theme.osd_timeout = 1

--- Swallowing
theme.dont_swallow_classname_list = {
  "gimp",
  "pcmanfm",
}

return theme
