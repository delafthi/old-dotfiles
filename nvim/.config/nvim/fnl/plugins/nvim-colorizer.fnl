(module plugins.nvim-colorizer
  {autoload {: colorizer
             : util}})

(defn config []
  "Configure nvim-colorizer.lua"
  ;; Call the setup function
  (colorizer.setup
    ["*" "!packer" "!alpha" "!help" "!terminal" "!neogit"]))
