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
    use({ "wbthomason/packer.nvim" })
    -- Theme
    use({
      "delafthi/nord-nvim",
      config = function()
        require("config.nord-nvim").config()
      end,
    })
    -- Start screen
    use({
      "glepnir/dashboard-nvim",
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
        "JoosepAlviste/nvim-ts-context-commentstring",
      },
      run = ":TSUpdate",
      config = function()
        require("config.nvim-treesitter").config()
      end,
    })
    use({
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("config.nvim-colorizer").config()
      end,
    })
    use({
      "lewis6991/spellsitter.nvim",
      requires = "nvim-treesitter",
      config = function()
        require("config.spellsitter").config()
      end,
    })
    use({
      "folke/todo-comments.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
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
      config = function()
        require("config.nvim-lspconfig").config()
      end,
    })
    use({
      "folke/trouble.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      cmd = "TroubleToggle",
      setup = function()
        require("config.trouble").setup()
      end,
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
      config = function()
        require("config.nvim-cmp").config()
      end,
    })
    use({
      "windwp/nvim-autopairs",
      requires = "nvim-treesitter",
      config = function()
        require("config.nvim-autopairs").config()
      end,
    })
    -- Snippets
    use({
      "L3MON4D3/Luasnip",
      requires = "rafamadriz/friendly-snippets",
      setup = function()
        require("config.luasnip").setup()
      end,
      config = function()
        require("config.luasnip").config()
      end,
    })
    -- Commenting
    use({
      "numToStr/Comment.nvim",
      requires = "JoosepAlviste/nvim-ts-context-commentstring",
      config = function()
        require("config.Comment").config()
      end,
    })
    use({
      "danymat/neogen",
      requires = "nvim-treesitter",
      setup = function()
        require("config.neogen").setup()
      end,
      config = function()
        require("config.neogen").config()
      end,
    })
    -- Visuals/aesthetics
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("config.indent-blankline").config()
      end,
    })
    use({
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.gitsigns").config()
      end,
    })
    use({
      "folke/which-key.nvim",
      -- config = function()
      --   require("config.which-key").config()
      -- end,
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
      setup = function()
        require("config.lightspeed").setup()
      end,
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
      cmd = "Telescope",
      module = "telescope",
      setup = function()
        require("config.telescope").setup()
      end,
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
      module = "neogit",
      setup = function()
        require("config.neogit").setup()
      end,
      config = function()
        require("config.neogit").config()
      end,
    })
    -- Movement
    use({
      "ThePrimeagen/harpoon",
      requires = "nvim-lua/plenary.nvim",
      module = "harpoon",
      setup = function()
        require("config.harpoon").setup()
      end,
      config = function()
        require("config.harpoon").config()
      end,
    })
    use({
      "numToStr/Navigator.nvim",
      module = "Navigator",
      setup = function()
        require("config.Navigator").setup()
      end,
      config = function()
        require("config.Navigator").config()
      end,
    })
    -- Debugging
    use({
      "mfussenegger/nvim-dap",
      module = "dap",
      setup = function()
        require("config.nvim-dap").setup()
      end,
      config = function()
        require("config.nvim-dap").config()
      end,
    })
    use({
      "rcarriga/nvim-dap-ui",
      requires = "nvim-dap",
      module = "dapui",
      setup = function()
        require("config.nvim-dap-ui").setup()
      end,
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
      module = "orgmode",
      ft = "org",
      config = function()
        require("config.orgmode").config()
      end,
    })
    use({
      "akinsho/org-bullets.nvim",
      requires = "orgmode.nvim",
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
