(module plugins.todo-comments
  {autoload {nordic-palette nordic.palette
             : todo-comments}})


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
