(module plugins.lsp.rust-tools
  {autoload {lsp-options plugins.lsp.options
             : rust-tools}})

(defn config []
  "Configure rust-tools"
  (rust-tools.setup
    {:server
      {:on_attach lsp-options.on-attach}}))
