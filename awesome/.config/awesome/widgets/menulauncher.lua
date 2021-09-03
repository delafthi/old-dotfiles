-- awesome_mode: api-level=4:screen=on
-----------------------------------------------------------
-- Includes {{{1
pcall(require, 'luarocks.loader')
-- Standard awesome libraries
local gears = require('gears') -- Utilities such as color parsing and objects
local awful = require('awful') -- Everything related to window management
require('awful.autofocus')
-- Widget and layout library
local wibox = require('wibox') -- Awesome own generic widget framework
-- Theme handling library
local beautiful = require('beautiful') -- Awesome theme module
local hotkeys_popup = require('awful.hotkeys_popup')
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require('awful.hotkeys_popup.keys')

local M = {}

-- Default applications
local terminal = 'kitty' -- default terminal
local browser = 'brave' -- default browser
local visual_filemanager = 'pcmanfm' -- default graphical fm
local filemanager = 'ranger' -- default fm
local filemanager_cmd = terminal .. ' -e ' .. filemanager -- command to open the fm
local editor = os.getenv('EDITOR') or 'nvim' -- default editor
local editor_cmd = terminal .. ' -e ' .. editor -- command to open the editor

-- Launcher menu {{{1
local menu = awful.menu({
  items = {
    { 'edit config', editor_cmd .. ' ' .. awesome.conffile },
    {
      'hotkeys',
      function()
        hotkeys_popup.show_help(nil, awful.screen.focused())
      end,
    },
    {
      'restart',
      function()
        awesome.restart()
      end,
    },
    {
      'quit',
      function()
        awesome.quit()
      end,
    },
  },
})

-- Launcher widget
function M.get_widget()
  local menulauncher = wibox.widget({
    image = beautiful.awesome_icon,
    clip_shape = gears.shape.rounded_bar,
    resize = true,
    widget = wibox.widget.imagebox,
    buttons = { awful.button({}, 1, function()
      menu:toggle()
    end) },
  })
  return menulauncher
end

return M

-- }}}1
