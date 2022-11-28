(module plugins.lsp.formatting
  {autoload {nvim aniseed.nvim
             null-ls plugins.lsp.null-ls
             : util}})

;; Disable autoformatting by default
(var autoformat? false)

(defn toggle []
  "Toggle autoformatting"
  (set autoformat? (not autoformat?))
  (if autoformat?
      (util.info "Autoformatting enabled" "Formatting")
      (util.warn "Autoformatting disabled" "Formatting")))


(defn autoformat []
  "Autoformat a buffer"
  (when autoformat?
    (if vim.lsp.buf.format
      (vim.lsp.buf.format)
      (vim.lsp.buf.formatting_sync))))

(defn setup [client buf]
  "Setup nvim formatting configuration"
  (let [ft (nvim.buf_get_option buf "filetype")
        null-ls? (= client.name "null-ls")]
    (set client.server_capabilities.documentFormattingProvider
      (if (null-ls.has-formatter ft)
          null-ls?
          (not null-ls?))))

  ;; Create the autocommand to format the buffer on save
  (nvim.create_autocmd "BufWritePre"
    {:pattern "<buffer>"
     :callback (fn [] (autoformat))
     :group (nvim.create_augroup "LspFormat" {})}))
