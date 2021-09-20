local M = {}
local u = require("util")

function M.config()
  local ok, neogen = pcall(function()
    return require("neogen")
  end)

  if not ok then
    return
  end

  neogen.setup({
    enabled = true,
    input_after_comment = true,
  })

  local opts = { noremap = true, silent = true }
  u.map("n", "<Leader>gc", ":lua require('neogen').generate()<CR>", opts)
end

return M
