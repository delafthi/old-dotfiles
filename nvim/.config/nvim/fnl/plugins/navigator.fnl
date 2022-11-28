(module plugins.navigator
  {autoload {navigator Navigator
             : util}})

(defn setup []
  "Setup nvim for Navigator.nvim"
 ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Move to left window"
      ["n" "i" "v" "t"] ["<C-h>"] (fn [] (navigator.left)) opts)
    (util.set-keymap "Move to lower window"
      ["n" "i" "v" "t"] ["<C-j>"] (fn [] (navigator.down)) opts)
    (util.set-keymap "Move to upper window"
      ["n" "i" "v" "t"] ["<C-k>"] (fn [] (navigator.up)) opts)
    (util.set-keymap "Move to right window"
      ["n" "i" "v" "t"] ["<C-l>"] (fn [] (navigator.right)) opts)))

(defn config []
  "Configure Navigator.nvim"
  ;; Call the setup function
  (navigator.setup {}))
