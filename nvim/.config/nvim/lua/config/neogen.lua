local M = {}
local keymap = vim.keymap

function M.setup()
  -- Define keybinding
  local opts = { silent = true }
  keymap.set("n", "<Leader>gc", function()
    require("neogen").generate()
  end, opts)
end

function M.config()
  -- Call the setup function
  require("neogen").setup({
    enabled = true,
    input_after_comment = true,
  })
end

return M
