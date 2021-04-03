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

theme.red = '#e06c75'
theme.green = '#98c379'
theme.orange = '#e59F70'
theme.yellow = '#e5c07b'
theme.blue = '#61afef'
theme.purple = '#c678dd'
theme.cyan = '#56b6c2'

theme.red_dark = '#be646a'
theme.green_dark = '#7e9d69'
theme.orange_dark = '#c08768'
theme.yellow_dark = '#bd9e6f'
theme.blue_dark = '#5f96c9'
theme.purple_dark = '#a86cbb'
theme.cyan_dark = '#51969f'

theme.red_light = '#e8838c'
theme.green_light = '#a6d18c'
theme.orange_light = '#ecb07e'
theme.yellow_light = '#eccd84'
theme.blue_light = '#75c2f3'
theme.purple_light = '#d38de6'
theme.cyan_light = '#69c7d1'

theme.black = '#282c34'
theme.white = '#dcdfe4'

theme.mono1 = '#313640'
theme.mono2 = '#4b5263'
theme.mono3 = '#5c6370'
theme.mono4 = '#919baa'
theme.mono5 = '#abb2bf'
-- Path of this theme config
theme.config_path = gfs.get_configuration_dir()

-- Set wallpaper
theme.wallpapers_path = "/usr/share/backgrounds/"
theme.wallpapers_fileending = ".jpg"

-- Set fonts
theme.font = "Victor Mono Nerd Font 11"
theme.taglist_font = "Victor Mono Nerd Font 11"

-- Window settings
theme.bg_normal = theme.black
theme.bg_focus = theme.black
theme.bg_urgent = theme.red
theme.bg_minimize = theme.mono3
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.white
theme.fg_focus = theme.blue
theme.fg_urgent = theme.black
theme.fg_minimize = theme.mono3

theme.useless_gap = 2
theme.border_width = 3
theme.border_normal = theme.black
theme.border_focus = theme.blue
theme.border_marked = theme.purple
theme.border_floating = theme.mono3

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
theme.wibox_separator_fg = theme.mono3

theme.wibox_bg = theme.bg_normal

theme.wibox_height = 24

-- Widget settings

-- Taglist settings
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
theme.taglist_fg_focus = theme.blue
theme.taglist_fg_urgent = theme.red
theme.taglist_fg_occupied = theme.purple
theme.taglist_fg_empty = theme.mono3
theme.taglist_fg_volatile = theme.yellow

theme.taglist_bg_focus = theme.bg_normal
theme.taglist_bg_urgent = theme.bg_normal
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_bg_volatile = theme.bg_normal

-- Tasklist settings
theme.tasklist_fg_focus = theme.blue
theme.tasklist_fg_normal = theme.fg_normal
theme.tasklist_fg_minimize = theme.mono3
theme.tasklist_fg_urgent = theme.black

theme.tasklist_bg_focus = theme.bg_normal
theme.tasklist_bg_normal = theme.bg_normal
theme.tasklist_bg_minimize = theme.bg_normal
theme.tasklist_bg_urgent = theme.bg_normal

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
theme.notification_border_color = theme.blue
theme.notification_border_width = 3
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
theme.layout_twopane = theme.config_path.."layouts/twopanew.png"
theme.layout_twopaneleft = theme.config_path.."layouts/twopaneleftw.png"
theme.layout_twopanetop = theme.config_path.."layouts/twopanetopw.png"
theme.layout_twopanebottom = theme.config_path.."layouts/twopanebottomw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"
theme.layout_fg = theme.mono3
theme.layout_bg = theme.bg_normal

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(20, theme.purple, theme.black)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- }}}
return theme
