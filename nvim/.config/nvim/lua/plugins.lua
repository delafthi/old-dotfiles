local cmd = vim.cmd -- to execute vim commands without any output
local fn = vim.fn -- to execute vim functions

-- Install packer.nvim, if it is not yet installed {{{1
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  if
    fn.input('Packer not installed! Download and install packer.nvim? [Y/n] ')
    == 'n'
  then
    return
  end
  print(' ')
  local out = fn.system({
    'git',
    'clone',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print(out)
  cmd([[packadd packer.nvim]])
  print(
    'Installation of packer.nvim successfull. Run :PackerSync to download',
    'and install all plugins. In case of failures rerun :PackerSync until the',
    'the installation succeeeds.'
  )
end

-- Run PackerCompile automatically whenever plugins.lua is updated
cmd([[autocmd BufWritePost plugins.lua PackerCompile]])

-- Plugin specification {{{1
require('packer').startup({
  function(use)
    -- Packer can manage itself
    use({ 'wbthomason/packer.nvim' })
    -- Colors
    use({
      'delafthi/nord.nvim',
      branch = 'devel',
      setup = require('config.nord').setup(),
      config = require('config.nord').config(),
    })
    -- Comment
    use({
      'b3nj5m1n/kommentary',
      setup = require('config.kommentary').setup(),
      config = require('config.kommentary').config(),
    })
    use({
      'danymat/neogen',
      requires = { 'nvim-treesitter/nvim-treesitter' },
      config = require('config.neogen').config(),
    })
    -- Completion
    use({
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-calc',
        'kdheepak/cmp-latex-symbols',
        'f3fora/cmp-spell',
        'saadparwaiz1/cmp_luasnip',
      },
      config = require('config.nvim-cmp').config(),
    })
    -- Debugging
    -- use({ "mfussenegger/nvim-dap", config = require("config.nvim-dap").config() })
    use({
      'lukas-reineke/format.nvim',
      config = require('config.format').config(),
    })
    -- Fuzzy finder
    use({
      'nvim-telescope/telescope.nvim',
      requires = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzy-native.nvim' },
      },
      config = require('config.telescope').config(),
    })
    -- Git
    use({
      'TimUntersberger/neogit',
      requires = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
      },
      config = require('config.neogit').config(),
    })
    use({
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = require('config.gitsigns').config(),
    })
    -- LSP
    use({
      'neovim/nvim-lspconfig',
      requires = {
        { 'nvim-lua/lsp-status.nvim' },
        { 'nvim-lua/lsp_extensions.nvim' },
      },
      config = require('config.nvim-lspconfig').config(),
    })
    use({
      'folke/trouble.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = require('config.trouble').config(),
    })
    use({
      'onsails/lspkind-nvim',
      config = require('config.lspkind-nvim').config(),
    })
    -- Movement
    use({
      'ggandor/lightspeed.nvim',
      config = require('config.lightspeed').config(),
    })
    -- Note taking
    use({
      'vhyrro/neorg',
      requires = 'nvim-lua/plenary.nvim',
      config = require('config.neorg').config(),
    })
    use({
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn install',
      ft = { 'markdown', 'mkd' },
      setup = require('config.markdown-preview').setup(),
      config = require('config.markdown-preview').config(),
    })
    -- Snippets
    use({ 'L3MON4D3/Luasnip', config = require('config.luasnip').config() })
    -- Start screen
    use({
      'glepnir/dashboard-nvim',
      config = function()
        vim.g.dashboard_default_executive = 'telescope'
      end,
    })
    -- Statusline
    use({
      'glepnir/galaxyline.nvim',
      branch = 'main',
      requires = {
        { 'kyazdani42/nvim-web-devicons', opt = true },
        'shaunsingh/nord.nvim',
      },
      config = require('config.galaxyline').config(),
    })
    -- Syntax highlighting
    use({
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = require('config.nvim-treesitter').config(),
    })
    use({ 'nvim-treesitter/nvim-treesitter-textobjects' })
    use({ 'p00f/nvim-ts-rainbow' })
    use({
      'norcalli/nvim-colorizer.lua',
      config = function()
        local ok, colorizer = pcall(function()
          return require('colorizer')
        end)
        if ok then
          colorizer.setup()
        end
      end,
    })
    use({
      'lewis6991/spellsitter.nvim',
      run = ':set spell',
      config = require('config.spellsitter').config(),
    })
    use({
      'folke/todo-comments.nvim',
      config = require('config.todo-comments').config(),
    })
    -- Text editing
    use({ 'godlygeek/tabular', cmd = 'Tabularize' })
    use({
      'blackCauldron7/surround.nvim',
      setup = require('config.surround').setup(),
      config = require('config.surround').config(),
    })
    -- Visuals/aesthetics
    use({
      'lukas-reineke/indent-blankline.nvim',
      branch = 'master',
      setup = require('config.indent-blankline').setup(),
    })
  end,
  config = { display = { open_fn = require('packer.util').float } },
})
