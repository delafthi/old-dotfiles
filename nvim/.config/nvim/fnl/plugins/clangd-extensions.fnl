(module plugins.clangd-extensions
  {autoload {clangd-extensions clangd_extensions
             lsp-options plugins.lsp.options}})

(def- kind-icons
  {:Compound ""
   :Recovery ""
   :TranslationUnit ""
   :PackExpansion ""
   :TemplateTypeParm ""
   :TemplateTemplateParm ""
   :TemplateParamObject ""})

(def- role-icons
  {:type "ﴯ"
   :declaration ""
   :expression ""
   :specifier ""
   :statement ""
   "template argument" ""})

(defn config []
  "Configure clangd_extensions.nvim"
  ;; Call the setup function
  (clangd-extensions.setup
    {:server
      {:capabilities lsp-options.capabilities
       :on_attach lsp-options.on-attach
       :cmd ["clangd"
             "--all-scopes-completion"
             "--background-index"
             "--clang-tidy"
             "--cross-file-rename"
             "--header-insertion=iwyu"
             "--header-insertion-decorators"]}
     :extensions
      {:ast
        {:kind_icons kind-icons
         :role_icons role-icons}}}))
