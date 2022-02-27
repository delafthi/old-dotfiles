local M = {}

function M.config()
  require("persistence").setup({
    dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
    options = { "buffers", "curdir", "tabpages", "winsize" },
  })
end

return M
