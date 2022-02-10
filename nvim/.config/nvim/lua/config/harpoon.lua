local M = {}
local keymap = vim.keymap

function M.setup()
  -- Define keybindings
  local opts = { silent = true }
  keymap.set("n", "<Leader><Space>m", function()
    require("harpoon.mark").add_file()
  end, opts)
  keymap.set("n", "<Leader><Space>", function()
    require("harpoon.ui").toggle_quick_menu()
  end, opts)
  keymap.set("n", "<Leader>1", function()
    require("harpoon.ui").nav_file(1)
  end, opts)
  keymap.set("n", "<Leader>2", function()
    require("harpoon.ui").nav_file(2)
  end, opts)
  keymap.set("n", "<Leader>3", function()
    require("harpoon.ui").nav_file(3)
  end, opts)
  keymap.set("n", "<Leader>4", function()
    require("harpoon.ui").nav_file(4)
  end, opts)
end

function M.config()
  -- Call the setup function
  require("harpoon").setup({
    global_settings = {
      save_on_toggle = false,
      save_on_change = true,
      enter_on_sendcmd = false,
    },
  })
end

return M
