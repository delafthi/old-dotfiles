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


(def- lsp-servers
  {:bashls {}
   :cmake {}
   :dockerls {}
   :ltex
    {:settings
      {:ltex
        {:disabledRules
          {:en-US ["ARROWS" "EllIPSIS"]
           :de-CH ["ARROWS" "EllIPSIS"]}
         :additionalRules
          {:enablePickyRules true
           :motherTongue "de-CH"
           :languageModel "~/.local/share/language-tool/ngrams/"}}}}
   :pylsp
   {:settings
    {:pylsp
     {:plugins
      {:black {:enabled true}
       :ruff
       {:enabled true
        :exclude ["conjure-log-*.py"]
        :extendSelect ["I"]}}}}}
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
   :verible {}
   :vhdl_ls {}
   :vimls {}})

(defn config []
  "Configure nvim-lspconfig"
  ;; Call neodev's setup function
  (neodev.setup {})

  ;; Setup diagnostics
  (lsp-diagnostics.setup)

  ;; Call the setup functions for language servers
  (each [ls opts (pairs lsp-servers)]
    (setup-lsp ls opts)))
