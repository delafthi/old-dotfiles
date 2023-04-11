(module plugins.luasnip
  {autoload {: luasnip
             ls-extras luasnip.extras
             ls-extras-fmt luasnip.extras.fmt
             ls-from-vscode luasnip.loaders.from_vscode
             ls-util-types luasnip.util.types
             : util}})

(defn- my-snippets []
  "Define my snippets"
  (let [snip luasnip.snippet
        i luasnip.insert_node
        fmt ls-extras-fmt.fmt]
    {:markdown
      [(snip {:name "Markdown header"
              :docstring "Insert the markdown document header"
              :trig "---"}
              (fmt (.. "---\n"
                       "title: {}\n"
                       "author: {}\n"
                       "date: {}\n"
                       "output: {}\n"
                       "---\n"
                       "{}")
                   (let [modified-buffer-name
                         (vim.fn.fnamemodify (vim.fn.bufname) ":t:r")]
                    [(i 1 modified-buffer-name)
                     (i 2 "Thierry Delafontaine")
                     (i 3 (vim.fn.strftime "%d.%m.%Y"))
                     (i 4 (.. modified-buffer-name "pdf_document"))
                     (i 0)])))]}))

(defn init []
  "Initialize nvim for LuaSnip"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Switch to next choices"
      ["i"] ["<C-.>"] (fn []
                        (when (luasnip.choice_active)
                              (luasnip.change_choice 1))) opts)
    (util.set-keymap "Switch to previous choices"
      ["i"] ["<C-,>"] (fn []
                        (when (luasnip.choice_active)
                              (luasnip.change_choice -1))) opts)))

(defn config []
  "Configure LuaSnip"
  ;; Call the setup function
  (luasnip.config.setup
    {:history true
     :updateevents "TextChanged,TextChangedI"
     :region_check_events "CursorHold,InsertLeave"
     :delete_check_events "TextChanged,InsertEnter"
     :enable_autosnippets true
     :ext_opts
      {ls-util-types.choiceNode
        {:active
          {:virt_text [[" " "TSWarning"]]}}
       ls-util-types.insertNode
        {:active
          {:virt_text [["" "TSNote"]]}}}})

  ;; Load external snippets
  (ls-from-vscode.lazy_load)

  ;; Load custom snippets
  (each [ft snippets (pairs (my-snippets))]
    (luasnip.add_snippets ft snippets)))
