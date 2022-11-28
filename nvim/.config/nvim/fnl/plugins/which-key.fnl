(module plugins.which-key
  {autoload {: which-key}})

(defn config []
  "Cofigure which-key.nvim"
  ;; Call the setup function
  (which-key.setup
    {:key_labels {:<Leader> "<Space>"}
     :hidden ["<Silent>"
              "<Cmd>"
              "<CR>"
              "<Cr>"
              "call"
              "lua"
              "^:"
              "^ "]
     :triggers_blacklist
      {:n ["h" "j" "k" "l" "o" "O" "x"]
       :i ["h" "j" "k" "l" ":"]}}))
