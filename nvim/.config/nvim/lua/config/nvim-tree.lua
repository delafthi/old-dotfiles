local M = {}
local u = require('utils')

function M.setup()
  vim.g.nvim_tree_side = 'left'
  vim.g.nvim_tree_width = 30
  vim.g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'}
  vim.g.nvim_tree_auto_open = 1
  vim.g.nvim_tree_auto_ignore_ft = {'startify', 'vimwiki'}
  vim.g.nvim_tree_auto_close = 1
  vim.g.nvim_tree_quit_on_open = 0
  vim.g.nvim_tree_follow = 1
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_hide_dotfiles = 0
  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_root_folder_modifier = ':~'
  vim.g.nvim_tree_tab_open = 1
  vim.g.nvim_tree_width_allow_resize  = 1
  vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1
  }
  vim.g.nvim_tree_bindings = {
    edit = '<Cr>',
    edit_vsplit = '<C-v>',
    edit_split = '<C-x>',
    edit_tab = '<C-t>',
    close_node = '<BS>',
    toggle_ignored = 'I',
    toggle_dotfiles = 'H',
    refresh = 'R',
    preview = '<Tab>',
    cd = 'cd',
    create = 'i',
    remove = 'dd',
    rename = 'r',
    cut = 'dy',
    copy = 'yy',
    paste = 'pp',
    prev_git_item = 'gp',
    next_git_item = 'gn',
    dir_up = '-',
    close = 'q',
  }

  vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
      unstaged = "✗",
      staged = "✓",
      unmerged = "",
      renamed = "➜",
      untracked = "★"
    },
    folder = {
      default = "",
      open = "",
      symlink = "",
    }
  }

  local opts = {silent = true, noremap = true}

  u.map('n', '<C-n>', ':NvimTreeToggle<Cr>', opts)
  u.map('n', '<Leader>tr', ':NvimTreeRefresh<Cr>', opts)
end

return M
