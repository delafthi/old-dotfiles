--- Icons directory
local gfs = require("gears.filesystem")
local dir = gfs.get_configuration_dir() .. "icons/"

return {
  layout = {
    centered = dir .. "layout/centeredw.png",
  },
  awesome_logo = dir .. "awesome-logo.svg",
}
