local M = {}

function M.config()
  -- Call the setup function
  require("persistence").setup({
    dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
    options = { "buffers", "curdir", "tabpages", "winsize" },
  })
end

return M
