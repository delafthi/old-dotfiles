local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. "utilities/"

return {
  --- Default Applications
  default = {
    --- Default terminal emulator
    terminal = "wezterm start --always-new-process",
    --- Default web browser
    web_browser = "qutebrowser",
    --- Default file manager
    file_manager = "wezterm start xplr",
    --- Default network manager
    network_manager = "wezterm start nmtui",
    --- Default bluetooth manager
    bluetooth_manager = "blueman-manager",
    --- Default rofi global menu
    app_launcher = "rofi -no-lazy-grab -show drun -modi drun",
    --- Default password manager
    password_manager = "bwmenu --auto-lock 300 -c 15",
    --- Default bibliography manager
    bibliography_manager = "papis --pick-lib -s picktool rofi open title:*",
    -- Default sessior locker
    session_locker = "slock",
  },

  -- Utilities
  utils = {
    full_screenshot = "maim ~/pictures/$(date +%s).png",
    area_screenshot = "maim -s ~/pictures/$(date +%s).png",
  },
}
