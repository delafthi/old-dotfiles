local cmd = vim.cmd -- to execute vim commands without any output
local fn = vim.fn -- to execute vim functions

-- Install packer.nvim, if it is not yet installed {{{1
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  if
    fn.input("Packer not installed! Download and install packer.nvim? [Y/n] ")
    == "n"
  then
    return
  end
  print(" ")
  local out = fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print(out)
  cmd([[packadd packer.nvim]])
  print(
    "Installation of packer.nvim successfull. Run :PackerSync to download",
    "and install all plugins. In case of failures rerun :PackerSync until the",
    "the installation succeeeds."
  )
end

-- Run PackerCompile automatically whenever plugins.lua is updated
cmd([[autocmd BufWritePost plugins.lua PackerCompile]])

-- Plugin specification {{{1
require("packer").startup({
  function(use)
    -- Packer can manage itself
    use({ "wbthomason/packer.nvim" })
    -- Colors
    use({
      "delafthi/nord-nvim",
      config = require("config.nord-nvim").config(),
    })
    -- Comment
    use({
      "winston0410/commented.nvim",
      config = require("config.commented").config(),
    })
    use({
      "danymat/neogen",
      requires = { "nvim-treesitter/nvim-treesitter" },
      config = require("config.neogen").config(),
    })
    -- Completion
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-calc",
        "kdheepak/cmp-latex-symbols",
        "f3fora/cmp-spell",
        "saadparwaiz1/cmp_luasnip",
      },
      config = require("config.nvim-cmp").config(),
    })
    -- Debugging
    use({
      "mfussenegger/nvim-dap",
      config = require("config.nvim-dap").config(),
    })
    use({
      "rcarriga/nvim-dap-ui",
      requires = { "mfussenegger/nvim-dap" },
    })
    use({
      "termdebug",
      installer = function() end,
      updater = function() end,
      config = function()
        vim.cmd([[let g:termdebug_wide = 1]])
      end,
      cmd = "Termdebug",
    })
    -- Formatting
    use({
      "mhartington/formatter.nvim",
      config = require("config.formatter").config(),
    })
    -- Fuzzy finder
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzy-native.nvim" },
      },
      config = require("config.telescope").config(),
    })
    -- Git
    use({
      "TimUntersberger/neogit",
      requires = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
      },
      config = require("config.neogit").config(),
    })
    use({
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = require("config.gitsigns").config(),
    })
    -- LSP
    use({
      "neovim/nvim-lspconfig",
      requires = {
        { "nvim-lua/lsp-status.nvim" },
        { "nvim-lua/lsp_extensions.nvim" },
      },
      config = require("config.nvim-lspconfig").config(),
    })
    use({
      "folke/trouble.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = require("config.trouble").config(),
    })
    -- Navigation
    use({
      "ggandor/lightspeed.nvim",
      config = require("config.lightspeed").config(),
    })
    use({
      "numToStr/Navigator.nvim",
      config = require("config.Navigator").config(),
    })
    -- Note taking
    use({
      "iamcco/markdown-preview.nvim",
      run = "cd app && yarn install",
      ft = { "markdown", "mkd" },
      setup = require("config.markdown-preview").setup(),
      config = require("config.markdown-preview").config(),
    })
    use({
      "nvim-neorg/neorg",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-neorg/neorg-telescope",
      },
      config = require("config.neorg").config(),
      ft = "norg",
    })
    use({
      "kristijanhusak/orgmode.nvim",
      branch = "tree-sitter",
      config = require("config.orgmode").config(),
    })
    use({
      "akinsho/org-bullets.nvim",
      requires = { "kristijanhusak/orgmode.nvim" },
      config = require("config.org-bullets").config(),
      ft = { "org" },
    })
    -- Snippets
    use({ "L3MON4D3/Luasnip", config = require("config.luasnip").config() })
    -- Start screen
    use({
      "glepnir/dashboard-nvim",
      setup = require("config.dashboard").setup(),
    })
    -- Statusline
    use({
      "glepnir/galaxyline.nvim",
      branch = "main",
      requires = {
        { "kyazdani42/nvim-web-devicons", opt = true },
      },
      config = require("config.galaxyline").config(),
    })
    -- Syntax highlighting
    use({
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      run = ":TSUpdate",
      config = require("config.nvim-treesitter").config(),
    })
    use({
      "norcalli/nvim-colorizer.lua",
      config = require("config.nvim-colorizer").config(),
    })
    use({
      "lewis6991/spellsitter.nvim",
      run = ":set spell",
      config = require("config.spellsitter").config(),
    })
    use({
      "folke/todo-comments.nvim",
      config = require("config.todo-comments").config(),
    })
    -- Text editing
    use({ "godlygeek/tabular", cmd = "Tabularize" })
    use({
      "blackCauldron7/surround.nvim",
      setup = require("config.surround").setup(),
      config = require("config.surround").config(),
    })
    -- Visuals/aesthetics
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = require("config.indent-blankline").config(),
    })
    use({
      "lukas-reineke/headlines.nvim",
      config = require("config.headlines").config(),
    })
  end,
  config = { display = { open_fn = require("packer.util").float } },
})
