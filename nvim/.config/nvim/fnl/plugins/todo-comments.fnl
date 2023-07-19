(module plugins.todo-comments
  {autoload {onedarkpro-helpers onedarkpro.helpers
             : todo-comments
             : util}})

(defn init []
  "Initialize nvim for todo-comments.nvim"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Todo list"
      ["n"] ["<Leader>" "q" "t"]
      "<Cmd>TodoTrouble<Cr>" opts)
    (util.set-keymap "Find Todo"
      ["n"] ["<Leader>" "f" "t"]
      "<Cmd>TodoTelescope<Cr>" opts)))

(defn config []
  "Configure todo-comments.nvim"
  (let [c (onedarkpro-helpers.get_colors "onedark")]
    ;; Call the setup function
    (todo-comments.setup
      {:colors
        {:error ["DiagnosticError" c.red]
         :warning ["DiagnosticWarning" c.yellow]
         :info ["DiagnosticInfo" c.blue]
         :hint ["DiagnosticHint" c.cyan]
         :default ["Identifier" c.white]
         :test ["Identifier" c.orange]}})))
