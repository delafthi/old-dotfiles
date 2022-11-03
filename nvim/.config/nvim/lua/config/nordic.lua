local M = {}

function M.config()
  require("nordic").colorscheme({
    underline_option = "undercurl",
    alternate_backgrounds = true,
  })
end

return M
