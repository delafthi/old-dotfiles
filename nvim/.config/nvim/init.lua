local cmd = vim.cmd -- to execute vim commands
local fn = vim.fn -- to execute vim functions

-- Install packer.nvim, if it is not yet installed {{{1
local execute = vim.api.nvim_command
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim' .. ' ' ..
           install_path)
  cmd [[packadd packer.nvim]]
  cmd [[autocmd VimEnter * PackerInstall]]
end

-- Plugin specification {{{1
-- Only required if you have packer in your `opt` pack
cmd [[packadd packer.nvim]]
cmd [[autocmd BufWritePost init.lua PackerCompile]]

local use = require('packer').use
require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true }

  -- Colors
  use {
    'delafthi/onedarkbuddy',
    config = function() require('colorbuddy').colorscheme('onedarkbuddy') end,
    requires = {'tjdevries/colorbuddy.vim'},
  }
  -- Comment
  use {'b3nj5m1n/kommentary'}
  -- Completion
  use {
    'nvim-lua/completion-nvim',
    config = function()
      require('config.completion-nvim')
      require('completion').on_attach()
    end,
    {'nvim-treesitter/completion-treesitter', opt = true},
  }
  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    config = function() require('config.telescope') end,
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
  }
  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('config.gitsigns').setup() end,
    requires = {'nvim-lua/plenary.nvim'},
  }
  -- LSP
  use {
    'neovim/nvim-lspconfig',
    config = function() require('config.nvim-lspconfig') end,
  }
  use {'nvim-lua/lsp-status.nvim'}
  use {'nvim-lua/lsp_extensions.nvim'}
  -- Note taking
  use {
    'vimwiki/vimwiki',
    config = function() require('config.vimwiki') end,
  }
  use {
    'oberblastmeister/neuron.nvim',
    config = function() require('neuron').setup() end,
  }
  use {
    'iamcco/markdown-preview.nvim',
    cmd = 'MarkdownPreview',
    config = function() require('config.markdown-preview') end,
    ft = {'markdown', 'vimwiki'},
    run = 'cd app & yarn install',
  }
  -- Snippets
  use {
    'norcalli/snippets.nvim',
    config = function() require('snippets').use_suggested_mappings() end,
  }
  -- Start screen
  use {'mhinz/vim-startify'}
  -- Statusline
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function() require('config.galaxyline') end,
    requires = {'kyazdani42/nvim-web-devicons', opt=true},
  }
  -- Syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function() require('config.nvim-treesitter') end,
    run = ':TSUpdate',
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
  }
  -- Text editing
  use {'godlygeek/tabular'}
  use {'blackCauldron7/surround.nvim'}
end)

