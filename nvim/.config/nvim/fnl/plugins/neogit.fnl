(module plugins.neogit
  {autoload {: neogit
             : util}})

(defn init []
  "Initialize nvim for neogit"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Open neogit"
      ["n"] ["<Leader>" "g" "g"]
      (fn [] (neogit.open {:kind "replace"})) opts)))

(defn config []
  "Configure neogit"
  ;; Call the setup function
  (neogit.setup
    {:disable_commit_confirmation false
     :disable_insert_on_commit false
     :use_magit_keybindings true
     :integrations
      {:diffview true}}))
