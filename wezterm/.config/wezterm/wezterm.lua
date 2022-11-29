-- Add the fennel.lua library to the package path
package.path = package.path
  .. ";/usr/share/lua/5.4/?.lua;/usr/share/lua/5.4/?/init.lua"

local fennel = require("fennel")
fennel.install()

-- Populate the fennel.path
local xdg_config_home = os.getenv("XDG_CONFIG_HOME")
local home = os.getenv("HOME")
fennel.path = xdg_config_home
  .. "/wezterm/?.fnl;"
  .. xdg_config_home
  .. "/wezterm/?/init.fnl;"
  .. home
  .. "/.wezterm/?.fnl;"
  .. home
  .. "/.wezterm/?/init.fnl;"
  .. fennel.path

-- Load the fennel config
return require("fnl")
