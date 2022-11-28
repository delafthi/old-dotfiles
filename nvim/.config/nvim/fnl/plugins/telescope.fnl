(module plugins.telescope
  {autoload {nvim aniseed.nvim
             : telescope
             telescope-builtin telescope.builtin
             : util}})

(defn setup []
  "Setup nvim for telescope.nvim"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Find buffer"
      ["n"] ["<Leader>" "f" "b"] (fn [] (telescope-builtin.buffers)) opts)
    (util.set-keymap "Find explore"
      ["n"] ["<Leader>" "f" "e"]
      (fn [] (telescope.extensions.file_browser.file_browser {:hidden true}))
      opts)
    (util.set-keymap "Find file"
      ["n"] ["<Leader>" "f" "f"] (fn [] (telescope-builtin.find_files)) opts)
    (util.set-keymap "Find grep"
      ["n"] ["<Leader>" "f" "g"] (fn [] (telescope-builtin.live_grep)) opts)
    (util.set-keymap "Find mark"
      ["n"] ["<Leader>" "f" "m"] (fn [] (telescope-builtin.marks)) opts)
    (util.set-keymap "Find command in history"
      ["n"] ["<Leader>" "f" "R"] (fn [] (telescope-builtin.command_history)) opts)
    (util.set-keymap "Find git branche"
      ["n"] ["<Leader>" "g" "b"] (fn [] (telescope-builtin.git_branches)) opts)
    (util.set-keymap "Find git commit"
      ["n"] ["<Leader>" "g" "c"] (fn [] (telescope-builtin.git_commits)) opts)
    (util.set-keymap "Find git file"
      ["n"] ["<Leader>" "g" "f"] (fn [] (telescope-builtin.git_files)) opts)
    (util.set-keymap "Git files"
      ["n"] ["<Leader>" "g" "s"] (fn [] (telescope-builtin.git_status)) opts)
    (util.set-keymap "Find autocommand"
      ["n"] ["<Leader>" "h" "a"] (fn [] (telescope-builtin.autocommands)) opts)
    (util.set-keymap "Find command"
      ["n"] ["<Leader>" "h" "c"] (fn [] (telescope-builtin.commands)) opts)
    (util.set-keymap "Find filetype"
      ["n"] ["<Leader>" "h" "f"] (fn [] (telescope-builtin.filetypes)) opts)
    (util.set-keymap "Find help tag"
      ["n"] ["<Leader>" "h" "h"] (fn [] (telescope-builtin.help_tags)) opts)
    (util.set-keymap "Find keymap"
      ["n"] ["<Leader>" "h" "k"] (fn [] (telescope-builtin.keymaps)) opts)
    (util.set-keymap "Find highlight"
      ["n"] ["<Leader>" "h" "l"] (fn [] (telescope-builtin.highlights)) opts)
    (util.set-keymap "Find man page"
      ["n"] ["<Leader>" "h" "m"] (fn [] (telescope-builtin.man_pages)) opts)
    (util.set-keymap "Find vim option"
      ["n"] ["<Leader>" "h" "o"] (fn [] (telescope-builtin.vim_options)) opts)
    (util.set-keymap "Find telescope builtin"
      ["n"] ["<Leader>" "h" "t"] (fn [] (telescope-builtin.builtin)) opts)
    (util.set-keymap "Open project"
      ["n"] ["<Leader>" "w" "p"] (fn [] (telescope.extensions.project.project))
      opts)

    ;; telescope-builtin.lsp_* keybindings set in nvim-lspconfig
    (util.set-keymap "Find in current buffer"
      ["n"] ["<LocalLeader>" "f" "b"]
      (fn [] (telescope-builtin.current_buffer_fuzzy_find)) opts)))

(defn config []
  "Configure telescope.nvim"
  ;; Call the setup function
  (telescope.setup
    {:defaults
      {:vimgrep_arguments ["rg"
                           "--color=never"
                           "--no-heading"
                           "--hidden"
                           "--with-filename"
                           "--line-number"
                           "--column"
                           "--smart-case"
                           "--glob"
                           "!.git/*"
                           "--trim"]
       :prompt_prefix " "
       :selection_caret " "
       :multi_icon "│"
       :sorting_strategy "ascending"
       :layout_strategy "flex"
       :layout_config
         {:height 0.8
         :width 0.8
         :prompt_position "top"
         :preview_cutoff 120
         :horizontal {:mirror false :preview_width 0.6}
         :vertical {:mirror true}}
       :file_ignore_patterns ["%.git" "node_modules" "%.cache"]
       :path_display {:shorten 3}
       :set_env {:COLORTERM "truecolor"}}
     :extensions
      {:file_browser
        {:mappings
          {:i
            {:<C-c> telescope.extensions.file_browser.actions.create}}}
       :project
        {:base_dirs ["~/projects/work" "~/projects/private"]
         :hidden_files true}}
     :pickers
      {:find_files
        {:find_command ["rg"
                        "--files"
                        "--hidden"
                        "--glob"
                        "!.git/*"]}}})

  ;; Load extensions
  (telescope.load_extension "file_browser")
  (telescope.load_extension "fzf")
  (telescope.load_extension "project"))
