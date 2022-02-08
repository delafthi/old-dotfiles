local M = {}
local keymap = vim.keymap

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

  local opts = { silent = true }
  keymap.set({ "n", "i", "t" }, "<C-h>", navigator.left, opts)
  keymap.set({ "n", "i", "t" }, "<C-j>", navigator.down, opts)
  keymap.set({ "n", "i", "t" }, "<C-k>", navigator.up, opts)
  keymap.set({ "n", "i", "t" }, "<C-l>", navigator.right, opts)
end

return M
