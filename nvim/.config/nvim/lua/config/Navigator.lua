local M = {}
local u = require("utils")

function M.config()
  local ok, navigator = pcall(function()
    return require("Navigator")
  end)

  if not ok then
    return
  end

  navigator.setup({
    auto_save = nil,
    disable_on_zoom = false,
  })

  local opts = { noremap = true, silent = true }
  u.map("n", "<C-h>", "<Cmd>lua require('Navigator').left()<Cr>", opts)
  u.map("i", "<C-h>", "<Cmd>lua require('Navigator').left()<Cr>", opts)
  u.map("t", "<C-h>", "<Cmd>lua require('Navigator').left()<Cr>", opts)
  u.map("n", "<C-j>", "<Cmd>lua require('Navigator').down()<Cr>", opts)
  u.map("i", "<C-j>", "<Cmd>lua require('Navigator').down()<Cr>", opts)
  u.map("t", "<C-j>", "<Cmd>lua require('Navigator').down()<Cr>", opts)
  u.map("n", "<C-k>", "<Cmd>lua require('Navigator').up()<Cr>", opts)
  u.map("i", "<C-k>", "<Cmd>lua require('Navigator').up()<Cr>", opts)
  u.map("t", "<C-k>", "<Cmd>lua require('Navigator').up()<Cr>", opts)
  u.map("n", "<C-l>", "<Cmd>lua require('Navigator').right()<Cr>", opts)
  u.map("i", "<C-l>", "<Cmd>lua require('Navigator').right()<Cr>", opts)
  u.map("t", "<C-l>", "<Cmd>lua require('Navigator').right()<Cr>", opts)
end

return M
