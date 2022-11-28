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
          {:en-US ["MORFOLOGIK_RULE_EN_US"]
           :de-CH ["MORFOLOGIK_RULE_DE_CH"]
           :fr ["MORFOLOGIK_RULE_FR"]}
         :additionalRules
          {:languageModel "~/.local/share/language-tool/ngrams/"
           :motherTongue "de-CH"}}}}
   :pylsp
    {:settings
      {:pylsp
        {:plugins
          {:autopep8 {:enabled false}
           :pydocstyle {:enabled true}}}}}
   :rls
    {:settings
      {:rust
        {:unstable_features true
         :build_on_save false
         :all_features true}}}
   :sumneko_lua
    {:single_file_support true
     :settings
      {:Lua
        {:completion
          {:workspaceWord true
           :callSnippet "Replace"}
         :diagnostics
          {:unusedLocalExclude ["_*"]}
         :format
          {:enabled true
           :defaultConfig
            {:indent_style "space"
             :indent_size (tostring (vim.opt.shiftwidth:get))}
             :contituation_indent_size (tostring (vim.opt.shiftwidth:get))}}
         :runtime
          ;; Tell the language server which version of Lua you're using (most
          ; likely LuaJIT in the case of Neovim)
          {:version "LuaJIT"
           ;; Setup your lua path
           :path ["lua/?.lua" "lua/?/init.lua"]}
         :telemetry {:enable false}
         :workspace
          {:checkThirdParty false ;; Disable prompt to generate a .luarc.json file
           :library (nvim.get_runtime_file "" true)}}} ;; Make the server aware of Neovim runtime files
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
