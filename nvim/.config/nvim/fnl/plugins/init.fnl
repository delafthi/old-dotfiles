(module plugins.init
  {autoload {nvim aniseed.nvim
             a aniseed.core
             c aniseed.compile
             : packer
             packer-util packer.util
             ft config.filetypes}})

(defn- register-autocompile []
  "Automatically run packer.compile"
  (nvim.create_autocmd "BufWritePost"
    {:pattern (.. (vim.fn.stdpath "config") "/fnl/plugins/init.fnl")
     :callback (fn []
                 (let [fnl-file (.. (vim.fn.stdpath "config")
                                    "/fnl/plugins/init.fnl")
                       lua-file (.. (vim.fn.stdpath "config")
                                    "/lua/plugins/init.lua")]
                   (vim.schedule (fn [] (c.file fnl-file lua-file)))
                   (vim.schedule (fn []
                                   (nvim.command (.. "source " lua-file))
                                   (nvim.command "PackerCompile")))))}))

(def- packer-config
  {:config
    {:opt_default true
     :display
      {:open_fn
        (fn []
         (packer-util.float {:border "single"}))}
     :profile {:enable true
               :threshold 1}}})

(def- plugins
  {;; Start plugins
   ;; ~~~~~~~~~~~~~

   ;; Nvim config with fennel
   :Olical/aniseed
    {:opt false}
   ;; Lua module load cache
   :lewis6991/impatient.nvim
    {:opt false}
   ;; Theme
   :andersevenrud/nordic.nvim
    {:opt false
      :config (fn [] ((. (require "plugins.nordic") :config)))}
   ;; Set directory local variables in fennel
   :Olical/nvim-local-fennel
    {:opt false}

   ;; Opt plugins
   ;; ~~~~~~~~~~~

   :wbthomason/packer.nvim {} ;; Packer can manage itself

   :goolord/alpha-nvim
    {:requires "kyazdani42/nvim-web-devicons"
     :wants "nvim-web-devicons"
     :event "VimEnter"
     :config (fn [] ((. (require "plugins.alpha-nvim") :config)))}
   :akinsho/bufferline.nvim
    {:requires "kyazdani42/nvim-web-devicons"
     :wants "nvim-web-devicons"
     :event "VimEnter"
     :setup (fn [] ((. (require "plugins.bufferline") :setup)))
     :config (fn [] ((. (require "plugins.bufferline") :config)))}
   :p00f/clangd_extensions.nvim
    {:requires "nvim-lspconfig"
     :wants "nvim-lspconfig"
     :ft ["c" "cpp"]
     :config (fn [] ((. (require "plugins.clangd-extensions") :config)))}
   :numToStr/Comment.nvim
    {:requires "JoosepAlviste/nvim-ts-context-commentstring"
     :wants "nvim-ts-context-commentstring"
     :keys ["gc" "gb"]
     :config (fn [] ((. (require "plugins.comment") :config)))}
   :Olical/conjure ;; <-- Check keymaps
    {:requires "aniseed"
     :wants "aniseed"
     :ft ["clojure" "fennel" "janet" "racket" "hy" "scheme" "scheme.guile"
          "lisp" "julia" "rust" "lua" "python"]
     :cmd "Conjure"
     :module "conjure"
     :setup (fn [] ((. (require "plugins.conjure") :setup)))}
   :gpanders/editorconfig.nvim
    {:event "BufReadPost"
     :module "editorconfig"}
   :feline-nvim/feline.nvim
    {:requires ["nordic.nvim"
                "kyazdani42/nvim-web-devicons"]
     :wants ["nordic.nvim"
             "nvim-web-devicons"]
     :event "VimEnter"
     :config (fn [] ((. (require "plugins.feline") :config)))}
   :lewis6991/gitsigns.nvim
    {:requires "nvim-lua/plenary.nvim"
     :wants "plenary.nvim"
     :event "BufReadPost"
     :config (fn [] ((. (require "plugins.gitsigns") :config)))}
   :HiPhish/guile.vim
    {:ft "scheme"}
   :ThePrimeagen/harpoon
    {:requires "nvim-lua/plenary.nvim"
     :wants "plenary.nvim"
     :module "harpoon"
     :setup (fn [] ((. (require "plugins.harpoon") :setup)))
     :config (fn [] ((. (require "plugins.harpoon") :config)))}
   :lukas-reineke/headlines.nvim
    {:wants "nvim-treesitter"
     :ft ["markdown" "rmd" "norg" "org"]
     :config (fn [] ((. (require "plugins.headlines") :config)))}
   :lukas-reineke/indent-blankline.nvim
    {:requires "nvim-treesitter"
     :wants "nvim-treesitter"
     :event "BufReadPost"
     :config (fn [] ((. (require "plugins.indent-blankline") :config)))}
   :L3MON4D3/Luasnip
    {:requires ["rafamadriz/friendly-snippets"
                "VHDL-LS/rust_hdl_vscode"] ;; Just for the snippets
     :wants ["friendly-snippets"
             "rust_hdl_vscode"]
     :event "InsertEnter"
     :config (fn [] ((. (require "plugins.luasnip") :config)))}
   :jubnzv/mdeval.nvim
    {:cmd "MdEval"
     :module "mdeval"
     :setup (fn [] ((. (require "plugins.mdeval") :setup)))
     :config (fn [] ((. (require "plugins.mdeval") :config)))}
   :jakewvincent/mkdnflow.nvim
    {:cmd "Mkdnflow"
     :ft ["markdown" "rmd"]
     :module "mkdnflow"
     :config (fn [] ((. (require "plugins.mkdnflow") :config)))}
   :numToStr/Navigator.nvim
    {:module "Navigator"
     :setup (fn [] ((. (require "plugins.navigator") :setup)))
     :config (fn [] ((. (require "plugins.navigator") :config)))}
   :danymat/neogen
    {:requires "nvim-treesitter"
     :wants "nvim-treesitter"
     :module "neogen"
     :setup (fn [] ((. (require "plugins.neogen") :setup)))
     :config (fn [] ((. (require "plugins.neogen") :config)))}
   :TimUntersberger/neogit
    {:requires ["sindrets/diffview.nvim"
                "nvim-lua/plenary.nvim"]
     :wants ["diffview.nvim"
             "plenary.nvim"]
     :module "neogit"
     :setup (fn [] ((. (require "plugins.neogit") :setup)))
     :config (fn [] ((. (require "plugins.neogit") :config)))}
   :nvim-neorg/neorg
    {:run ":Neorg sync-parsers"
     :requires ["nvim-neorg/neorg-telescope"
                "nvim-treesitter"
                "nvim-lua/plenary.nvim"
                "telescope.nvim"]
     :wants ["nvim-treesitter"
             "telescope.nvim"]
     :ft "norg"
     :cmd "Neorg"
     :module "neorg"
     :setup (fn [] ((. (require "plugins.neorg") :setup)))
     :config (fn [] ((. (require "plugins.neorg") :config)))}
   :jose-elias-alvarez/null-ls.nvim
    {:event "BufReadPost"
     :config (fn [] ((. (require "plugins.lsp.null-ls") :config)))}
   :windwp/nvim-autopairs
    {:event "InsertEnter"
     :config (fn [] ((. (require "plugins.nvim-autopairs") :config)))}
   :hrsh7th/nvim-cmp ;; <-- Multiple completions in :command buffer
    {:requires ["hrsh7th/cmp-buffer"
                "hrsh7th/cmp-calc"
                "hrsh7th/cmp-cmdline"
                {1 "PaterJason/cmp-conjure"
                 :requires "conjure"
                 :wants "conjure"}
                {1 "petertriho/cmp-git"
                 :requires "nvim-lua/plenary.nvim"
                 :wants "plenary.nvim"
                 :config (fn [] ((. (require "plugins.nvim-cmp-git") :config)))}
                {1 "saadparwaiz1/cmp_luasnip"
                 :requires "Luasnip"
                 :wants "Luasnip"}
                "hrsh7th/cmp-nvim-lsp"
                "hrsh7th/cmp-nvim-lsp-document-symbol"
                "hrsh7th/cmp-nvim-lsp-signature-help"
                "hrsh7th/cmp-nvim-lua"
                "hrsh7th/cmp-path"
                "f3fora/cmp-spell"
                "Luasnip"
                "neogen"]
     :wants "Luasnip"
     :event ["InsertEnter"
             "CmdlineEnter"]
     :config (fn [] ((. (require "plugins.nvim-cmp") :config)))}
   :norcalli/nvim-colorizer.lua
    {:event "BufEnter"
     :config (fn [] ((. (require "plugins.nvim-colorizer") :config)))}
   :mfussenegger/nvim-dap
    {:module "dap"
     :setup (fn [] ((. (require "plugins.nvim-dap") :setup)))
     :config (fn [] ((. (require "plugins.nvim-dap") :config)))}
   :rcarriga/nvim-dap-ui
    {:requires "nvim-dap"
     :after "nvim-dap"
     :module "dapui"
     :setup (fn [] ((. (require "plugins.nvim-dap-ui") :setup)))
     :config (fn [] ((. (require "plugins.nvim-dap-ui") :config)))}
   :neovim/nvim-lspconfig
    {:requires ["nvim-lua/lsp-status.nvim"
                "nvim-lua/lsp_extensions.nvim"
                "folke/neodev.nvim"
                "nvim-cmp"
                "telescope.nvim"]
     :wants ["lsp-status.nvim"
             "lsp_extensions.nvim"
             "neodev.nvim"
             "nvim-cmp"]
     :event "BufReadPost"
     :config (fn [] ((. (require "plugins.lsp.init") :config)))}
   :nvim-treesitter/nvim-treesitter
    {:requires ["nvim-treesitter/nvim-treesitter-textobjects"
                "JoosepAlviste/nvim-ts-context-commentstring"
                "p00f/nvim-ts-rainbow"
                "nvim-treesitter/playground"]
     :run ":TSUpdate"
     :cmd ["TSInstall"
           "TSUpdate"]
     :module "nvim-treesitter"
     :event "BufRead"
     :config (fn [] ((. (require "plugins.nvim-treesitter") :config)))}
   :nvim-treesitter/nvim-treesitter-context
    {:requires "nvim-treesitter"
     :wants "nvim-treesitter"
     :cmd  "TSContext"
     :event "BufReadPost"
     :config (fn [] ((. (require "plugins.nvim-treesitter-context") :config)))}
   :pwntester/octo.nvim
    {:requires ["nordic.nvim"
                "kyazdani42/nvim-web-devicons"
                "nvim-lua/plenary.nvim"
                "telescope.nvim"]
     :wants ["nordic.nvim"
             "nvim-web-devicons"
             "plenary.nvim"]
     :cmd "Octo"
     :module "octo"
     :setup (fn [] ((. (require "plugins.octo") :setup)))
     :config (fn [] ((. (require "plugins.octo") :config)))}
   :nvim-orgmode/orgmode
    {:requires "nvim-treesitter"
     :wants "nvim-treesitter"
     :ft "org"
     :config (fn [] ((. (require "plugins.orgmode") :config)))}
   :toppair/peek.nvim
    {:run "deno task --quiet build:fast"
     :module "peek"
     :setup (fn [] ((. (require "plugins.peek") :setup)))
     :config (fn [] ((. (require "plugins.peek") :config)))}
   :folke/persistence.nvim
    {:event "BufReadPre"
     :module "persistence"
     :setup (fn [] ((. (require "plugins.persistence") :setup)))
     :config (fn [] ((. (require "plugins.persistence") :config)))}
   :mechatroner/rainbow_csv
    {:requires "nordic.nvim"
     :ft "csv"
     :setup (fn [] ((. (require "plugins.rainbow-csv") :setup)))}
   :godlygeek/tabular
    {:cmd "Tabularize"}
   :nvim-telescope/telescope.nvim ;; <-- keymaps not loading
    {:requires ["nvim-lua/plenary.nvim"
                "nvim-lua/popup.nvim"
                "nvim-telescope/telescope-file-browser.nvim"
                {1 "nvim-telescope/telescope-fzf-native.nvim"
                 :run (.. "cmake "
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
                "nvim-telescope/telescope-project.nvim"]
     :wants ["plenary.nvim"
             "popup.nvim"
             "telescope-file-browser.nvim"
             "telescope-fzf-native.nvim"
             "telescope-project.nvim"]
     :cmd "Telescope"
     :module "telescope"
     :setup (fn [] ((. (require "plugins.telescope") :setup)))
     :config (fn [] ((. (require "plugins.telescope") :config)))}
   :folke/todo-comments.nvim
    {:requires ["nordic.nvim"
                "kyazdani42/nvim-web-devicons"]
     :wants ["nordic.nvim"
             "nvim-web-devicons"]
     :cmd ["TodoLocList"
           "TodoQuickFix"
           "TodoTelescope"
           "TodoTrouble"]
     :event "BufReadPost"
     :config (fn [] ((. (require "plugins.todo-comments") :config)))}
   :akinsho/toggleterm.nvim
    {:cmd "ToggleTerm"
     :module "toggleterm"
     :setup (fn [] ((. (require "plugins.toggleterm") :setup)))
     :config (fn [] ((. (require "plugins.toggleterm") :config)))}
   :folke/trouble.nvim
    {:requires "kyazdani42/nvim-web-devicons"
     :wants "nvim-web-devicons"
     :cmd "TroubleToggle"
     :setup (fn [] ((. (require "plugins.trouble") :setup)))
     :config (fn [] ((. (require "plugins.trouble") :config)))}
   :folke/twilight.nvim
    {:requires "nordic.nvim"
     :wants "nordic.nvim"
     :cmd "Twilight"
     :module "twilight"
     :config (fn [] ((. (require "plugins.twilight") :config)))}
   :jbyuki/venn.nvim
    {:cmd "VBox"
     :setup (fn [] ((. (require "plugins.venn") :setup)))}
   :guns/vim-sexp
    {:ft ft.lisps
     :setup (fn [] ((. (require "plugins.vim-sexp") :setup)))}
   :tpope/vim-sexp-mappings-for-regular-people
    {:requires ["vim-sexp"
                "tpope/vim-repeat"
                "vim-surround"]
     :wants ["vim-sexp"
             "vim-repeat"
             "vim-surround"]
     :ft ft.lisps}
   :tpope/vim-surround
    {:requires "tpope/vim-repeat"
     :wants "vim-repeat"
     :event "BufEnter"}
   :folke/which-key.nvim
    {:event "VimEnter"
     :module "which-key"
     :config (fn [] ((. (require "plugins.which-key") :config)))}
   :folke/zen-mode.nvim
    {:cmd "ZenMode"
     :module "zen-mode"
     :setup (fn [] ((. (require "plugins.zen-mode") :setup)))
     :config (fn [] ((. (require "plugins.zen-mode") :config)))}})

(defn- use [plugins packer-config]
  "Use the plugin with opts"
  (packer.startup
    (a.assoc packer-config 1
      (fn [use]
        (each [name opts (pairs plugins)]
          (use (a.assoc opts 1 name)))
        (when _G.PACKER_BOOTSTRAP
          (packer.sync))))))

(defn setup []
  "Setup plugins"
  (register-autocompile)
  (use plugins packer-config))
