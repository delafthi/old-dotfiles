(module plugins.lsp.null-ls
  {autoload {nls-generators null-ls.generators
             nls-helpers null-ls.helpers
             lsp-options plugins.lsp.options
             nls-methods null-ls.methods
             : null-ls
             nls-utils null-ls.utils}})

(def- FORMATTING nls-methods.internal.FORMATTING)


(defn has-formatter [ft]
  "Check whether the null-ls supports a formatter for `ft`"
  (> (length (nls-generators.get_available ft FORMATTING)) 0))


(defn config []
  "Configure null-ls.nvim"
  ;; Call the setup function
  (null-ls.setup
    {:sources
      [;; Diagnostics
       null-ls.builtins.diagnostics.checkmake
       null-ls.builtins.diagnostics.commitlint
       (null-ls.builtins.diagnostics.editorconfig_checker.with
         {:args ["-disable-indent-size"
                 "-no-color"
                 "$FILENAME"]})
       null-ls.builtins.diagnostics.fish
       ;; Formatters
       null-ls.builtins.formatting.deno_fmt
       null-ls.builtins.formatting.fish_indent
       null-ls.builtins.formatting.fnlfmt
       null-ls.builtins.formatting.isort
       null-ls.builtins.formatting.prettier
       null-ls.builtins.formatting.shfmt
       null-ls.builtins.formatting.stylua
       null-ls.builtins.formatting.yapf]
     :on_attach lsp-options.on-attach}))
