(module plugins.lsp.init
  {autoload {a aniseed.core
             : lspconfig
             lspconfig-configs lspconfig.configs
             lspconfig-util lspconfig.util
             lsp-diagnostics plugins.lsp.diagnostics
             lsp-options plugins.lsp.options
             neodev neodev
             nvim aniseed.nvim}})

(defn- add-ls-config [name config]
  "Add custom language-server configuration"
  (when (a.nil? (. lspconfig-configs name))
        (tset lspconfig-configs name config)))

(defn- setup-lsp [ls opts]
  "Setup an lsp server"
  (let [setup (. (. lspconfig ls) :setup)
        opts (vim.tbl_deep_extend "force"
               {:on_attach lsp-options.on-attach
                :capabilities lsp-options.capabilities} opts)]
    (setup opts)))

;; Add additional ls configurations
(def- rust-hdl-config
  {:default_config
    {:cmd ["vhdl_ls"]
     :filetypes ["vhdl"]
     :root_dir (fn [fname]
                 (or ((lspconfig-util.root_pattern "vhdl_ls.toml") fname)
                     (lspconfig-util.find_git_ancestor fname)))
     :docs
     {:description (.. "https://github.com/VHDL-LS/rust_hdl\n"
                       "\n"
                       "A collection of HDL related tools")}}})

(def- lsp-servers
  {:bashls {}
   :cmake {}
   :dockerls {}
   :ltex
    {:settings
      {:ltex
        {:disabledRules
          {:en-US ["ARROWS"]}
         :additionalRules
          {:enablePickyRules true
           :motherTongue "de-CH"
           :languageModel "~/.local/share/language-tool/ngrams/"}}}}
   :pylsp
    {:settings
      {:pylsp
        {:plugins
          {:autopep8 {:enabled false}
           :flake8 {:enabled true}
           :pydocstyle {:enabled false}
           :rope_autoimport {:enabled true}}
          :configurationSources ["flake8"]}}}
   :lua_ls
    {:single_file_support true
     :settings
      {:Lua
        {:completion
          {:workspaceWord true
           :callSnippet "Replace"}
         :diagnostics
          {:unusedLocalExclude ["_*"]}
         :format
          {:enable false
           :defaultConfig
            {:indent_style "space"
             :indent_size (tostring (vim.opt.shiftwidth:get))
             :continuation_indent_size (tostring (vim.opt.shiftwidth:get))}}}}}
   :texlab {}
   :rust_hdl {}
   :vimls {}})

(defn config []
  "Configure nvim-lspconfig"
  ;; Call neodev's setup function
  (neodev.setup {})

  ;; Setup diagnostics
  (lsp-diagnostics.setup)

  ;; Add custom language servers
  (add-ls-config :rust_hdl rust-hdl-config)

  ;; Call the setup functions for language servers
  (each [ls opts (pairs lsp-servers)]
    (setup-lsp ls opts)))
