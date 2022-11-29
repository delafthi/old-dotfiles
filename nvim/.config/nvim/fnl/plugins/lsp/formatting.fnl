(module plugins.lsp.formatting
  {autoload {nvim aniseed.nvim
             null-ls plugins.lsp.null-ls
             : util}})

;; Disable autoformatting by default
(def- state {:autoformat? false})

(defn toggle []
  "Toggle autoformatting"
  (tset state :autoformat? (not (. state :autoformat?)))
  (if (. state :autoformat?)
      (util.info "Autoformatting enabled" "Formatting")
      (util.warn "Autoformatting disabled" "Formatting")))


(defn autoformat []
  "Autoformat a buffer"
  (when (. state :autoformat?)
    (if vim.lsp.buf.format
      (vim.lsp.buf.format)
      (vim.lsp.buf.formatting_sync))))

(defn setup [client bufnr]
  "Setup nvim formatting configuration"
  (let [ft (nvim.buf_get_option bufnr "filetype")
        null-ls? (= client.name "null-ls")]
    (set client.server_capabilities.documentFormattingProvider
      (if (null-ls.has-formatter ft)
          null-ls?
          (not null-ls?))))

  (when client.server_capabilities.documentFormattingProvider
    ;; Create the autocommand to format the buffer on save
    (nvim.create_autocmd "BufWritePre"
      {:pattern "<buffer>"
       :callback (fn [] (autoformat))
       :group (nvim.create_augroup "LspFormat" {})})))
