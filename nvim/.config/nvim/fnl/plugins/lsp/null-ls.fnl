(module plugins.lsp.null-ls
  {autoload {a aniseed.core
             nls-generators null-ls.generators
             nls-methods null-ls.methods
             lsp-options plugins.lsp.options
             : null-ls
             nls-utils null-ls.utils}})

(defn has-formatter [bufnr]
  "Check whether the null-ls supports a formatter for the filetype of `bufnr`"
  (let [ft (vim.api.nvim_buf_get_option bufnr "filetype")]
    (>
      (length (nls-generators.get_available ft nls-methods.internal.FORMATTING))
      0)))


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
       (null-ls.builtins.diagnostics.mypy.with
         {:condition
          (fn [utils]
            (utils.root_has_file ["mypy.ini"
                                  ".mypy.ini"
                                  "pyproject.toml"
                                  "setup.cfg"]))
          :runtime_condition
          (fn [params]
            (a.nil? (string.match params.bufname "conjure%-log%-%d+%.py$")))})
       null-ls.builtins.diagnostics.selene
       ;; Formatters
       null-ls.builtins.formatting.cbfmt
       null-ls.builtins.formatting.deno_fmt
       null-ls.builtins.formatting.fish_indent
       null-ls.builtins.formatting.prettier
       null-ls.builtins.formatting.shfmt
       null-ls.builtins.formatting.stylua
       (null-ls.builtins.formatting.emacs_scheme_mode.with
         {:extra_filetypes ["fennel"]})
       null-ls.builtins.formatting.verible_verilog_format
       (null-ls.builtins.formatting.emacs_vhdl_mode.with
         {:args
           (fn [params]
             ["--batch"
              "--eval"
              (string.format
                "(let (vhdl-file-content next-line) (while (setq next-line (ignore-errors (read-from-minibuffer \"\"))) (setq vhdl-file-content (concat vhdl-file-content next-line \"\n\"))) (with-temp-buffer (vhdl-mode) (vhdl-set-style \"IEEE\") (vhdl-set-offset 'arglist-close 0) (setq vhdl-basic-offset %d) (insert vhdl-file-content) (vhdl-beautify-region (point-min) (point-max)) (princ (buffer-string))))"
                 (. (. vim.bo params.bufnr) :shiftwidth))])})]}))
