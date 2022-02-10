local M = {}

function M.config()
  -- Call the setup function
  require("colorizer").setup({
    "*",
    "!packer",
    "!dashboard",
    "!help",
    "!terminal",
    "!neogit",
  })
end

return M
