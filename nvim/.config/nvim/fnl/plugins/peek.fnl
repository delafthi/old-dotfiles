(module plugins.peek
  {autoload {nvim aniseed.nvim
             : peek
             : util}})

(defn peek-toggle []
  "Toggle the preview window"
  (if (peek.is_open)
      (peek.close)
      (peek.open)))

(defn setup []
  "Setup nvim for peek.nvim"
  ;; Create a usercommand to toggle peek
  (nvim.create_user_command "PeekToggle" (fn [] (peek-toggle)) {})

  ;; Register filetype-specific keybindings
  (let [opts {:silent true
              :buffer true}
        group (nvim.create_augroup "PeekBufferMappings" {})]
    (nvim.create_autocmd "BufEnter"
      {:pattern ["*.md" "*.rmd"]
       :callback
        (fn []
          (util.set-keymap "Preview markdown"
            ["n"] ["<LocalLeader>" "e" "m"] "<Cmd>PeekToggle<Cr>" opts))
       :group group})))

(defn config []
  "Configure peek.nvim"
  ;; Call the setup function
  (peek.setup
    {:autoload false
     :throttle_time 5}))
