(module plugins.toggleterm
  {autoload {nvim aniseed.nvim
             : toggleterm
             tt-terminal toggleterm.terminal
             : util}})

(defn init []
  "Initialize nvim for toggleterm.nvim"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Toggle floating terminal"
      ["n"] ["<Leader>" "t" "f"]
      (fn []
        (let [terminal tt-terminal.Terminal]
          (local float-term
            (terminal:new
              {:direction "float"
               :float_opts {:border "single"}
               :hidden true}))
          (float-term:toggle))) opts)
    (util.set-keymap "Toggle horizontal terminal"
      ["n"] ["<Leader>" "t" "x"]
      (fn []
        (let [terminal tt-terminal.Terminal]
          (local term
            (terminal:new
              {:direction "horizontal"
               :hidden true}))
          (term:toggle))) opts)
    (util.set-keymap "Toggle terminal"
      ["n"] ["<Leader>" "t" "t"] (fn [] (toggleterm.toggle 1)) opts)
    (util.set-keymap "Toggle tabbed terminal"
      ["n"] ["<Leader>" "t" "T"]
      (fn []
        (let [terminal tt-terminal.Terminal]
          (local tab-term
            (terminal:new
              {:direction "tab"
               :hidden true}))
          (tab-term:toggle))) opts)
    (util.set-keymap "Toggle vertical terminal"
      ["n"] ["<Leader>" "t" "v"]
      (fn []
        (let [terminal tt-terminal.Terminal]
          (local vert-term
            (terminal:new
              {:direction "vertical"
               :hidden true}))
          (vert-term:toggle))) opts))

  ;; Register buffer-specific keymaps
  (let [opts {:silent true
              :buffer true}
        group (nvim.create_augroup "ToggleTermMappings" {})]
    (nvim.create_autocmd "TermEnter"
      {:pattern "term://*toggleterm#*"
       :callback
        (fn []
          (util.set-keymap "Toggle all terminals"
            ["t"] ["<C-x>" "<C-x>"] (fn [] (toggleterm.toggle_all)) opts))
       :group group})))



(defn config []
  "Configure toggleterm.nvim"
  ;; Call the setup function
  (toggleterm.setup
    {:size (fn [term]
             (match term.direction
               "horizontal" 15
               "vertical" (* vim.o.columns 0.3)))
     :open_mapping nil
     :highlights
      {:Normal {:link "NormalAlt"}
       :NormalFloat {:link "NormalAlt"}
       :FloatBorder {:link "Comment"}
       :SignColumn {:link "NormalAlt"}}
     :shade_terminals false}))
