-------------------------------------------------------------------------------
-- Onehalfdark theme
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- {{{ Includes
local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local gfs = require("gears.filesystem")

-- }}}
--------------------------------------------------------------------------------
-- {{{ Variable definitions

local themes_path = gfs.get_themes_dir()
local theme = {}

-- Shape
theme.shape = gears.shape.powerline

-- Colors
theme.black = "#282c34"
theme.red = "#e06c75"
theme.green = "#98c379"
theme.yellow = "#e5c07b"
theme.blue = "#61afef"
theme.magenta = "#c678dd"
theme.cyan = "#56b6c2"
theme.white = "#dcdfe4"
theme.black_lite = "#5c6370"

-- Path of this theme config
theme.config_path = gfs.get_configuration_dir() .. "themes/onehalf-dark/"

-- Set wallpaper
theme.wallpaper = "/usr/share/backgrounds/wallpaper1.jpg"

-- Set fonts
theme.font = "Victor Mono Nerd Font Mono 11"
theme.taglist_font = "Victor Mono Nerd Font Mono 11"

-- Window settings
theme.bg_normal = theme.black
theme.bg_focus = theme.black
theme.bg_urgent = theme.red
theme.bg_minimize = theme.black
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.white
theme.fg_focus = theme.blue
theme.fg_urgent = theme.black
theme.fg_minimize = theme.black_lite

theme.useless_gap = 2
theme.border_width = 3
theme.border_normal = theme.black
theme.border_focus = theme.blue
theme.border_marked = theme.magenta
theme.border_floating = theme.black_lite

-- Menu settings
theme.menu_fg_normal = theme.fg_normal
theme.menu_fg_focus = theme.fg_normal

theme.menu_bg_normal = theme.bg_normal
theme.menu_bg_focus = theme.blue

theme.menu_border_width = 1
theme.menu_border_color = theme.border_focus
theme.menu_height = 20
theme.menu_width = 140

theme.menu_submenu_icon = themes_path .. "/icons/submenu.png"
theme.menu_font = theme.font

-- Wibox settings
theme.wibox_fg = theme.fg_normal
theme.wibox_separator_fg = theme.black_lite

theme.wibox_bg = theme.bg_normal

-- Widget settings

-- Taglist settings
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
theme.taglist_fg_focus = theme.blue
theme.taglist_fg_urgent = theme.red
theme.taglist_fg_occupied = theme.magenta
theme.taglist_fg_empty = theme.black_lite
theme.taglist_fg_volatile = theme.yellow

theme.taglist_bg_focus = theme.bg_normal
theme.taglist_bg_urgent = theme.bg_normal
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_bg_volatile = theme.bg_normal

-- Tasklist settings
theme.tasklist_fg_focus = theme.blue
theme.tasklist_fg_normal = theme.fg_normal
theme.tasklist_fg_minimize = theme.black_lite
theme.tasklist_fg_urgent = theme.black

theme.tasklist_bg_focus = theme.black_lite
theme.tasklist_bg_normal = theme.bg_normal
theme.tasklist_bg_minimize = theme.bg_normal
theme.tasklist_bg_urgent = theme.bg_normal

-- Titlebar settings
--them]
-- theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
-- theme.titlebar_close_button_focus = themes_path.."default/titlebar/close_focus.png"

-- theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
-- theme.titlebar_minimize_button_focus = themes_path.."default/titlebar/minimize_focus.png"

-- theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
-- theme.titlebar_ontop_button_focus_inactive = themes_path.."default/titlebar/ontop_focus_inactive.png"
-- theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
-- theme.titlebar_ontop_button_focus_active = themes_path.."default/titlebar/ontop_focus_active.png"

-- theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
-- theme.titlebar_sticky_button_focus_inactive = themes_path.."default/titlebar/sticky_focus_inactive.png"
-- theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
-- theme.titlebar_sticky_button_focus_active = themes_path.."default/titlebar/sticky_focus_active.png"

-- theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
-- theme.titlebar_floating_button_focus_inactive = themes_path.."default/titlebar/floating_focus_inactive.png"
-- theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
-- theme.titlebar_floating_button_focus_active = themes_path.."default/titlebar/floating_focus_active.png"

-- theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
-- theme.titlebar_maximized_button_focus_inactive = themes_path.."default/titlebar/maximized_focus_inactive.png"
-- theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
-- theme.titlebar_maximized_button_focus_active = themes_path.."default/titlebar/maximized_focus_active.png"

-- Tooltip settings
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]

-- Mouse finder settings
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]

-- Prompt settings
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]

--themeHotkey settings
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]

-- Notification settings
theme.notification_font = theme.font
theme.notification_bg = theme.bg_normal
theme.notification_bg_critical = theme.red
theme.notification_fg = theme.white
theme.notification_width = 300
theme.notification_margin = 4
theme.notification_border_color = theme.yellow
theme.notification_border_width = 1
theme.notification_spacing = theme.useless_gap
-- theme.notification_height = 30
-- notification_[shape|opacity]

-- Layout icons
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"
theme.layout_fg = theme.black_lite
theme.layout_bg = theme.bg_normal

-- Generate Awesome icon:
-- theme.awesome_icon = theme_assets.awesome_icon(20, theme.black, theme.magenta)
theme.awesome_icon = theme.config_path .. "img/Awesome_logo.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- }}}
return theme
