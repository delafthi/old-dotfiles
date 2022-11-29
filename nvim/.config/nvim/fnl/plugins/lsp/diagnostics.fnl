(module plugins.lsp.diagnostics)

(def signs
  {:Error " "
   :Warn " "
   :Hint " "
   :Info " "})

(defn setup []
  "Setup nvim diagnostics configuration"
  ;; Customize how diagnostics are displayed
  (vim.diagnostic.config
    {:signs true
     :underline true
     :update_in_insert false
     :virtual_text {:prefix ""}})

  ;; Add a handler for workspace/diagnostic/refresh
  (tset vim.lsp.handlers :workspace/diagnostic/refresh
    (fn [_ _ ctx]
      (let [ns (vim.lsp.diagnostic.get_namespace ctx.client_id)]
        (pcall vim.diagnostic.reset ns)
        true)))

  ;; Set the signs for different diagnostic levels
  (each [type icon (pairs signs)]
    (let [hl (.. "DiagnosticSign" type)]
      (vim.fn.sign_define hl
        {:numhl ""
         :text icon
         :texthl hl}))))
