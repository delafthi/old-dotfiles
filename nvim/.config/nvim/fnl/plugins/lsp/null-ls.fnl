(module plugins.lsp.null-ls
  {autoload {lsp-options plugins.lsp.options
             : null-ls
             sources null-ls.sources}})

(defn has-formatter [ft]
  "Check whether the null-ls supports a formatter for `ft`"
  (> (length (sources.get_available ft "NULL_LS_FORMATTING")) 0))


(defn config []
  "Configure null-ls.nvim"
  ;; Call the setup function
  (null-ls.setup
    {:sources
      [;; Diagnostics
       null-ls.builtins.diagnostics.checkmake
       null-ls.builtins.diagnostics.commitlint
       null-ls.builtins.diagnostics.editorconfig_checker
       null-ls.builtins.diagnostics.fish
       ;; Formatters
       null-ls.builtins.formatting.deno_fmt
       null-ls.builtins.formatting.fish_indent
       null-ls.builtins.formatting.fnlfmt
       null-ls.builtins.formatting.isort
       null-ls.builtins.formatting.prettier
       null-ls.builtins.formatting.shfmt
       null-ls.builtins.formatting.stylua]
     :on_attach lsp-options.on-attach}))