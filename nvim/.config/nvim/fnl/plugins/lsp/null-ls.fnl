(module plugins.lsp.null-ls
  {autoload {nls-generators null-ls.generators
             lsp-options plugins.lsp.options
             : null-ls
             nls-utils null-ls.utils}})

(defn has-formatter [ft]
  "Check whether the null-ls supports a formatter for `ft`"
  (> (length (nls-generators.get_available ft FORMATTING)) 0))


(defn config []
  "Configure null-ls.nvim"
  ;; Call the setup function
  (null-ls.setup
    {:on_attach lsp-options.on-attach
     :sources
      [;; Code-actions
       null-ls.builtins.code_actions.eslint
       ;; Diagnostics
       null-ls.builtins.diagnostics.checkmake
       (null-ls.builtins.diagnostics.editorconfig_checker.with
         {:args ["-disable-indent-size"
                 "-no-color"
                 "$FILENAME"]})
       null-ls.builtins.diagnostics.eslint
       null-ls.builtins.diagnostics.fish
       null-ls.builtins.diagnostics.selene
       ;; Formatters
       null-ls.builtins.formatting.black
       null-ls.builtins.formatting.cbfmt
       null-ls.builtins.formatting.deno_fmt
       null-ls.builtins.formatting.fish_indent
       null-ls.builtins.formatting.fnlfmt
       null-ls.builtins.formatting.isort
       null-ls.builtins.formatting.prettier
       null-ls.builtins.formatting.shfmt
       null-ls.builtins.formatting.stylua
       null-ls.builtins.formatting.emacs_scheme_mode
       (null-ls.builtins.formatting.emacs_vhdl_mode.with
         {:args
           (fn [params]
             ["--batch"
              "--eval"
              (string.format
                "(let (vhdl-file-content next-line) (while (setq next-line (ignore-errors (read-from-minibuffer \"\"))) (setq vhdl-file-content (concat vhdl-file-content next-line \"\n\"))) (with-temp-buffer (vhdl-mode) (vhdl-set-style \"IEEE\") (vhdl-set-offset 'arglist-close 0) (setq vhdl-basic-offset %d) (insert vhdl-file-content) (vhdl-beautify-region (point-min) (point-max)) (princ (buffer-string))))"
                 (. (. vim.bo params.bufnr) :shiftwidth))])})]}))
