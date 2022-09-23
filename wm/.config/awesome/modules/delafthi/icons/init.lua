--- Delafthi icons directory
--- ~~~~~~~~~~~~~~~~~~~~~~~
local gfs = require("gears.filesystem")
local delafthi_dir = gfs.get_configuration_dir() .. "modules/delafthi/"

return {
  twopane = delafthi_dir .. "icons/twopane.png",
  twopanew = delafthi_dir .. "icons/twopanew.png",
  twopanebottom = delafthi_dir .. "icons/twopanebottom.png",
  twopanebottomw = delafthi_dir .. "icons/twopanebottomw.png",
  twopaneleft = delafthi_dir .. "icons/twopaneleft.png",
  twopaneleftw = delafthi_dir .. "icons/twopaneleftw.png",
  twopanetop = delafthi_dir .. "icons/twopanetop.png",
  twopanetopw = delafthi_dir .. "icons/twopanetopw.png",
}
