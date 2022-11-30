(module plugins.lsp.null-ls
  {autoload {nls-generators null-ls.generators
             nls-helpers null-ls.helpers
             lsp-options plugins.lsp.options
             nls-methods null-ls.methods
             : null-ls
             nls-utils null-ls.utils}})

(def- FORMATTING nls-methods.internal.FORMATTING)

(def- emacs-vhdl-mode-fmt
  (nls-helpers.make_builtin
    {:name "emacs/vhdl-mode"
     :meta
      {:url "https://guest.iis.ee.ethz.ch/~zimmi/emacs/vhdl-mode.html"
       :description "VHDL Mode is an Emacs major mode for editing VHDL code."}
     :method FORMATTING
     :filetypes ["vhdl"]
     :generator_opts
      {:command "emacs"
       :args
        ["--batch"
         "--eval"
         (string.format
           "(let (vhdl-file-content next-line) (while (setq next-line (ignore-errors (read-from-minibuffer \"\"))) (setq vhdl-file-content (concat vhdl-file-content next-line \"\n\"))) (with-temp-buffer (vhdl-mode) (vhdl-set-style \"IEEE\") (vhdl-set-offset 'arglist-close 0) (setq vhdl-basic-offset %d) (insert vhdl-file-content) (vhdl-beautify-region (point-min) (point-max)) (princ (buffer-string))))"
           (vim.opt.shiftwidth:get))]
       :to_stdin true}
     :factory nls-helpers.formatter_factory}))

(def- emacs-scheme-mode-fmt
  (nls-helpers.make_builtin
    {:name "emacs/scheme-mode"
     :meta
      {:url "https://www.gnu.org/savannah-checkouts/gnu/emacs/emacs.html"
       :description "An extensible, customizable, free/libre text editor — and more."}
     :method FORMATTING
     :filetypes ["scheme" "scheme.guile"]
     :generator_opts
      {:command "emacs"
       :args
        ["--batch"
         "--eval"
         (string.format
           "(let (scheme-file-content next-line) (while (setq next-line (ignore-errors (read-from-minibuffer \"\"))) (setq scheme-file-content (concat scheme-file-content next-line \"\n\"))) (with-temp-buffer (scheme-mode) (setq indent-tabs-mode nil) (setq standard-indent %d) (insert scheme-file-content) (indent-region (point-min) (point-max)) (princ (buffer-string))))"
           (vim.opt.shiftwidth:get))]
       :to_stdin true}
     :factory nls-helpers.formatter_factory}))

(defn has-formatter [ft]
  "Check whether the null-ls supports a formatter for `ft`"
  (> (length (nls-generators.get_available ft FORMATTING)) 0))


(defn config []
  "Configure null-ls.nvim"
  ;; Call the setup function
  (null-ls.setup
    {:on_attach lsp-options.on-attach
     :sources
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
       emacs-scheme-mode-fmt
       emacs-vhdl-mode-fmt
       null-ls.builtins.formatting.yapf]}))
