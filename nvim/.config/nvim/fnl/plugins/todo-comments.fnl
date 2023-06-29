(module plugins.todo-comments
  {autoload {nordic-palette nordic.palette
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
  (let [c nordic-palette]
    ;; Call the setup function
    (todo-comments.setup
      {:corols
        {:error ["DiagnosticError" c.red]
         :warning ["DiagnosticWarning" c.yellow]
         :info ["DiagnosticInfo" c.blue]
         :hint ["DiagnosticHint" c.green]
         :default ["Identifier" c.purple]
         :test ["Identifier" c.orange]}})))
