(module plugins.init
  {autoload {nvim aniseed.nvim
             a aniseed.core
             c aniseed.compile
             ft config.filetypes
             : lazy}})

(def- plugins
  {;; Start plugins
   ;; ~~~~~~~~~~~~~

   ;; Nvim config with fennel
   :Olical/aniseed
    {:lazy false
     :priority 1}
   ;; Theme
   :olimorris/onedarkpro.nvim
    {:lazy false
     :priority 1000
     :config (fn [] ((. (require "plugins.onedarkpro") :config)))}
   ;; Set directory local variables in fennel
   :Olical/nvim-local-fennel
    {:lazy false}
   ;; Additional filetypes
   :HiPhish/guile.vim
    {:lazy false}
   :hylang/vim-hy
    {:lazy false}

   ;; Lazy plugins
   ;; ~~~~~~~~~~~

   :goolord/alpha-nvim
    {:dependencies "kyazdani42/nvim-web-devicons"
     :config (fn [] ((. (require "plugins.alpha-nvim") :config)))
     :event "VimEnter"}
   :akinsho/bufferline.nvim
    {:dependencies "kyazdani42/nvim-web-devicons"
     :init (fn [] ((. (require "plugins.bufferline") :init)))
     :config (fn [] ((. (require "plugins.bufferline") :config)))
     :event "VimEnter"}
   :p00f/clangd_extensions.nvim
    {:dependencies "neovim/nvim-lspconfig"
     :config (fn [] ((. (require "plugins.clangd-extensions") :config)))
     :ft ["c" "cpp"]}
   :numToStr/Comment.nvim
    {:dependencies "JoosepAlviste/nvim-ts-context-commentstring"
     :config (fn [] ((. (require "plugins.comment") :config)))
     :event "BufReadPost"}
   :Olical/conjure
    {:dependencies "Olical/aniseed"
     :init (fn [] ((. (require "plugins.conjure") :init)))
     :cmd "Conjure"
     :ft ft.lisps}
   :feline-nvim/feline.nvim
    {:dependencies ["olimorris/onedarkpro.nvim"
                    "kyazdani42/nvim-web-devicons"]
     :config (fn [] ((. (require "plugins.feline") :config)))
     :event "VimEnter"}
   :lewis6991/gitsigns.nvim
    {:dependencies "nvim-lua/plenary.nvim"
     :config (fn [] ((. (require "plugins.gitsigns") :config)))
     :event "BufReadPost"}
   :lukas-reineke/headlines.nvim
    {:config (fn [] ((. (require "plugins.headlines") :config)))
     :ft ["markdown" "rmd" "norg" "org"]}
   :lukas-reineke/indent-blankline.nvim
    {:main "ibl"
     :config (fn [] ((. (require "plugins.indent-blankline") :config)))
     :event "BufReadPost"}
   :L3MON4D3/Luasnip
    {:dependencies ["rafamadriz/friendly-snippets"
                    "VHDL-LS/rust_hdl_vscode"] ;; Just for the snippets
     :init (fn [] ((. (require "plugins.luasnip") :init)))
     :config (fn [] ((. (require "plugins.luasnip") :config)))
     :event "InsertEnter"}
   :jubnzv/mdeval.nvim
    {:init (fn [] ((. (require "plugins.mdeval") :init)))
     :config (fn [] ((. (require "plugins.mdeval") :config)))
     :cmd "MdEval"}
   :jakewvincent/mkdnflow.nvim
    {:config (fn [] ((. (require "plugins.mkdnflow") :config)))
     :cmd "Mkdnflow"
     :ft ["markdown" "rmd"]}
   :numToStr/Navigator.nvim
    {:init (fn [] ((. (require "plugins.navigator") :init)))
     :config (fn [] ((. (require "plugins.navigator") :config)))}
   :danymat/neogen
    {:dependencies "nvim-treesitter/nvim-treesitter"
     :init (fn [] ((. (require "plugins.neogen") :init)))
     :config (fn [] ((. (require "plugins.neogen") :config)))}
   :TimUntersberger/neogit
    {:dependencies ["sindrets/diffview.nvim"
                    "nvim-lua/plenary.nvim"]
     :init (fn [] ((. (require "plugins.neogit") :init)))
     :config (fn [] ((. (require "plugins.neogit") :config)))}
   :jose-elias-alvarez/null-ls.nvim
    {:config (fn [] ((. (require "plugins.lsp.null-ls") :config)))
     :event "BufReadPost"}
   :windwp/nvim-autopairs
    {:config (fn [] ((. (require "plugins.nvim-autopairs") :config)))
     :event "InsertEnter"}
   :hrsh7th/nvim-cmp
    {:dependencies ["hrsh7th/cmp-buffer"
                    "hrsh7th/cmp-calc"
                    "hrsh7th/cmp-cmdline"
                    {1 "PaterJason/cmp-conjure"
                     :dependencies "Olical/conjure"}
                    {1 "petertriho/cmp-git"
                     :dependencies "nvim-lua/plenary.nvim"
                     :config (fn [] ((. (require "plugins.nvim-cmp-git") :config)))}
                    {1 "saadparwaiz1/cmp_luasnip"
                     :dependencies "L3MON4D3/Luasnip"}
                    "hrsh7th/cmp-nvim-lsp"
                    "hrsh7th/cmp-nvim-lsp-document-symbol"
                    "hrsh7th/cmp-nvim-lsp-signature-help"
                    "hrsh7th/cmp-nvim-lua"
                    "hrsh7th/cmp-path"
                    "f3fora/cmp-spell"
                    "L3MON4D3/Luasnip"
                    "danymat/neogen"]
     :config (fn [] ((. (require "plugins.nvim-cmp") :config)))
     :event ["InsertEnter"
             "CmdlineEnter"]}
   :norcalli/nvim-colorizer.lua
    {:config (fn [] ((. (require "plugins.nvim-colorizer") :config)))
     :event "BufEnter"}
   :mfussenegger/nvim-dap
    {:init (fn [] ((. (require "plugins.nvim-dap") :init)))
     :config (fn [] ((. (require "plugins.nvim-dap") :config)))}
   :rcarriga/nvim-dap-ui
    {:dependencies "nvim-dap"
     :init (fn [] ((. (require "plugins.nvim-dap-ui") :init)))
     :config (fn [] ((. (require "plugins.nvim-dap-ui") :config)))}
   :neovim/nvim-lspconfig
    {:dependencies ["nvim-lua/lsp-status.nvim"
                    "nvim-lua/lsp_extensions.nvim"
                    "folke/neodev.nvim"
                    "hrsh7th/nvim-cmp"
                    "nvim-telescope/telescope.nvim"]
     :config (fn [] ((. (require "plugins.lsp.init") :config)))
     :event "BufReadPost"}
   :LhKipp/nvim-nu
    {:build ":TSInstall nu"
     :config (fn [] ((. (require "plugins.nvim-nu") :config)))
     :ft "nu"}
   :nvim-treesitter/nvim-treesitter
    {:dependencies ["nvim-treesitter/nvim-treesitter-textobjects"
                    "JoosepAlviste/nvim-ts-context-commentstring"]
     :config (fn [] ((. (require "plugins.nvim-treesitter") :config)))
     :event "BufRead"
     :cmd ["TSInstall" "TSUpdate"]}
   :nvim-treesitter/nvim-treesitter-context
    {:dependencies "nvim-treesitter/nvim-treesitter"
     :config (fn [] ((. (require "plugins.nvim-treesitter-context") :config)))
     :event "BufReadPost"
     :cmd  "TSContext"}
   :pwntester/octo.nvim
    {:dependencies ["olimorris/onedarkpro.nvim"
                    "kyazdani42/nvim-web-devicons"
                    "nvim-lua/plenary.nvim"
                    "nvim-telescope/telescope.nvim"]
     :init (fn [] ((. (require "plugins.octo") :init)))
     :config (fn [] ((. (require "plugins.octo") :config)))
     :cmd "Octo"}
   :nvim-orgmode/orgmode
    {:dependencies "nvim-treesitter/nvim-treesitter"
     :config (fn [] ((. (require "plugins.orgmode") :config)))
     :ft "org"}
   :toppair/peek.nvim
    {:init (fn [] ((. (require "plugins.peek") :init)))
     :config (fn [] ((. (require "plugins.peek") :config)))
     :build "deno task --quiet build:fast"}
   :folke/persistence.nvim
    {:init (fn [] ((. (require "plugins.persistence") :init)))
     :config (fn [] ((. (require "plugins.persistence") :config)))
     :event "BufReadPre"}
   :mechatroner/rainbow_csv
    {:dependencies "olimorris/onedarkpro.nvim"
     :init (fn [] ((. (require "plugins.rainbow-csv") :init)))
     :ft "csv"}
   :simrat39/rust-tools.nvim
    {:dependencies ["mfussenegger/nvim-dap"
                    "neovim/nvim-lspconfig"
                    "nvim-lua/plenary.nvim"]
     :config (fn [] ((. (require "plugins.lsp.rust-tools") :config)))
     :ft "rust"}
   :godlygeek/tabular
    {:cmd "Tabularize"}
   :nvim-telescope/telescope.nvim
    {:dependencies ["nvim-lua/plenary.nvim"
                    "nvim-lua/popup.nvim"
                    "nvim-telescope/telescope-file-browser.nvim"
                    {1 "nvim-telescope/telescope-fzf-native.nvim"
                     :build (.. "cmake "
                                "-S. "
                                "-Bbuild "
                                "-DCMAKE_BUILD_TYPE=Release"
                                "&& "
                                "cmake "
                                "--build build "
                                "--config Release "
                                "&& "
                                "cmake "
                                "--install build "
                                "--prefix build")}
                    "nvim-telescope/telescope-project.nvim"
                    "trouble.nvim"]
     :init (fn [] ((. (require "plugins.telescope") :init)))
     :config (fn [] ((. (require "plugins.telescope") :config)))
     :cmd "Telescope"}
   :folke/todo-comments.nvim
    {:dependencies ["olimorris/onedarkpro.nvim"
                    "kyazdani42/nvim-web-devicons"
                    "nvim-telescope/telescope.nvim"
                    "folke/trouble.nvim"]
     :init (fn [] ((. (require "plugins.todo-comments") :init)))
     :config (fn [] ((. (require "plugins.todo-comments") :config)))
     :event "BufReadPost"
     :cmd ["TodoLocList"
           "TodoQuickFix"
           "TodoTelescope"
           "TodoTrouble"]}
   :akinsho/toggleterm.nvim
    {:init (fn [] ((. (require "plugins.toggleterm") :init)))
     :config (fn [] ((. (require "plugins.toggleterm") :config)))
     :cmd "ToggleTerm"}
   :folke/trouble.nvim
    {:dependencies "kyazdani42/nvim-web-devicons"
     :init (fn [] ((. (require "plugins.trouble") :init)))
     :config (fn [] ((. (require "plugins.trouble") :config)))
     :cmd "TroubleToggle"}
   :folke/twilight.nvim
    {:dependencies "olimorris/onedarkpro.nvim"
     :config (fn [] ((. (require "plugins.twilight") :config)))
     :cmd "Twilight"}
   :guns/vim-sexp
    {:init (fn [] ((. (require "plugins.vim-sexp") :init)))
     :ft ft.lisps}
   :tpope/vim-sexp-mappings-for-regular-people
    {:dependencies ["guns/vim-sexp"
                    "tpope/vim-repeat"
                    "vim-surround"]
     :ft ft.lisps}
   :tpope/vim-surround
    {:dependencies "tpope/vim-repeat"
     :event "BufEnter"}
   :folke/which-key.nvim
    {:config (fn [] ((. (require "plugins.which-key") :config)))
     :event "VimEnter"}
   :folke/zen-mode.nvim
    {:init (fn [] ((. (require "plugins.zen-mode") :init)))
     :config (fn [] ((. (require "plugins.zen-mode") :config)))
     :cmd "ZenMode"}})

(def- config
  {:defaults
    {:lazy true}
   :git
    {:url_format "https://github.com/%s"}
   :dev
    {:path "~/1 Projects"}
   :install
    {:colorscheme ["default"]}
   :ui
    {:browser "firefox"}})

(defn setup []
  "Setup lazy.nvim"
  (lazy.setup
    (icollect [name opts (pairs plugins)]
      (a.assoc opts 1 name))
    config))
