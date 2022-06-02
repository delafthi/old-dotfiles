local M = {}

function M.config()
  -- Call the setup function
  require("colorizer").setup({
    "*",
    "!packer",
    "!alpha",
    "!help",
    "!terminal",
    "!neogit",
  })
end

return M
