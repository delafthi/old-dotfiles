(module plugins.bufferline
  {autoload {: bufferline
             : util}})

(defn setup []
  "Setup nvim for bufferline.nvim"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Next tab"
      ["n" "i" "t"] ["<C-t>" "n"] "<C-\\><C-n><Cmd>BufferLineCycleNext<Cr>"
      opts)
    (util.set-keymap "Previous tab"
      ["n" "i" "t"] ["<C-t>" "p"] "<C-\\><C-n><Cmd>BufferLineCyclePrev<Cr>"
      opts)))

(defn config []
  "Configure bufferline.nvim"
  ;; Call the setup function
  (bufferline.setup
    {:options
      {:mode "tabs"
       :modified_icon ""
       :left_trunc_marker ""
       :right_trunc_marker ""
       :diagnostics "nvim_lsp"
       :diagnostics_indicator
        (fn [_ _ diag]
          (let [s {}]
            (each [_ serevrity (ipairs severities)]
              (when (. diag severity)
                (table.insert s (.. (. signs severity) (. diag severity)))))
            (table.concat s " ")))
       :show_buffer_close_icons false
       :show_close_icon false
       :separator_style "thin"
       :always_show_bufferline false
       :sort_by "id"}}))
