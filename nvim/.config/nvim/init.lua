local cmd = vim.cmd -- to execute vim commands
local fn = vim.fn -- to execute vim functions

-- Install packer.nvim, if it is not yet installed {{{1
local execute = vim.api.nvim_command
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim' .. ' ' ..
           install_path)
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
    config = function() require('conf.gitsigns').setup() end,
    disable = true,
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
    disable = true,
  }
  use {
    'oberblastmeister/neuron.nvim',
    config = function() require('neuron').setup() end,
  }
  use {
    'iamcco/markdown-preview.nvim',
    config = function() require('config.markdown-preview') end,
    ft = {'markdown', 'vimwiki'},
    run = 'vim.cmd[[cd app & yarn install]]',
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

-- Backup {{{1
vim.o.backup = false -- Disable backups.
vim.o.confirm = true -- Prompt to save before destructive actions.
vim.o.swapfile = false -- Disable swapfiles.
vim.o.undofile = true -- Save undo history.
if fn.isdirectory(vim.o.undodir) == 0 then fn.mkdir(vim.o.undodir, 'p') end -- Create undo directory.
vim.o.writebackup = false -- Disable backups, when a file is written.

-- Buffers {{{1
vim.o.autoread = true -- Enable automatic reload of unchanged files.
cmd [[autocmd CursorHold * checktime]] -- Auto reload file, when changes where made somewhere else (for autoreload)
vim.o.hidden = true -- Enable modified buffers in the background.
vim.o.modeline = true -- Don't parse modelines (google 'vim modeline vulnerability').

-- Colorscheme {{{1
vim.g.rehash256 = 1 -- Better color support.
vim.o.termguicolors = true -- Enable termguicolor support.

-- Diff {{{1
-- Use in vertical diff mode, blank lines to keep sides aligned, Ignore whitespace changes
vim.o.diffopt = add({
    'vertical', 'iwhite', 'hiddenoff', 'foldcolumn:0', 'context:4',
    'algorithm:histogram', 'indent-heuristic'
}, vim.o.diffopt)

-- Display {{{1
vim.o.colorcolumn = '80' -- Set colorcolumn to 80
vim.o.cursorline = true -- Enable the cursorline.
vim.o.display = add {'lastline'} -- On wrap display the last line even if it does not fit
vim.o.errorbells = false -- Disable annoying errors
-- vim.o.lazyredraw = true -- Disables redraw when executing macros and other commands.
vim.o.linebreak = true -- Prevent wrapping between words.
vim.o.list = true -- Enable listchars.
 -- Set listchar characters.
vim.o.listchars = add {
  'eol:↲',
  'tab:»·',
  'space:',
  'trail:',
  'extends:…',
  'precedes:…',
  'conceal:┊',
  'nbsp:☠',
}
vim.o.number = true -- Print line numbers.
vim.o.relativenumber = true -- Set line numbers to be relative to the cursor position.
vim.o.scrolloff = 8 -- Keep 8 lines above or below the cursorline
vim.o.shortmess = add({'I'}, vim.o.shortmess) -- Disables intro message, when starting vim.
vim.g.showbreak = '>>> ' -- Show wrapped lines with a prepended string.
vim.o.showcmd = true -- Show command in the command line.
vim.o.showmode = false -- Don't show mode in the command line.
vim.o.signcolumn = 'yes' -- Enable sign columns left of the line numbers.
vim.o.synmaxcol = 1024 -- Don't syntax highlight long lines.
vim.o.textwidth = 80 -- Max text length.
cmd [[autocmd TextYankPost * silent! lua vim.highlight.on_yank()]] -- Enable highlight on yank.
vim.g.vimsyn_embed = 'lPr' -- Allow embedded syntax highlighting for lua, python, ruby.
vim.o.wrap = true -- Enable line wrapping.
vim.o.virtualedit = 'all' -- Allow cursor to move past end of line.
vim.o.visualbell = false -- Disable annoying beeps

-- Folds {{{1
vim.o.foldlevelstart = 10 -- Set level of opened folds, when starting vim.
vim.o.foldmethod = 'marker' -- The kind of folding for the current window.
vim.o.foldopen = add(vim.o.foldopen, 'search') -- Open folds, when something is found inside the fold.
vim.o.foldtext = 'folds#render()' -- Function called to display fold line.

-- Indentation {{{1
vim.o.autoindent = true -- Allow filetype plugins and syntax highlighting
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.joinspaces = false -- No double spaces with join after a dot
vim.o.shiftround = true -- Round indent
vim.o.shiftwidth = 2 -- Size of an indent
vim.o.smartindent = true -- Insert indents automatically
vim.o.smarttab = true -- Automatically tab to the next softtabstop
vim.o.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing edition operations, like inserting a <Tab> or using <BS>
vim.o.tabstop = 2 -- Number of spaces tabs count for

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
map('v', 'j', 'gk')
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
map('i', '<Tab>', '<expr>pumvisible() ? "\\<C-n>" : "\\<Tab>"')
map('i', '<S-Tab>', '<expr>pumvisible() ? "\\<C-p>" : "\\<S-Tab>"')
-- Try to save file with sudo on files that require root permission
cmd [[ca w!! w !sudo tee >/dev/null "%"]]

-- Mouse {{{1
vim.o.mouse = 'nvicr' -- Enables different support modes for the mouse

-- Netrw {{{1
vim.g.netrw_banner = 0 -- Disable banner on top of the window.

-- Search {{{1
vim.o.hlsearch = true -- Enable search highlighting.
vim.o.incsearch = true -- While typing a search command, show where the pattern, as it was typed so far, matches.
vim.o.ignorecase = true -- Ignore case when searching.
vim.o.scrolloff = 4 -- Lines of context
vim.o.showmatch = true -- Jumps to the matching bracket, if it can be seen on screen.
vim.o.smartcase = true -- Don't ignore case with capitals.
vim.o.wrapscan = true -- Searches wraps at the end of the file.
-- Use faster grep alternatives if possible
if executable('rg') then
    vim.o.grepprg =
        [[rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*]]
    vim.o.grepformat = add('%f:%l:%c:%m', vim.o.grepformat)
end

-- Spell checking {{{1
vim.o.spelllang = 'en_us,de_ch' -- Set spell check languages.

-- Splits {{{1
-- Fill characters for the statusline and vertical separators
vim.o.fillchars = add {
    'stl: ',
    'stlnc:-',
    'vert:│',
    'fold: ',
    'diff:',
    'msgsep:^',
    'eop:~',
}
vim.o.splitbelow = true -- Put new windows below the current.
vim.o.splitright = true -- Put new windows right of the current.

-- Timings {{{1
vim.o.timeout = true -- Determines with 'timeoutlen' how long nvim waits for further commands after a command is received.
vim.o.timeoutlen = 500 -- Wait 500 milliseconds for further input.
vim.o.ttimeoutlen = 10 -- Wait 10 milliseconds in mappings with CTRL.

-- Title {{{1
vim.o.title = true -- Set window title by default.
vim.o.titlelen = 70 -- Set maximum title length.
vim.o.titleold = '%{fnamemodify(getcwd(), ":t")}' -- Set title, while exiting the vim.
vim.o.titlestring = '%t' -- Set title string.

-- Utils {{{1
vim.o.backspace = 'indent,eol,start' -- Change backspace to behave more intuitively.
vim.o.clipboard = 'unnamedplus' -- Enable copy paste into and out of nvim.
vim.o.completeopt = add {'menu', 'noinsert', 'noselect', 'longest'} -- Set completionopt to have a better completion experience.
vim.o.inccommand = 'nosplit' -- Show the effect of a command incrementally, as you type.
vim.o.path = add({'**'}, vim.o.path) -- Searches current directory recursively

-- }}}1
