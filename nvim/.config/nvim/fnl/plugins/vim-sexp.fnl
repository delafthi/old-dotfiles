(module plugins.vim-sexp
  {autoload {ft config.filetypes}})

(defn init []
  "Initialize nvim for vim-sexp"
  (set vim.g.sexp_filetypes (table.concat ft.lisps ","))

  ;; Mappings
  (set vim.g.sexp_enable_insert_mode_mappings 0)
  (set vim.g.sexp_mappings
    {:sexp_swap_element_backward "<M-S-h>"
     :sexp_swap_list_forward "<M-S-j>"
     :sexp_swap_list_backward "<M-S-k>"
     :sexp_swap_element_forward "<M-S-l>"
     :sexp_capture_prev_element ""
     :sexp_emit_head_element ""
     :sexp_emit_tail_element ""
     :sexp_capture_next_element ""}))
