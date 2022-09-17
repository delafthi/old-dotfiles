--- Twopane Icons Directory
--- ~~~~~~~~~~~~~~~~~~~~~~~
local gfs = require("gears.filesystem")
local twopane_dir = gfs.get_configuration_dir() .. "modules/twopane/"

return {
  twopane = twopane_dir .. "icons/twopane.png",
  twopanew = twopane_dir .. "icons/twopanew.png",
  twopanebottom = twopane_dir .. "icons/twopanebottom.png",
  twopanebottomw = twopane_dir .. "icons/twopanebottomw.png",
  twopaneleft = twopane_dir .. "icons/twopaneleft.png",
  twopaneleftw = twopane_dir .. "icons/twopaneleftw.png",
  twopanetop = twopane_dir .. "icons/twopanetop.png",
  twopanetopw = twopane_dir .. "icons/twopanetopw.png",
}
