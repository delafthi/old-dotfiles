(module plugins.lsp.options
  {autoload {lsp-cmp cmp_nvim_lsp
             lsp-formatting plugins.lsp.formatting
             lsp-keymaps plugins.lsp.keymaps
             nvim aniseed.nvim}})

(defn on-attach [client bufnr]
  "Callback when the language server is attached to the buffer"
  (lsp-formatting.setup client bufnr)
  (lsp-keymaps.setup client bufnr)
  ;; Reference highlighting given the server has the capability
  (when client.server_capabilities.documentHighlightProvider
    (let [group (nvim.create_augroup "LspDocumentHighlight" {})]
      (nvim.create_autocmd "CursorHold"
        {:pattern "<buffer>" :callback (fn [] (vim.lsp.buf.document_highlight))
         :group group})
      (nvim.create_autocmd "CursorMoved"
        {:pattern "<buffer>"
         :callback (fn [] (vim.lsp.buf.clear_references))
         :group group}))))

(def capabilities (lsp-cmp.default_capabilities))
