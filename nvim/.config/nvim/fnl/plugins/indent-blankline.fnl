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
                        "lazy"
                        "man"
                        "markdown"
                        "rmd"
                        "norg"]
     :buftype_exclude ["terminal"]}))