-- Helper functions {{{1
local function add(value, str, sep)
  sep = sep or ','
  str = str or ''
  value = type(value) == 'table' and table.concat(value, sep) or value
  return str ~= '' and table.concat({value, str}, sep) or value
end
local executable = function(e) return fn.executable(e) > 0 end
local opts_info = vim.api.nvim_get_all_options_info()
local opt = setmetatable({}, {
  __newindex = function(_, key, value)
    vim.o[key] = value
    local scope = opts_info[key].scope
    if scope == "win" then
      vim.wo[key] = value
    elseif scope == "buf" then
       vim.bo[key] = value
    end
  end
})

-- Backup {{{1
opt.backup = false -- Disable backups.
opt.confirm = true -- Prompt to save before destructive actions.
opt.swapfile = false -- Disable swapfiles.
opt.undofile = true -- Save undo history.
if fn.isdirectory(vim.o.undodir) == 0 then fn.mkdir(vim.o.undodir, 'p') end -- Create undo directory.
opt.writebackup = false -- Disable backups, when a file is written.

-- Buffers {{{1
opt.autoread = true -- Enable automatic reload of unchanged files.
cmd [[autocmd CursorHold * checktime]] -- Auto reload file, when changes where made somewhere else (for autoreload)
opt.hidden = true -- Enable modified buffers in the background.
opt.modeline = true -- Don't parse modelines (google 'vim modeline vulnerability').

-- Colorscheme {{{1
vim.g.rehash256 = 1 -- Better color support.
opt.termguicolors = true -- Enable termguicolor support.

-- Diff {{{1
-- Use in vertical diff mode, blank lines to keep sides aligned, Ignore whitespace changes
opt.diffopt = add({
    'vertical',
    'iwhite',
    'hiddenoff',
    'foldcolumn:0',
    'context:4',
    'algorithm:histogram',
    'indent-heuristic'
    }, vim.o.diffopt)

-- Display {{{1
opt.colorcolumn = '80' -- Set colorcolumn to 80
opt.cursorline = true -- Enable the cursorline.
opt.display = add {'lastline'} -- On wrap display the last line even if it does not fit
opt.errorbells = false -- Disable annoying errors
-- opt.lazyredraw = true -- Disables redraw when executing macros and other commands.
opt.linebreak = true -- Prevent wrapping between words.
opt.list = true -- Enable listchars.
 -- Set listchar characters.
opt.listchars = add {
  'eol:↲',
  'tab:»·',
  'space: ',
  'trail:',
  'extends:…',
  'precedes:…',
  'conceal:┊',
  'nbsp:☠'
}
cmd [[set list]]
opt.number = true -- Print line numbers.
opt.relativenumber = true -- Set line numbers to be relative to the cursor position.
opt.scrolloff = 4 -- Keep 8 lines above or below the cursorline
vim.g.showbreak = '>>> ' -- Show wrapped lines with a prepended string.
opt.showcmd = true -- Show command in the command line.
opt.showmode = false -- Don't show mode in the command line.
opt.signcolumn = 'yes' -- Enable sign columns left of the line numbers.
opt.synmaxcol = 1024 -- Don't syntax highlight long lines.
opt.textwidth = 80 -- Max text length.
cmd [[autocmd TextYankPost * silent! lua vim.highlight.on_yank()]] -- Enable highlight on yank.
vim.g.vimsyn_embed = 'lPr' -- Allow embedded syntax highlighting for lua, python, ruby.
opt.wrap = true -- Enable line wrapping.
opt.virtualedit = 'all' -- Allow cursor to move past end of line.
opt.visualbell = false -- Disable annoying beeps

-- Folds {{{1
opt.foldlevelstart = 10 -- Set level of opened folds, when starting vim.
opt.foldmethod = 'marker' -- The kind of folding for the current window.
opt.foldopen = add(vim.o.foldopen, 'search') -- Open folds, when something is found inside the fold.
opt.foldtext = 'folds#render()' -- Function called to display fold line.

-- Indentation {{{1
opt.autoindent = true -- Allow filetype plugins and syntax highlighting
opt.expandtab = true -- Use spaces instead of tabs
opt.joinspaces = false -- No double spaces with join after a dot
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.smartindent = true -- Insert indents automatically
opt.smarttab = true -- Automatically tab to the next softtabstop
opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing edition operations, like inserting a <Tab> or using <BS>
opt.tabstop = 2 -- Number of spaces tabs count for

-- Key mappings {{{1
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ' ' -- Set leader to space.
map('i', 'ii', '<Esc>') -- Remap ii as Escape.
-- Remap jk keys to navigate through visual lines.
map('n', 'j', 'gj')
map('v', 'j', 'gj')
map('n', 'k', 'gk')
map('v', 'k', 'gk')
-- Open terminal inside nvim with <Leader>tt.
map('n', '<Leader>tt', ':new term://fish<cr>')
-- Map window navigation to CTRL + hjkl.
map('n', '<C-h>', '<C-\\><C-n><C-w>h')
map('i', '<C-h>', '<C-\\><C-n><C-w>h')
map('t', '<C-h>', '<C-\\><C-n><C-w>h')
map('n', '<C-j>', '<C-\\><C-n><C-w>j')
map('i', '<C-j>', '<C-\\><C-n><C-w>j')
map('t', '<C-j>', '<C-\\><C-n><C-w>j')
map('n', '<C-k>', '<C-\\><C-n><C-w>k')
map('i', '<C-k>', '<C-\\><C-n><C-w>k')
map('t', '<C-k>', '<C-\\><C-n><C-w>k')
map('n', '<C-l>', '<C-\\><C-n><C-w>l')
map('i', '<C-l>', '<C-\\><C-n><C-w>l')
map('t', '<C-l>', '<C-\\><C-n><C-w>l')
-- Better resizing of windows with CTRL + arrows
map('n', '<C-Left>', '<C-\\><C-n :vertical resize +2<cr>')
map('i', '<C-Left>', '<C-\\><C-n :vertical resize +2<cr>')
map('t', '<C-Left>', '<C-\\><C-n :vertical resize +2<cr>')
map('n', '<C-Up>', '<C-\\><C-n : resize +2<cr>')
map('i', '<C-Up>', '<C-\\><C-n : resize +2<cr>')
map('t', '<C-Up>', '<C-\\><C-n : resize +2<cr>')
map('n', '<C-Down>', '<C-\\><C-n : resize -2<cr>')
map('i', '<C-Down>', '<C-\\><C-n : resize -2<cr>')
map('t', '<C-Down>', '<C-\\><C-n : resize -2<cr>')
map('n', '<C-Right>', '<C-\\><C-n :vertical resize -2<cr>')
map('i', '<C-Right>', '<C-\\><C-n :vertical resize -2<cr>')
map('t', '<C-Right>', '<C-\\><C-n :vertical resize -2<cr>')
-- Change splits layout from vertical to horizontal or vice versa.
map('n', '<Leader>lv', '<C-w>t<C-w>H')
map('n', '<Leader>lh', '<C-w>t<C-w>K')
-- Better indenting in the visual mode.
map('v', '<', '<gv')
map('v', '>', '>gv')
-- Show Telescope buffers.
map('n', '<Leader>fb', '<Cmd>Telescope buffers <cr>')
-- Show buffers and select one to kill.
map('n', '<Leader>bk', ':ls<cr>:bd<Space>')
-- Search recursively for file in current project directory.
map('n', '<Leader>ff', '<Cmd>Telescope find_files<cr>')
-- Grep in project directory.
map('n', '<Leader>fg', '<Cmd>Telescope live_grep<cr>')
-- Toggle spell checking.
map('n', '<Leader>o', ':setlocal spell!<cr>')
-- Use <Tab> and <S-Tab> to navigate through completion suggestion.
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})
-- Try to save file with sudo on files that require root permission
cmd [[ca w!! w !sudo tee >/dev/null "%"]]

-- Mouse {{{1
opt.mouse = 'nvicr' -- Enables different support modes for the mouse

-- Netrw {{{1
vim.g.netrw_banner = 0 -- Disable banner on top of the window.

-- Search {{{1
opt.hlsearch = true -- Enable search highlighting.
opt.incsearch = true -- While typing a search command, show where the pattern, as it was typed so far, matches.
opt.ignorecase = true -- Ignore case when searching.
vim.wo.scrolloff = 4 -- Lines of context
opt.showmatch = true -- Jumps to the matching bracket, if it can be seen on screen.
opt.smartcase = true -- Don't ignore case with capitals.
opt.wrapscan = true -- Searches wraps at the end of the file.
-- Use faster grep alternatives if possible
if executable('rg') then
    opt.grepprg =
        [[rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*]]
    opt.grepformat = add('%f:%l:%c:%m', vim.o.grepformat)
end

-- Spell checking {{{1
opt.spelllang = 'en_us,de_ch' -- Set spell check languages.

-- Splits {{{1
-- Fill characters for the statusline and vertical separators
opt.fillchars = add {
    'stl: ',
    'stlnc:-',
    'vert:│',
    'fold: ',
    'foldopen:▾',
    'foldclose:▸',
    'foldsep:│',
    'diff:',
    'msgsep:‾',
    'eob:~',
}
opt.splitbelow = true -- Put new windows below the current.
opt.splitright = true -- Put new windows right of the current.

-- Timings {{{1
opt.timeout = true -- Determines with 'timeoutlen' how long nvim waits for further commands after a command is received.
opt.timeoutlen = 500 -- Wait 500 milliseconds for further input.
opt.ttimeoutlen = 10 -- Wait 10 milliseconds in mappings with CTRL.

-- Title {{{1
opt.title = true -- Set window title by default.
opt.titlelen = 70 -- Set maximum title length.
opt.titleold = '%{fnamemodify(getcwd(), ":t")}' -- Set title, while exiting the vim.
opt.titlestring = '%t' -- Set title string.

-- Utils {{{1
opt.backspace = 'indent,eol,start' -- Change backspace to behave more intuitively.
opt.clipboard = 'unnamedplus' -- Enable copy paste into and out of nvim.
opt.completeopt = add {'menu', 'noinsert', 'noselect', 'longest'} -- Set completionopt to have a better completion experience.
opt.inccommand = 'nosplit' -- Show the effect of a command incrementally, as you type.
opt.path = add('**', vim.o.path) -- Searches current directory recursively

-- }}}1
