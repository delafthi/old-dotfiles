(module plugins.nvim-autopairs
  {autoload {a aniseed.core
             autopairs nvim-autopairs
             ft config.filetypes}})

(defn config []
  "Configure nvim-autopairs"
  ;; Call the setup function
  (autopairs.setup {:check_ts true})

  ;; Add custom rules
  (a.assoc-in (autopairs.get_rule "'") [1 :not_filetypes] ft.lisps)
  (a.assoc-in (autopairs.get_rule "`") [1 :not_filetypes] ft.lisps))
