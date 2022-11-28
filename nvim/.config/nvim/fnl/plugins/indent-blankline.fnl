(module plugins.indent-blankline
  {autoload {indent-blankline indent_blankline}})

(defn config []
  "Configure indent-blankline.nvim"
  ;; Call the setup function
  (indent-blankline.setup
    {:char "│"
     :use_treesitter true
     :filetype_exclude ["alpha"
                        "help"
                        "man"
                        "markdown"
                        "rmd"
                        "norg"
                        "packer"]
     :buftype_exclude ["terminal"]}))
