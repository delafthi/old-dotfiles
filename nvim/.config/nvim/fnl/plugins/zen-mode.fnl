(module plugins.zen-mode
  {autoload {: util
             : zen-mode}})

(defn setup []
  "Setup nvim for zen-mode.nvim"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Toggle zen mode"
      ["n"] ["<LocalLeader>" "z"] (fn [] (zen-mode.toggle)) opts)))

(defn config []
  "Configure zen-mode.nvim"
  ;; Call the setup function
  (zen-mode.setup
    {:window
      {:backdrop 1
       :options
        {:signcolumn "no"
         :number true
         :relativenumber true
         :cursorline true
         :cursorcolumn false
         :foldcolumn "0"
         :list false}}}))
