(module plugins.nordic
  {autoload {: nordic}})

(defn config []
  "Configure nordic.nvim"
  (nordic.colorscheme {:underline_option "undercurl"
                       :alternate_backgrounds true}))
