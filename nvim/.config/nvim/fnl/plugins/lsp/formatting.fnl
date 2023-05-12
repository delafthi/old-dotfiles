(module plugins.lsp.formatting
  {autoload {nvim aniseed.nvim
             null-ls plugins.lsp.null-ls
             : util}})

;; Disable autoformatting by default
(def- state {:autoformat? false})

(def- augroup (nvim.create_augroup "LspFormatting" {}))

(defn toggle []
  "Toggle autoformatting"
  (tset state :autoformat? (not (. state :autoformat?)))
  (if (. state :autoformat?)
      (util.info "Autoformatting enabled" "Formatting")
      (util.warn "Autoformatting disabled" "Formatting")))


(defn autoformat [bufnr]
  "Autoformat a buffer"
  (when (. state :autoformat?)
    (vim.lsp.buf.format {:bufnr bufnr})))

(defn setup [client bufnr]
  "Setup nvim formatting configuration"
  (let [null-ls? (= client.name "null-ls")]
    (set client.server_capabilities.documentFormattingProvider
         (if (null-ls.has-formatter bufnr)
           null-ls?
           (if null-ls?
             false
             client.server_capabilities.documentFormattingProvider))))
  (when client.server_capabilities.documentFormattingProvider
    ;; Create the autocommand to format the buffer on save
    (nvim.clear_autocmds
      {:buffer bufnr
       :group augroup})
    (nvim.create_autocmd "BufWritePre"
      {:buffer bufnr
       :callback (fn [] (autoformat bufnr))
       :group augroup})))
