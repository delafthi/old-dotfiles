local M = {}
local keymap = vim.keymap

function M.setup()
  -- Define keybindings
  local opts = { silent = true }
  keymap.set({ "n", "i", "t" }, "<C-h>", function()
    require("Navigator").left()
  end, opts)
  keymap.set({ "n", "i", "t" }, "<C-j>", function()
    require("Navigator").down()
  end, opts)
  keymap.set({ "n", "i", "t" }, "<C-k>", function()
    require("Navigator").up()
  end, opts)
  keymap.set({ "n", "i", "t" }, "<C-l>", function()
    require("Navigator").right()
  end, opts)
end

function M.config()
  -- Call the setup function
  require("Navigator").setup({
    auto_save = nil,
    disable_on_zoom = false,
  })
end

return M
