local M = {}
local u = require("utils")

function M.setup()
  vim.g.dashboard_default_executive = "telescope"
  vim.g.dashboard_custom_header = {
    "                                                       ",
    "                                                       ",
    " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
    " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
    " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
    " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
    " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
    " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
    "                                                       ",
    "                                                       ",
  }
  --[[ vim.g.dashboard_custom_shortcut = {
    last_session = 'SPC s l',
    new_file = 'SPC c n',
    find_file = 'SPC f f',
    find_word = 'SPC r g',
  }
  vim.g.dashboard_custom_shortcut_icon = {
    last_session = ' ',
    new_file = ' ',
    find_file = ' ',
    find_word = ' ',
  } ]]
  vim.g.dashboard_custom_footer = {}

  -- Keybindings
  local opts = { noremap = true, silent = true }
  u.map("n", "<Leader>ss", ":<C-u>SessionSave<Cr>", opts)
  u.map("n", "<Leader>sl", ":<C-u>SessionLoad<Cr>", opts)
  u.map("n", "<Leader>cn", ":DashboardNewFile<Cr>", opts)
end

return M
