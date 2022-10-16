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
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile",
  group = vim.api.nvim_create_augroup("packerUserConfig", { clear = true }),
})
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
      "goolord/alpha-nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      wants = { "nvim-web-devicons" },
      event = "VimEnter",
      config = function()
        require("config.alpha-nvim").config()
      end,
    })
    -- Statusline
    use({
      "feline-nvim/feline.nvim",
      requires = {
        "nord-nvim",
        "kyazdani42/nvim-web-devicons",
      },
      wants = { "nord-nvim", "nvim-web-devicons" },
      event = "VimEnter",
      config = function()
        require("config.feline").config()
      end,
    })
    -- Session Management
    use({
      "folke/persistence.nvim",
      event = "BufReadPre",
      module = "persistence",
      config = function()
        require("config.persistence").config()
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
      "nvim-treesitter/nvim-treesitter-context",
      requires = "nvim-treesitter",
      wants = "nvim-treesitter",
      cmd = "TSContext",
      event = "BufReadPost",
      config = function()
        require("config.nvim-treesitter-context").config()
      end,
    })
    use({
      "norcalli/nvim-colorizer.lua",
      event = "BufEnter",
      config = function()
        require("config.nvim-colorizer").config()
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
      event = "BufReadPost",
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
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",
        "f3fora/cmp-spell",
        {
          "petertriho/cmp-git",
          requires = "nvim-lua/plenary.nvim",
          wants = "plenary.nvim",
          config = function()
            require("cmp_git").setup({
              filetypes = {
                "gitcommit",
                "octo",
                "NeogitCommitMessage",
              },
            })
          end,
        },
        "saadparwaiz1/cmp_luasnip",
      },
      wants = {
        "Luasnip",
        "neogen",
      },
      event = { "InsertEnter", "CmdlineEnter" },
      config = function()
        require("config.nvim-cmp").config()
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
      module = "neogen",
      config = function()
        require("config.neogen").config()
      end,
    })
    -- Visuals/aesthetics
    use({
      "lukas-reineke/indent-blankline.nvim",
      requires = "nvim-treesitter",
      wants = "nvim-treesitter",
      event = "BufReadPost",
      config = function()
        require("config.indent-blankline").config()
      end,
    })
    use({
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
      wants = "plenary.nvim",
      event = "BufReadPost",
      config = function()
        require("config.gitsigns").config()
      end,
    })
    use({
      "akinsho/bufferline.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      wants = "nvim-web-devicons",
      event = "BufReadPre",
      config = function()
        require("config.bufferline").config()
      end,
    })
    use({
      "folke/zen-mode.nvim",
      cmd = "ZenMode",
      module = "zen-mode",
      config = function()
        require("config.zen-mode").config()
      end,
    })
    use({
      "folke/twilight.nvim",
      cmd = "Twilight",
      module = "twilight",
      config = function()
        require("config.twilight").config()
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
      "pwntester/octo.nvim",
      requires = {
        "nord-nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "kyazdani42/nvim-web-devicons",
      },
      wants = {
        "nord-nvim",
        "plenary.nvim",
        "telescope.nvim",
        "nvim-web-devicons",
      },
      cmd = "Octo",
      module = "octo",
      config = function()
        require("config.octo").config()
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
      "akinsho/toggleterm.nvim",
      cmd = "ToggleTerm",
      module = "toggleterm",
      config = function()
        require("config.toggleterm").config()
      end,
    })
    use({
      "HiPhish/guile.vim",
      ft = { "scheme" },
    })
    use({
      "p00f/clangd_extensions.nvim",
      requires = "nvim-lspconfig",
      wants = "nvim-lspconfig",
      ft = { "c", "cpp" },
      config = function()
        require("config.clangd_extensions").config()
      end,
    })
    use({
      "mechatroner/rainbow_csv",
      requires = {
        "nord-nvim",
      },
      ft = { "csv" },
      setup = function()
        require("config.rainbow_csv").setup()
      end,
    })
    -- Note taking
    use({
      "lukas-reineke/headlines.nvim",
      ft = { "markdown", "rmd" },
      config = function()
        require("config.headlines").config()
      end,
    })
    use({
      "iamcco/markdown-preview.nvim",
      run = "cd app && yarn install",
      ft = { "markdown", "rmd" },
      setup = function()
        require("config.markdown-preview").setup()
      end,
    })
    use({
      "jakewvincent/mkdnflow.nvim",
      cmd = "Mkdnflow",
      ft = { "markdown", "rmd" },
      module = "mkdnflow",
      config = function()
        require("config.mkdnflow").config()
      end,
    })
    use({
      "jubnzv/mdeval.nvim",
      ft = { "norg", "markdown", "rmd" },
      cmd = "MdEval",
      module = "mdeval",
      config = function()
        require("config.mdeval").config()
      end,
    })
    use({
      "nvim-neorg/neorg",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-neorg/neorg-telescope",
      },
      wants = { "nvim-treesitter", "telescope.nvim" },
      ft = "norg",
      cmd = { "Neorg", "NeorgStart" },
      module = "neorg",
      config = function()
        require("config.neorg").config()
      end,
    })
    use({
      "nvim-orgmode/orgmode",
      requires = { "nvim-treesitter" },
      wants = { "nvim-treesitter" },
      ft = "org",
      config = function()
        require("config.orgmode").config()
      end,
    })
    use({
      "jbyuki/venn.nvim",
      cmd = { "VBox" },
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
