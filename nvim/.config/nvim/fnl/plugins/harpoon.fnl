(module plugins.harpoon
  {autoload {: harpoon
             harpoon-mark harpoon.mark
             harpoon-ui harpoon.ui
             : util}})

(defn setup []
  "Setup nvim for harpoon"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Jump to first marked file"
      ["n" "i"] ["<M-t>"] (fn [] (harpoon-ui.nav_file 1)) opts)
    (util.set-keymap "Jump to second marked file"
      ["n" "i"] ["<M-n>"] (fn [] (harpoon-ui.nav_file 2)) opts)
    (util.set-keymap "Jump to second marked file"
      ["n" "i"] ["<M-s>"] (fn [] (harpoon-ui.nav_file 3)) opts)
    (util.set-keymap "Toggle harpoon quick menu"
      ["n"] ["<Leader>" "w" "h"] (fn [] (harpoon-ui.toggle_quick_menu)) opts)
    (util.set-keymap "Mark file"
      ["n"] ["<Leader>" "w" "m"] (fn [] (harpoon-mark.add_file)) opts)))

(defn config []
  "Configure harpoon"
  ;; Call the setup function
  (harpoon.setup {}))
