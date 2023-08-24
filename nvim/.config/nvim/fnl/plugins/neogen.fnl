(module plugins.neogen
  {autoload {: neogen
             : util}})

(defn init []
  "Initialize nvim for up neogen"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Generate documentation comment"
      ["n"] ["<LocalLeader>" "d" "d"] (fn [] (neogen.generate)) opts)))

(defn config []
  "Configure neogen"
  ;; Call the setup function
  (neogen.setup
    {:enabled true
     :input_after_comment true
     :snippet_engine "luasnip"}))
