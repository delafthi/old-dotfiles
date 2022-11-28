(module plugins.venn
  {autoload {a aniseed.core
             : util}})

(defn setup []
  "Setup nvim for venn.nvim"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Workspace Trouble"
      ["n"] ["<LocalLeader>" "v"]
      (fn []
        (let [venn (vim.inspect vim.b.venn_enabled)]
          (if (a.nil? venn)
              (do
                (set vim.b.venn_enabled true)
                (set vim.opt.virtualedit true)
                (let [opts {:silent true
                            :buffer true}]
                  (vim.keymap.set "n" "H" "<C-v>h<Cmd>VBox<Cr>" opts)
                  (vim.keymap.set "n" "J" "<C-v>j<Cmd>VBox<Cr>" opts)
                  (vim.keymap.set "n" "K" "<C-v>k<Cmd>VBox<Cr>" opts)
                  (vim.keymap.set "n" "L" "<C-v>l<Cmd>VBox<Cr>" opts)
                  (vim.keymap.set "v" "f" "<Cmd>VBox<Cr>" opts)))
              (do
                (set vim.opt.virtualedit false)
                (nvim.command "mapclear <buffer>")
                (set vim.b.venn_enabled nil))))))))
