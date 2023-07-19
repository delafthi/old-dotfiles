(module plugins.persistence
  {autoload {: persistence
             : util}})

(defn init []
  "Initialize nvim for persistence.nvim"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Restore last workspace"
      ["n"] ["<Leader>" "p" "r"]
      (fn [] (persistence.load {:last true})) opts)
    (util.set-keymap "Load workspace"
      ["n"] ["<Leader>" "p" "l"] (fn [] (persistence.load)) opts)))

(defn config []
  "Configure persistence.nvim"
  ;; Call the setup function
  (persistence.setup
    {:dir (vim.fn.expand (.. (vim.fn.stdpath "data") "/sessions/"))
     :options ["buffers" "curdir" "tabpages" "winsize"]}))
