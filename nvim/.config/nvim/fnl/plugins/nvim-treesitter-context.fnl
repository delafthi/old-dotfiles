(module plugins.nvim-treesitter-context
  {autoload {ts-context treesitter-context}})

(defn config []
  "Configure treesitter-context"
  ;; Call the setup function
  (ts-context.setup
    {:patters {:default ["class" "function" "method"]}}))
