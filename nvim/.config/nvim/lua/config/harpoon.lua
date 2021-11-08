local M = {}
local u = require("util")

function M.config()
  local ok, harpoon = pcall(function()
    return require("harpoon")
  end)

  if not ok then
    return
  end

  harpoon.setup({
    global_settings = {
      save_on_toggle = false,
      save_on_change = true,
      enter_on_sendcmd = false,
    },
  })

  local opts = { noremap = true, silent = true }
  u.map("n", "<Leader>hm", "<Cmd>lua require('harpoon.mark').add_file()<Cr>", opts)
  u.map(
    "n",
    "<Leader>ht",
    "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<Cr>",
    opts
  )
  u.map(
    "n",
    "<Leader>h1",
    "<Cmd>lua require('harpoon.ui').nav_file(1)<Cr>",
    opts
  )
  u.map(
    "n",
    "<Leader>h2",
    "<Cmd>lua require('harpoon.ui').nav_file(2)<Cr>",
    opts
  )
  u.map(
    "n",
    "<Leader>h3",
    "<Cmd>lua require('harpoon.ui').nav_file(3)<Cr>",
    opts
  )
  u.map(
    "n",
    "<Leader>h4",
    "<Cmd>lua require('harpoon.ui').nav_file(4)<Cr>",
    opts
  )
end

return M
