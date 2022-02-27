local cmd = vim.cmd -- to execute vim commands without any output
local fn = vim.fn -- to execute vim functions

-- Install packer.nvim, if it is not yet installed {{{1
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  if
    fn.input("Packer not installed! Download and install packer.nvim? [Y/n] ")
    == "n"
  then
    return
  end
  print(" ")
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print(PACKER_BOOTSTRAP)
  cmd([[packadd packer.nvim]])
  print(
    "Installation of packer.nvim successfull. Restart nvim after :PackerSync",
    "has completed. In case of failures rerun :PackerSync until the",
    "installation succeeds."
  )
end

-- Run PackerCompile automatically whenever plugins.lua is updated
cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup END
]])

-- Plugin specification {{{1
require("packer").startup({
  function(use)
    -- Packer can manage itself
    use({
      "wbthomason/packer.nvim",
    })
    -- Theme
    use({
      "delafthi/nord-nvim",
      opt = false,
      config = function()
        require("config.nord-nvim").config()
      end,
    })
    -- Key binding documentation and display
    use({
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        require("config.which-key").config()
        require("config.keys")
      end,
    })
    -- Start screen
    use({
      "glepnir/dashboard-nvim",
      event = "VimEnter",
      setup = function()
        require("config.dashboard").setup()
      end,
    })
    -- Statusline
    use({
      "glepnir/galaxyline.nvim",
      branch = "main",
      requires = {
        "nord-nvim",
        "kyazdani42/nvim-web-devicons",
      },
      wants = { "nord-nvim", "nvim-web-devicons" },
      event = "VimEnter",
      config = function()
        require("config.galaxyline").config()
      end,
    })

    -- Editing
    -- Syntax highlighting
    use({
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "p00f/nvim-ts-rainbow",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/playground",
        "JoosepAlviste/nvim-ts-context-commentstring",
      },
      run = ":TSUpdate",
      cmd = { "TSInstall", "TSUpdate" },
      event = "BufRead",
      config = function()
        require("config.nvim-treesitter").config()
      end,
    })
    use({
      "norcalli/nvim-colorizer.lua",
      event = "BufReadPost",
      config = function()
        require("config.nvim-colorizer").config()
      end,
    })
    use({
      "lewis6991/spellsitter.nvim",
      requires = "nvim-treesitter",
      wants = "nvim-treesitter",
      event = "BufReadPost",
      config = function()
        require("config.spellsitter").config()
      end,
    })
    use({
      "folke/todo-comments.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      wants = "nvim-web-devicons",
      cmd = { "TodoTrouble", "TodoTelescope" },
      event = "BufReadPost",
      config = function()
        require("config.todo-comments").config()
      end,
    })
    -- LSP
    use({
      "neovim/nvim-lspconfig",
      requires = {
        "nvim-lua/lsp-status.nvim",
        "nvim-lua/lsp_extensions.nvim",
      },
      wants = {
        "lsp-status.nvim",
        "lsp_extensions.nvim",
      },
      event = "BufReadPre",
      config = function()
        require("config.nvim-lspconfig").config()
      end,
    })
    use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      wants = "nvim-web-devicons",
      cmd = "TroubleToggle",
      config = function()
        require("config.trouble").config()
      end,
    })
    -- Code Completion
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        "Luasnip",
        "neogen",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "kdheepak/cmp-latex-symbols",
        "f3fora/cmp-spell",
        "saadparwaiz1/cmp_luasnip",
      },
      wants = {
        "Luasnip",
        "neogen",
      },
      event = "InsertEnter",
      config = function()
        require("config.nvim-cmp").config()
      end,
    })
    use({
      "windwp/nvim-autopairs",
      requires = "nvim-treesitter",
      wants = "nvim-treesitter",
      event = "BufRead",
      config = function()
        require("config.nvim-autopairs").config()
      end,
    })
    -- Snippets
    use({
      "L3MON4D3/Luasnip",
      requires = {
        "rafamadriz/friendly-snippets",
        "VHDL-LS/rust_hdl_vscode", -- Just for the snippets
      },
      wants = {
        "friendly-snippets",
        "rust_hdl_vscode",
      },
      event = "InsertEnter",
      config = function()
        require("config.luasnip").config()
      end,
    })
    -- Commenting
    use({
      "numToStr/Comment.nvim",
      requires = "JoosepAlviste/nvim-ts-context-commentstring",
      wants = "nvim-ts-context-commentstring",
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("config.Comment").config()
      end,
    })
    use({
      "danymat/neogen",
      requires = "nvim-treesitter",
      wants = "nvim-treesitter",
      event = "BufReadPost",
      config = function()
        require("config.neogen").config()
      end,
    })
    -- Visuals/aesthetics
    use({
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("config.indent-blankline").config()
      end,
    })
    use({
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
      wants = "plenary.nvim",
      event = "BufReadPre",
      config = function()
        require("config.gitsigns").config()
      end,
    })
    -- Text formatting
    use({ "godlygeek/tabular", cmd = "Tabularize" })
    -- File formatting
    use({
      "mhartington/formatter.nvim",
      cmd = { "Format", "FormatWrite" },
      setup = function()
        require("config.formatter").setup()
      end,
      config = function()
        require("config.formatter").config()
      end,
    })
    -- Movement
    use({
      "ggandor/lightspeed.nvim",
      event = "BufReadPost",
      config = function()
        require("config.lightspeed").config()
      end,
    })

    -- Project
    -- Fuzzy finder
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzy-native.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-project.nvim",
      },
      wants = {
        "popup.nvim",
        "plenary.nvim",
        "telescope-fzy-native.nvim",
        "telescope-file-browser.nvim",
        "telescope-project.nvim",
      },
      cmd = "Telescope",
      module = "telescope",
      config = function()
        require("config.telescope").config()
      end,
    })
    -- Git
    use({
      "TimUntersberger/neogit",
      requires = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
      },
      wants = {
        "plenary.nvim",
        "diffview.nvim",
      },
      module = "neogit",
      config = function()
        require("config.neogit").config()
      end,
    })
    use({
      "folke/persistence.nvim",
      event = "BufReadPre",
      module = "persistence",
      config = function()
        require("config.persistence").config()
      end,
    })
    -- Movement
    use({
      "ThePrimeagen/harpoon",
      requires = "nvim-lua/plenary.nvim",
      wants = "plenary.nvim",
      module = "harpoon",
      config = function()
        require("config.harpoon").config()
      end,
    })
    use({
      "numToStr/Navigator.nvim",
      module = "Navigator",
      config = function()
        require("config.Navigator").config()
      end,
    })
    -- Debugging
    use({
      "mfussenegger/nvim-dap",
      module = "dap",
      config = function()
        require("config.nvim-dap").config()
      end,
    })
    use({
      "rcarriga/nvim-dap-ui",
      requires = "nvim-dap",
      after = "nvim-dap",
      module = "dapui",
      config = function()
        require("config.nvim-dap-ui").config()
      end,
    })

    -- Specific language support
    use({
      "HiPhish/guile.vim",
      ft = { "scheme" },
    })
    use({
      "p00f/clangd_extensions.nvim",
      requires = "nvim-lspconfig",
      ft = { "c", "cpp" },
      config = function()
        require("config.clangd_extensions").config()
      end,
    })
    -- Note taking
    use({
      "lukas-reineke/headlines.nvim",
      ft = { "markdown", "mkd", "norg", "org" },
      config = function()
        require("config.headlines").config()
      end,
    })
    use({
      "iamcco/markdown-preview.nvim",
      run = "cd app && yarn install",
      ft = { "markdown", "mkd" },
      setup = function()
        require("config.markdown-preview").setup()
      end,
    })
    use({
      "nvim-neorg/neorg",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-neorg/neorg-telescope",
      },
      ft = "norg",
      config = function()
        require("config.neorg").config()
      end,
    })
    use({
      "nvim-orgmode/orgmode.nvim",
      ft = "org",
      module = "orgmode",
      config = function()
        require("config.orgmode").config()
      end,
    })
    use({
      "akinsho/org-bullets.nvim",
      requires = "orgmode.nvim",
      after = "orgmode.nvim",
      ft = "org",
      config = function()
        require("config.org-bullets").config()
      end,
    })
    -- Automatically set up the configuration
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end,
  config = {
    opt_default = true,
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
    profile = {
      enable = true,
      threshold = 1,
    },
  },
})
