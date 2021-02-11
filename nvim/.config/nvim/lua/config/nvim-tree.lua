local M = {}

function M.setup()
  vim.g.nvim_tree_side = 'left' -- left by default
  vim.g.nvim_tree_width = 40 -- 30 by default
  vim.g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'} -- empty by default
  vim.g.nvim_tree_auto_open = 1 -- 0 by default, opens the tree when typing `vim $DIR` or `vim`
  vim.g.nvim_tree_auto_close = 1 -- 0 by default, closes the tree when it's the last window
  vim.g.nvim_tree_quit_on_open = 1 -- 0 by default, closes the tree when you open a file
  vim.g.nvim_tree_follow = 1 -- 0 by default, this option allows the cursor to be updated when entering a buffer
  vim.g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open
  vim.g.nvim_tree_hide_dotfiles = 1 -- 0 by default, this option hides files and folders starting with a dot `.`
  vim.g.nvim_tree_git_hl = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
  vim.g.nvim_tree_root_folder_modifier = ':~' -- This is the default. See :help filename-modifiers for more options
  vim.g.nvim_tree_tab_open = 1 -- 0 by default, will open the tree when entering a new tab and the tree was previously open
  vim.g.nvim_tree_width_allow_resize  = 1 -- 0 by default, will not resize the tree when opening a file
  vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 0,
    files = 0
  }
  -- If 0, do not show the icons for one of 'git' 'folder' and 'files'
  -- 1 by default, notice that if 'files' is 1, it will only display
  -- if nvim-web-devicons is installed and on your runtimepath

  -- You can edit keybindings be defining this variable
  -- You don't have to define all keys.
  -- NOTE: the 'edit' key will wrap/unwrap a folder and open a file
  vim.g.nvim_tree_bindings = {
    edit = {'<CR>', 'o'},
    edit_vsplit = '<C-v>',
    edit_split = '<C-x>',
    edit_tab = '<C-t>',
    close_node = {'<S-CR>', '<BS>'},
    toggle_ignored = 'I',
    toggle_dotfiles = 'H',
    refresh = 'R',
    preview = '<Tab>',
    cd = '<C-]>',
    create = 'a',
    remove = 'd',
    rename = 'r',
    cut = 'x',
    copy = 'c',
    paste = 'p',
    prev_git_item = '[c',
    next_git_item = ']c',
    dir_up = '-',
    close = 'q',
  }

  -- Disable default mappings by plugin
  -- Bindings are enable by default, disabled on any non-zero value
  -- let nvim_tree_disable_keybindings=1

  -- default will show icon by default if no icon is provided
  -- default shows no icon by default
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

  local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end

  local opts = {silent = true, noremap = true}

  map('n', '<C-n>', ':NvimTreeToggle<Cr>', opts)
  map('n', '<Leader>r', ':NvimTreeRefresh<Cr>', opts)
  map('n', '<Leader>n', ':NvimTreeFindFile<Cr>', opts)

  -- a list of groups can be found at `:help nvim_tree_highlight`
  vim.cmd [[highlight NvimTreeFolderIcon guibg=blue]]

end

return M
