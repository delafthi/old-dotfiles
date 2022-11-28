(module plugins.conjure
  {autoload {: conjure}})

(defn setup []
  "Setup nvim for conjure"
  ;; Enable tree-sitter
  (set vim.g.conjure#extract#tree_sitter#enabled true)
  ;Mappings
  (set vim.g.conjure#mapping#doc_word "hd")

  ;; fennel
  (set vim.g.conjure#client#fennel#aniseed#aniseed_module_prefix "aniseed.")
  ;; Guile scheme
  (set vim.g.conjure#filetype#scheme "conjure.client.guile.socket"))
