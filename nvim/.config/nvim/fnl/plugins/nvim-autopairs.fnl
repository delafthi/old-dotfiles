(module plugins.nvim-autopairs
  {autoload {autopairs nvim-autopairs
             ft config.filetypes}})

(defn config []
  "Configure nvim-autopairs"
  ;; Call the setup function
  (autopairs.setup {:check_ts true})

  ;; Add custom rules
  (tset (autopairs.get_rule "'") 1 :not_filetypes ft.lisps))
