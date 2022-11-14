local M = {}

function M.config()
  c = require("nordic.palette")
  -- Call the setup function
  require("twilight").setup({
    dimming = {
      alpha = 1.0,
      color = { c.bright_black },
    },
    context = 10, -- amount of lines we will try to show around the current line
  })
end

return M
