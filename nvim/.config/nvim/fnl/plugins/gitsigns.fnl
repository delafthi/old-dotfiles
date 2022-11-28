(module plugins.gitsigns
  {autoload {: gitsigns}})

(defn config []
  "Configure gitsigns.nvim"
  ;; Call the setup function
  (gitsigns.setup {}))
