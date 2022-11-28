(module plugins.lsp.diagnostics)

(def- signs
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

  ;; Set the signs for different diagnostic levels
  (each [type icon (pairs signs)]
    (let [hl (.. "DiagnosticSign" type)]
      (vim.fn.sign_define hl
        {:numhl ""
         :text icon
         :texthl hl}))))
