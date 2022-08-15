local M = {}

function M.setup()
  -- Write the color definitions
  local c = require("nord.colors")

  vim.g.rcsv_colorpairs = {
    { c.nord11.cterm, c.nord11.gui },
    { c.nord7.cterm, c.nord7.gui },
    { c.nord12.cterm, c.nord12.gui },
    { c.nord8.cterm, c.nord8.gui },
    { c.nord13.cterm, c.nord13.gui },
    { c.nord9.cterm, c.nord9.gui },
    { c.nord14.cterm, c.nord14.gui },
    { c.nord10.cterm, c.nord10.gui },
    { c.nord15.cterm, c.nord15.gui },
  }
end

return M
