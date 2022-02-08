local M = {}
local keymap = vim.keymap

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

  local opts = { silent = true }
  keymap.set("n", "<Leader>gc", neogen.generate, opts)
end

return M
