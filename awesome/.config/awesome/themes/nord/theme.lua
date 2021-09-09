-----------------------------------------------------------
-- Nord theme
-----------------------------------------------------------
-----------------------------------------------------------
-- Includes {{{1
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")

-----------------------------------------------------------
-- Variable definitions {{{1

local themes_path = gears.filesystem.get_themes_dir()
local config_path = gears.filesystem.get_configuration_dir()

local theme = {}

-- Nord color palette {{{2
-- Polar night
theme.nord0 = "#2e3440" -- The origin color or the Polar Night palette
theme.nord1 = "#3b4252" -- A brighter shade color based on `nord0`
theme.nord2 = "#434c5e" -- An even more brighter shade color of `nord0`
theme.nord3 = "#4c566a" -- The brightest shade color based on `nord0`

-- Snow Storm
theme.nord4 = "#d8dee9" -- The origin color or the Snow Storm palette
theme.nord5 = "#e5e9f0" -- A brighter shade color of `nord4`
theme.nord6 = "#eceff4" -- The brightest shade color based on `nord4`

-- Frost
theme.nord7 = "#8fbcbb" -- A calm and highly contrasted color reminiscent of frozen polar water
theme.nord8 = "#88c0d0" -- The bright and shiny primary accent color reminiscent of pure and clear ice
theme.nord9 = "#81a1c1" -- A more darkened and less saturated color reminiscent of arctic waters
theme.nord10 = "#5e81ac" -- A dark and intensive color reminiscent of the deep arctic ocean

-- Aurora
theme.nord11 = "#bf616a"
theme.nord12 = "#d08770"
theme.nord13 = "#ebcb8b"
theme.nord14 = "#a3be8c"
theme.nord15 = "#b48ead"

-- Default colors {{{2
theme.red = theme.nord11
theme.green = theme.nord14
theme.orange = theme.nord12
theme.yellow = theme.nord13
theme.blue = theme.nord9
theme.purple = theme.nord15
theme.cyan = theme.nord7

-- Default variables {{{2
theme.font = "Victor Mono Nerd Font" -- The default font
theme.wallpaper = "~/.local/share/backgrounds/nord.png" -- The wallpaper path
theme.icon_theme = "Papirus" -- The icon theme name
theme.shape = gears.shape.rectangle -- The clients shape

-- Background {{{2
theme.bg_normal = theme.nord0 -- The default background color
theme.bg_focus = theme.nord9 -- The default focused element background color
theme.bg_urgent = theme.bg_normal -- The default urgent element background color
theme.bg_minimize = theme.bg_normal -- The default minimized element background color
theme.bg_systray = theme.nord3 -- The system tray background color

-- Foreground {{{2
theme.fg_normal = theme.nord4 -- The default foreground (text) color
theme.fg_focus = theme.nord0 -- The default focused element foreground (text) color
theme.fg_urgent = theme.nord11 -- The default urgent element foreground (text) color
theme.fg_minimize = theme.fg_normal -- The default minimized element foreground (text) color

-- Border {{{2
theme.border_color = theme.nord0 -- The fallback border color
theme.border_color_marked = theme.nord10 -- The border color when the client is marked
theme.border_color_active = theme.nord9 -- The border color when the client is active
theme.border_color_normal = theme.border_color -- The border color when the client is active
theme.border_color_urgent = theme.nord11 -- The border color when the client has the urgent property set
theme.border_color_new = theme.border_color_normal -- The border color when the client is not active and new
theme.border_color_floating = theme.nord3 -- The fallback border color when the client is floating
theme.border_color_floating_active = theme.border_color_active -- The border color when the (floating) client is active
theme.border_color_floating_normal = theme.border_color_normal -- The border color when the (floating) client is not active
theme.border_color_floating_urgent = theme.border_color_urgent -- The border color when the (floating) client has the urgent property set
theme.border_color_floating_new = theme.border_color_new -- The border color when the (floating) client is not active and new
theme.border_color_maximized = theme.border_color -- The fallback border color when the client is maximized
theme.border_color_maximized_active = theme.border_color_active -- The border color when the (maximized) client is active
theme.border_color_maximized_normal = theme.border_color_normal -- The border color when the (maximized) client is not active
theme.border_color_maximized_urgent = theme.border_color_urgent -- The border color when the (maximized) client has the urgent property set
theme.border_color_maximized_new = theme.border_color_new -- The border color when the (maximized) client is not active and new
theme.border_color_fullscreen = theme.border_color -- The fallback border color when the client is fullscreen
theme.border_color_fullscreen_active = theme.border_color_active -- The border color when the (fullscreen) client is active
theme.border_color_fullscreen_normal = theme.border_color_normal -- The border color when the (fullscreen) client is not active
theme.border_color_fullscreen_urgent = theme.border_color_urgent -- The border color when the (fullscreen) client has the urgent property set
theme.border_color_fullscreen_new = theme.border_color_new -- The border color when the (fullscreen) client is not active and new
theme.border_width = dpi(2) -- The fallback border width when nothing else is set
theme.border_width_normal = theme.border_width -- The client border width for the normal clients
theme.border_width_active = theme.border_width -- The client border width for the normal clients
theme.border_width_urgent = theme.border_width -- The client border width for the normal clients
theme.border_width_new = theme.border_width_normal -- The client border width for the new clients
theme.border_width_floating = theme.border_width -- The fallback border width when the client is floating
theme.border_width_floating_normal = theme.border_width_normal -- The client border width for the normal floating clients
theme.border_width_floating_active = theme.border_width_active -- The client border width for the active floating client
theme.border_width_floating_urgent = theme.border_width_urgent -- The client border width for the urgent floating clients
theme.border_width_floating_new = theme.border_width_new -- The client border width for the urgent floating clients
theme.border_width_maximized = theme.border_width -- The fallback border width when the client is maximized
theme.border_width_maximized_normal = theme.border_width_normal -- The client border width for the normal maximized clients
theme.border_width_maximized_active = theme.border_width_active -- The client border width for the normal maximized clients
theme.border_width_maximized_urgent = theme.border_width_urgent -- The client border width for the normal maximized clients
theme.border_width_maximized_new = theme.border_width_new -- The client border width for the new maximized clients
theme.border_width_fullscreen = theme.border_width_normal -- The fallback border width when the client is fullscreen
theme.border_width_fullscreen_normal = theme.border_width_normal -- The client border width for the normal fullscreen clients
theme.border_width_fullscreen_active = theme.border_width_active -- The client border width for the normal fullscreen clients
theme.border_width_fullscreen_urgent = theme.border_width_urgent -- The client border width for the urgent fullscreen clients
theme.border_width_fullscreen_new = theme.border_width_new -- The client border width for the new fullscreen clients

-- Gap {{{2
theme.useless_gap = dpi(2) -- The default gap
theme.gap_single_client = true -- Enable gaps for a single client

-- Layouts {{{2
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png" -- The cornernw layout layoutbox icon
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png" -- The cornerne layout layoutbox icon
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png" -- The cornersw layout layoutbox icon
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png" -- The cornerse layout layoutbox icon
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png" -- The fairh layout layoutbox icon
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png" -- The fairv layout layoutbox icon
theme.layout_floating = themes_path .. "default/layouts/floatingw.png" -- The floating layout layoutbox icon
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png" -- The magnifier layout layoutbox icon
theme.layout_max = themes_path .. "default/layouts/maxw.png" -- The max layout layoutbox icon
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png" -- The fullscreen layout layoutbox icon
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png" -- The fullscreen layout layoutbox icon
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png" -- The dwindle layout layoutbox icon
theme.layout_tile = themes_path .. "default/layouts/tilew.png" -- The tile layout layoutbox icon
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png" -- The tile top layout layoutbox icon
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png" -- The tile bottom layout layoutbox icon
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png" -- The tile left layout layoutbox icon
theme.layout_twopane = config_path .. "layouts/twopanew.png" -- The twopane layout layoutbox icon
theme.layout_twopanetop = config_path .. "layouts/twopanetopw.png" -- The twopane top layout layoutbox icon
theme.layout_twopanebottom = config_path .. "layouts/twopanebottomw.png" -- The twopane bottom layout layoutbox icon
theme.layout_twopaneleft = config_path .. "layouts/twopaneleftw.png" -- The twopane left layout layoutbox icon

-- Columns {{{3
theme.column_count = 1 -- The default number of columns

-- Master {{{3
theme.master_width_factor = 0.5 -- The default master width factor
theme.master_fill_policy = "expand" -- The default fill policy
theme.master_count = 1 -- The default number of master windows

-- Fullscreen {{{3
theme.fullscreen_hide_border = true -- Hide the border on fullscreen clients

-- Maximized {{{3
theme.maximized_honor_padding = true -- Honor the screen padding when maximizing
theme.maximized_hide_border = false -- Hide the border on maximized clients

-- Cursor {{{2
theme.cursor_mouse_resize = "resize" -- The resize cursor name
theme.cursor_mouse_move = "move" -- The move cursor name

-- Enable {{{2
theme.enable_spawn_cursor = false -- Show busy mouse cursor during spawn

-- Menu {{{2
theme.menu_submenu_icon = themes_path .. "default/submenu.png" -- The icon used for sub-menus
theme.menu_font = theme.font -- The menu text font
theme.menu_height = dpi(24) -- The item height
theme.menu_width = dpi(200) -- The default menu width
theme.menu_border_color = theme.nord1 -- The menu item border color
theme.menu_border_width = dpi(0) -- The menu item border width
theme.menu_fg_focus = theme.nord0 -- The default focused item foreground (text) color
theme.menu_bg_focus = theme.nord9 -- The default focused item background color
theme.menu_fg_normal = theme.nord4 -- The default foreground (text) color
theme.menu_bg_normal = theme.nord1 -- The default background color
theme.menu_submenu = ">" -- The default sub-menu indicator if no menu_submenu_icon is provided

-- Notification {{{2
theme.notification_max_width = dpi(600) -- The maximum notification width
theme.notification_position = "top_right" -- The maximum notification position
theme.notification_bg_normal = theme.nord1 -- The background color for normal notifications
theme.notification_bg_selected = theme.nord2 -- The background color for selected notifications
theme.notification_fg_normal = theme.fg_normal -- The foreground color for normal notifications
theme.notification_fg_selected = theme.fg_normal -- The foreground color for selected notifications
theme.notification_bgimage_normal = nil -- The background image for normal notifications
theme.notification_bgimage_selected = nil -- The background image for selected notifications
theme.notification_font = theme.font -- Notifications font
theme.notification_bg = theme.nord1 -- Notifications background color
theme.notification_fg = theme.fg_normal -- Notifications background color
theme.notification_border_width = dpi(3) -- Notifications border width
theme.notification_border_color = theme.border_color_normal -- Notifications border color
theme.notification_shape = theme.shape -- Notifications shape
theme.notification_opacity = 0.8 -- Notifications opacity
theme.notification_margin = dpi(5) -- Notifications opacity
theme.notification_width = dpi(300) -- Notifications width
theme.notification_height = dpi(150) -- Notifications height
theme.notification_spacing = theme.useless_gap -- The spacing between the notifications
theme.notification_icon_resize_strategy = "resize" -- The default way to resize the icon
theme.notification_icon_size_normal = dpi(30) -- The notification icon size
theme.notification_icon_size_selected = dpi(30) -- The selected notification icon size
theme.notification_shape_normal = theme.notification_shape -- The shape used for a normal notification
theme.notification_shape_selected = theme.notification_shape -- The shape used for a selected notification
theme.notification_shape_border_color_normal = theme.notification_bg_normal -- The shape border color for normal notifications
theme.notification_shape_border_color_selected = theme.notification_bg_selected -- The shape border color for selected notifications
theme.notification_shape_border_width_normal = theme.notification_border_width -- The shape border width for normal notifications
theme.notification_shape_border_width_selected = theme.notification_border_width -- The shape border width for selected notifications
theme.notification_action_bg_normal = theme.nord1 -- The background color for normal actions
theme.notification_action_bg_selected = theme.nord2 -- The background color for selected actions
theme.notification_action_fg_normal = theme.fg_normal -- The foreground color for normal actions
theme.notification_action_fg_selected = theme.fg_normal -- The foreground color for selected actions
theme.notification_action_bgimage_normal = nil -- The background image for normal actions
theme.notification_action_bgimage_selected = nil -- The background image for selected actions
theme.notification_action_underline_normal = false -- Whether or not to underline the action name
theme.notification_action_underline_selected = false -- Whether or not to underline the selected action name
theme.notification_action_icon_only = false -- Whether or not the action label should be shown
theme.notification_action_label_only = false -- Whether or not the action icon should be shown
theme.notification_action_shape_normal = theme.notification_shape -- The shape used for a normal action
theme.notification_action_shape_selected = theme.notification_shape -- The shape used for a selected action
theme.notification_action_shape_border_color_normal =
  theme.notification_action_bg_normal -- The shape border color for normal actions
theme.notification_action_shape_border_color_selected =
  theme.notification_action_bg_selected -- The shape border color for selected actions
theme.notification_action_shape_border_width_normal =
  theme.notification_border_width -- The shape border color for selected actions
theme.notification_action_shape_border_width_selected =
  theme.notification_border_width -- The shape border width for selected actions
theme.notification_action_icon_size_normal = theme.notification_icon_size_normal -- The action icon size
theme.notification_action_icon_size_selected =
  theme.notification_icon_size_selected -- The selected action icon size

-- Opacity {{{2
theme.opacity_normal = 1.0 -- The client opacity for the normal clients
theme.opacity_active = 1.0 -- The client opacity for the normal clients
theme.opacity_urgent = 1.0 -- The client opacity for the normal clients
theme.opacity_new = 1.0 -- The client opacity for the new clients
theme.opacity_floating_normal = theme.opacity_normal -- The client opacity for the normal floating clients
theme.opacity_floating_active = theme.opacity_active -- The client opacity for the normal floating clients
theme.opacity_floating_urgent = theme.opacity_urgent -- The client opacity for the normal floating clients
theme.opacity_floating_new = theme.opacity_new -- The client opacity for the new floating clients
theme.opacity_maximized_normal = theme.opacity_normal -- The client opacity for the new floating clients
theme.opacity_maximized_active = theme.opacity_active -- The client opacity for the active maximized client
theme.opacity_maximized_urgent = theme.opacity_urgent -- The client opacity for the urgent maximized clients
theme.opacity_maximized_new = theme.opacity_new -- The client opacity for the new maximized clients
theme.opacity_fullscreen_normal = theme.opacity_normal -- The client opacity for the normal fullscreen clients
theme.opacity_fullscreen_active = theme.opacity_active -- The client opacity for the active fullscreen clients
theme.opacity_fullscreen_urgent = theme.opacity_urgent -- The client opacity for the urgent fullscreen clients
theme.opacity_fullscreen_new = theme.opacity_new -- The client opacity for the new fullscreen clients

-- Snap {{{2
theme.snap_bg = theme.nord9 -- The snap outline background color
theme.snap_border_width = dpi(5) -- The snap outline width
theme.snap_shape = theme.shape -- The snap outline shape

-- Snapper {{{2
theme.snapper_gap = theme.useless_gap -- The gap between snapped clients

-- Tooltip {{{2
theme.tooltip_border_color = theme.border_color -- The tooltip border color
theme.tooltip_bg = theme.nord1 -- The tooltip background color
theme.tooltip_fg = theme.nord4 -- The tooltip foregound (text) color
theme.tooltip_font = theme.font -- The tooltip font
theme.tooltip_border_width = dpi(5) -- The tooltip border width
theme.tooltip_opacity = 1.0 -- The tooltip opacity
theme.tooltip_gaps = { 2, 2, 2, 2 } -- The tooltip margins
theme.tooltip_shape = theme.shape -- The default tooltip shape
theme.tooltip_align = "bottom_right" -- The default tooltip alignment

-- Wibar {{{2
theme.wibar_bg = theme.nord0 -- The wibar’s background color
theme.wibar_bgimage = nil -- The wibar’s background image
theme.wibar_fg = theme.nord4 -- The wibar’s foreground (text) color
theme.wibar_shape = theme.shape -- The wibar’s shape
theme.wibar_stretch = true -- If the wibar needs to be stretched to fill the screen
theme.wibar_border_width = dpi(3) -- The wibar border width
theme.wibar_border_color = theme.wibar_bg -- The wibar border color
theme.wibar_ontop = false -- If the wibar is to be on top of other windows
theme.wibar_cursor = "left_ptr" -- The wibar’s mouse cursor
theme.wibar_opacity = 1.0 -- The wibar opacity, between 0 and 1
theme.wibar_type = "dock" -- The window type (desktop, normal, dock, …)
theme.wibar_width = nil -- The wibar’s width
theme.wibar_height = dpi(22) -- The wibar’s height
theme.wibar_spacing = 3 * theme.useless_gap -- The spacing between widgets in the wibar

-- Widgets {{{2
-- arcchart {{{3
theme.arcchart_border_color = theme.border_color -- The progressbar border background color
theme.arcchart_color = theme.nord9 -- The progressbar border background color
theme.arcchart_border_width = dpi(3) -- 	The progressbar border width
theme.arcchart_paddings = 2 -- The padding between the outline and the progressbar
theme.arcchart_thickness = 10 -- The arc thickness

-- Calendar {{{3
theme.calendar_style = {} -- The generic calendar style table
theme.calendar_font = theme.font -- The calendar font
theme.calendar_spacing = dpi(7) -- The calendar spacing
theme.calendar_week_numbers = true -- Display the calendar week numbers
theme.calendar_start_sunday = true -- Start the week on Sunday
theme.calendar_long_weekdays = false -- Format the weekdays with three characters instead of two

-- Checkbox {{{3
theme.checkbox_border_width = dpi(3) -- The outer (unchecked area) border width
theme.checkbox_bg = theme.nord0 -- The outer (unchecked area) background color, pattern or gradient
theme.checkbox_border_color = theme.border_color -- The outer (unchecked area) border color
theme.checkbox_check_border_color = theme.border_color_active -- The checked part border color
theme.checkbox_check_border_width = dpi(3) -- The checked part border width
theme.checkbox_check_color = theme.nord9 -- The checked part border width
theme.checkbox_shape = gears.shape.circle -- The outer (unchecked area) shape
theme.checkbox_check_shape = gears.shape.circle -- The checked part shape
theme.checkbox_paddings = dpi(3) -- The checked part shape
theme.checkbox_color = theme.nord1 -- The checkbox color

-- Graph {{{3
theme.graph_fg = theme.nord10 -- The graph foreground color
theme.graph_bg = theme.nord0 -- The graph background color
theme.graph_border_color = theme.border_color -- The graph border color

-- Hotkeys {{{3
theme.hotkeys_bg = theme.nord1 -- The border color when the client is focused
theme.hotkeys_fg = theme.nord4 -- Hotkeys widget foreground color
theme.hotkeys_border_width = dpi(10) -- Hotkeys widget foreground color
theme.hotkeys_border_color = theme.hotkeys_bg -- Hotkeys widget foreground color
theme.hotkeys_shape = theme.shape -- Hotkeys widget foreground color
theme.hotkeys_modifiers_fg = theme.nord7 -- Hotkeys widget foreground color
theme.hotkeys_label_bg = theme.nord10 -- Hotkeys widget foreground color
theme.hotkeys_label_fg = theme.nord0 -- Hotkeys widget foreground color
theme.hotkeys_font = theme.font -- Hotkeys widget foreground color
theme.hotkeys_description_font = theme.font -- Hotkeys widget foreground color
theme.hotkeys_group_margin = dpi(5) -- Margin between hotkeys groups

-- Layoutlist {{{3
theme.layoutlist_fg_normal = theme.nord4 -- The default foreground (text) color
theme.layoutlist_bg_normal = theme.nord3 -- The default background color
theme.layoutlist_fg_selected = theme.nord4 -- The selected layout foreground (text) color
theme.layoutlist_bg_selected = theme.nord9 -- The selected layout background color
theme.layoutlist_disable_icon = false -- Disable the layout icons (only show the name label)
theme.layoutlist_disable_name = true -- Disable the layout name label (only show the icon)
theme.layoutlist_font = theme.font -- The layoutlist font
theme.layoutlist_align = "center" -- The selected layout alignment
theme.layoutlist_font_selected = theme.font -- The selected layout title font
theme.layoutlist_spacing = dpi(7) -- The space between the layouts
theme.layoutlist_shape = theme.shape -- The default layoutlist elements shape
theme.layoutlist_shape_border_width = dpi(3) -- The default layoutlist elements border width
theme.layoutlist_shape_border_color = theme.border_color -- The default layoutlist elements border color
theme.layoutlist_shape_selected = theme.layoutlist_shape -- The selected layout shape
theme.layoutlist_shape_border_width_selected = dpi(3) -- The selected layout border width
theme.layoutlist_shape_border_color_selected = theme.border_color_active -- The selected layout border color

-- Menubar {{{3
theme.menubar_fg_normal = theme.nord4 -- Menubar normal text color
theme.menubar_bg_normal = theme.nord1 -- Menubar normal background color
theme.menubar_border_width = dpi(3) -- Menubar border width
theme.menubar_border_color = theme.menubar_bg_normal -- Menubar border color
theme.menubar_fg_focus = theme.nord0 -- Menubar selected item text color
theme.menubar_bg_focus = theme.nord9 -- Menubar selected item background color
theme.menubar_font = theme.font -- Menubar font

-- Piechart {{{3
theme.piechart_border_color = theme.border_color -- The border color
theme.piechart_border_width = dpi(3) -- The border color
theme.piechart_colors = theme.nord9 -- The pie chart colors

-- Progressbar {{{3
theme.progressbar_bg = theme.bg_normal -- The progressbar background color
theme.progressbar_fg = theme.fg_normal -- The progressbar foreground color
theme.progressbar_shape = theme.shape -- The progressbar shape
theme.progressbar_border_color = theme.border_color -- The progressbar border color
theme.progressbar_border_width = theme.border_width -- The progressbar outer border width
theme.progressbar_bar_shape = gears.shape.rounded_bar -- The progressbar inner shape
theme.progressbar_bar_border_width = dpi(3) -- The progressbar bar border width
theme.progressbar_bar_border_color = theme.nord2 -- The progressbar bar border color
theme.progressbar_margins = dpi(3) -- The progressbar bar border color
theme.progressbar_paddings = dpi(3) -- The progressbar bar border color

-- Prompt {{{3
theme.prompt_fg_cursor = theme.nord4 -- The prompt cursor foreground color
theme.prompt_bg_cursor = theme.nord3 -- The prompt cursor background color
theme.prompt_font = theme.font -- The prompt text font
theme.prompt_fg = theme.nord4 -- The prompt foreground color
theme.prompt_bg = theme.nord3 -- The prompt background color

-- Radialprogressbar {{{3
theme.radialprogressbar_border_color = theme.nord2 -- The progressbar border background color
theme.radialprogressbar_color = theme.nord9 -- The progressbar foreground color
theme.radialprogressbar_border_width = dpi(3) -- The progressbar border width
theme.radialprogressbar_paddings = dpi(3) -- The padding between the outline and the progressbar

-- Separator {{{3
theme.separator_thickness = dpi(3) -- The separator thickness
theme.separator_border_color = theme.border_color -- The separator border color
theme.separator_border_width = dpi(3) -- The separator border color
theme.separator_span_ratio = 1.0 -- The relative percentage covered by the bar
theme.separator_color = theme.nord3 -- The separator’s color
theme.separator_shape = gears.shape.pie -- The separator’s shape

-- Slider {{{3
theme.slider_bar_border_width = theme.border_width -- The bar (background) border width
theme.slider_bar_border_color = theme.border_width -- The bar (background) border color
theme.slider_handle_border_color = theme.border_color_active -- The handle border_color
theme.slider_handle_border_width = theme.border_width -- The handle border_color
theme.slider_handle_width = dpi(15) -- The handle border_color
theme.slider_handle_color = theme.nord9 -- The handle color
theme.slider_handle_shape = gears.shape.circle -- The handle color
theme.slider_bar_shape = theme.shape -- The bar (background) shape
theme.slider_bar_height = dpi(5) -- The bar (background) height
theme.slider_bar_margins = dpi(5) -- The bar (background) height
theme.slider_handle_margins = dpi(5) -- The bar (background) height
theme.slider_bar_color = theme.nord1 -- The bar (background) height
theme.slider_bar_active_color = theme.nord0 -- The bar (active) color

-- Systray {{{3
theme.systray_icon_spacing = dpi(3) -- The systray icon spacing

-- Taglist {{{3
theme.taglist_fg_focus = theme.nord0 -- The tag list main foreground (text) color
theme.taglist_bg_focus = theme.nord8 -- The tag list main background color
theme.taglist_fg_urgent = theme.nord0 -- The tag list urgent elements foreground (text) color
theme.taglist_bg_urgent = theme.nord11 -- The tag list urgent elements background color
theme.taglist_fg_occupied = theme.nord4 -- The tag list occupied elements foreground (text) color
theme.taglist_bg_occupied = theme.nord3 -- The tag list occupied elements background color
theme.taglist_fg_empty = theme.nord4 -- The tag list empty elements foreground (text) color
theme.taglist_bg_empty = theme.nord3 -- The tag list empty elements background color
theme.taglist_fg_volatile = theme.nord4 -- The tag list volatile elements foreground (text) color
theme.taglist_bg_volatile = theme.nord3 -- The tag list volatile elements background color
theme.taglist_squares_sel = nil -- The selected elements background image
theme.taglist_squares_unsel = nil -- The unselected elements background image
theme.taglist_squares_sel_empty = theme.taglist_squares_sel -- The selected empty elements background image
theme.taglist_squares_unsel_empty = theme.taglist_squares_unsel -- The unselected empty elements background image
theme.taglist_squares_resize = true -- If the background images can be resized
theme.taglist_disable_icon = false -- Do not display the tag icons, even if they are set
theme.taglist_font = theme.font -- The taglist font
theme.taglist_spacing = dpi(3) -- The space between the taglist elements
theme.taglist_shape = gears.shape.rounded_bar -- The main shape used for the elements
theme.taglist_shape_border_width = dpi(3) -- The shape elements border width
theme.taglist_shape_border_color = theme.nord3 -- The elements shape border color
theme.taglist_shape_empty = nil -- The shape used for the empty elements
theme.taglist_shape_border_width_empty = theme.taglist_shape_border_width -- The shape used for the empty elements border width
theme.taglist_shape_border_color_empty = theme.taglist_bg_empty -- The empty elements shape border color
theme.taglist_shape_focus = theme.taglist_shape -- The shape used for the selected elements
theme.taglist_shape_border_width_focus = theme.taglist_shape_border_width -- The shape used for the selected elements border width
theme.taglist_shape_border_color_focus = theme.taglist_bg_focus -- The selected elements shape border color
theme.taglist_shape_urgent = theme.taglist_shape -- The shape used for the urgent elements
theme.taglist_shape_border_width_urgent = theme.taglist_shape_border_width -- The shape used for the urgent elements border width
theme.taglist_shape_border_color_urgent = theme.taglist_bg_urgent -- The urgents elements shape border color
theme.taglist_shape_volatile = theme.taglist_shape -- The shape used for the volatile elements
theme.taglist_shape_border_width_volatile = theme.taglist_shape_border_width -- The shape used for the volatile elements border width
theme.taglist_shape_border_color_volatile = theme.taglist_bg_volatile -- The volatile elements shape border color

-- Tasklist {{{3
theme.tasklist_fg_normal = theme.nord4 -- The default foreground (text) color
theme.tasklist_bg_normal = theme.nord3 -- The default background color
theme.tasklist_fg_focus = theme.nord4 -- The focused client foreground (text) color
theme.tasklist_bg_focus = theme.nord3 -- The focused client background color
theme.tasklist_fg_urgent = theme.nord0 -- The urgent clients foreground (text) color
theme.tasklist_bg_urgent = theme.nord11 -- The urgent clients background color
theme.tasklist_fg_minimize = theme.tasklist_fg_normal -- The minimized clients foreground (text) color
theme.tasklist_bg_minimize = theme.tasklist_bg_normal -- The minimized clients background color
theme.tasklist_bg_image_normal = nil -- The elements default background image
theme.tasklist_bg_image_focus = nil -- The focused client background image
theme.tasklist_bg_image_urgent = nil -- The urgent clients background image
theme.tasklist_bg_image_minimize = nil -- The minimized clients background image
theme.tasklist_disable_icon = false -- Disable the tasklist client icons
theme.tasklist_disable_task_name = false -- Disable the tasklist client titles
theme.tasklist_plain_task_name = true -- Disable the extra tasklist client property notification icons
theme.tasklist_sticky = " " -- Extra tasklist client property notification icon for clients with the sticky property set
theme.tasklist_ontop = " " -- Extra tasklist client property notification icon for clients with the ontop property set
theme.tasklist_above = "禎" -- Extra tasklist client property notification icon for clients with the above property set
theme.tasklist_below = "穀" -- Extra tasklist client property notification icon for clients with the below property set
theme.tasklist_floating = " " -- Extra tasklist client property notification icon for clients with the floating property set
theme.tasklist_maximized = "" -- Extra tasklist client property notification icon for clients with the maximized property set
theme.tasklist_maximized_horizontal = "ﱟ" -- Extra tasklist client property notification icon for clients with the maximized_horizontal property set
theme.tasklist_maximized_vertical = "祈" -- Extra tasklist client property notification icon for clients with the maximized_vertical property set
theme.tasklist_font = theme.font -- The tasklist font
theme.tasklist_align = "center" -- The focused client alignment
theme.tasklist_font_focus = theme.font -- The focused client title alignment
theme.tasklist_font_minimized = theme.font -- The minimized clients font
theme.tasklist_font_urgent = theme.font -- The urgent clients font
theme.tasklist_spacing = dpi(7) -- The space between the tasklist elements
theme.tasklist_shape = gears.shape.rounded_bar -- The default tasklist elements shape
theme.tasklist_shape_border_width = dpi(3) -- The default tasklist elements border width
theme.tasklist_shape_border_color = theme.tasklist_bg_normal -- The default tasklist elements border color
theme.tasklist_shape_focus = theme.tasklist_shape -- The focused client shape
theme.tasklist_shape_border_width_focus = theme.tasklist_shape_border_width -- The focused client border width
theme.tasklist_shape_border_color_focus = theme.tasklist_bg_focus -- The focused client border color
theme.tasklist_shape_minimized = theme.tasklist_shape -- The minimized clients shape
theme.tasklist_shape_border_width_minimized = theme.tasklist_shape_border_width -- The minimized clients shape
theme.tasklist_shape_border_color_minimized = theme.bg_minimize -- The minimized clients border color
theme.tasklist_shape_urgent = theme.tasklist_shapeil -- The urgent clients shape
theme.tasklist_shape_border_width_urgent = theme.tasklist_shape_border_width -- The urgent clients border width
theme.tasklist_shape_border_color_urgent = theme.bg_urgent -- The urgent clients border color

-- Awesome {{{2
theme.awesome_icon = theme_assets.awesome_icon(
  theme.wibar_height,
  theme.nord9,
  theme.fg_focus
) -- The Awesome icon path

-- }}}1

return theme
