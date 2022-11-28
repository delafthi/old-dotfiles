(module plugins.lsp.options
  {autoload {formatting plugins.lsp.formatting
             lsp-cmp cmp_nvim_lsp
             lsp-formatting plugins.lsp.formatting
             lsp-mappings plugins.lsp.mappings
             nvim aniseed.nvim}})

(defn on-attach [client buffer]
  "Callback when the language server is attached to the buffer"
  (lsp-formatting.setup client buffer)
  (lsp-mappings.register client buffer)
  ;; Reference highlighting given the server has the capability
  (when client.server_capabilities.documentHighlightProvider
    (let [group (nvim.create_augroup "LspDocumentHighlight" {})]
      (nvim.create_autocmd "CursorHold"
        {:pattern "<buffer>"
          :callback (fn [] (vim.lsp.buf.document_highlight))
          :group group})
      (nvim.create_autocmd "CursorMoved"
        {:pattern "<buffer>"
          :callback (fn [] (vim.lsp.buf.clear_references))
          :group group}))))

(def capabilities (lsp-cmp.default_capabilities))
