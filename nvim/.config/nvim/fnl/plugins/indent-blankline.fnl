(module plugins.indent-blankline
  {autoload {ibl ibl}})

(defn config []
  "Configure indent-blankline.nvim"
  ;; Call the setup function
  (ibl.setup
    {:indent
      {:char "│"}
     :scope
      {:show_start false
       :show_end false}
     :exclude
      {:filetypes ["alpha"
                  "help"
                  "lazy"
                  "man"
                  "markdown"
                  "rmd"
                  "norg"]
       :buftypes ["terminal"]}}))
