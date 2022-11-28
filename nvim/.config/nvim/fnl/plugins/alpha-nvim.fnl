(module plugins.alpha-nvim
  {autoload {: alpha
             a aniseed.core
             nvim aniseed.nvim}})


(def- leader "SPC")

(defn- entry [sc txt keybind keybind-opts opts]
  "Set up an entry containing a text and an according keybinding"
  (let [sc-sub (string.gsub (string.gsub sc "%s" "") leader "<Leader>")]
    (tset opts :position (or opts.position "center"))
    (tset opts :shortcut (or opts.shortcut sc))
    (tset opts :cursor (or opts.cursor 5))
    (tset opts :width (or opts.width 50))
    (tset opts :align_shortcut (or opts.align_shortcut "right"))
    (tset opts :hl_shortcut (or opts.hl_shortcut "Keyword"))

    (when keybind
      (tset keybind-opts :noremap (or keybind-opts.noremap true))
      (tset keybind-opts :silent (or keybind-opts.silent true))
      (tset keybind-opts :nowait (or keybind-opts.nowait true))
      (tset opts :keymap ["n"
                          sc-sub
                          keybind
                          keybind-opts]))

    (fn on_press []
      (let [key (nvim.replace_termcodes
                  (or keybind (.. sc-sub "<Ignore>")) true false true)]
        (nvim.feedkeys key "tx" false)))

    {:type "button"
     :val txt
     :on_press on_press
     :opts opts}))

(def- header
  [{:type "padding"
    :val 2}
   {:type "text"
    :val ["                                                     "
          "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ "
          "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ "
          "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ "
          "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ "
          "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ "
          "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ "
          "                                                     "]
    :opts {:position "center"
          :hl "DashboardHeader"}}
   {:type "padding"
    :val 2}])

(def- main
  [{:type "group"
    :val [(entry "SPC c f"
                 "  > New File"
                 "<Cmd>enew<Cr>"
                 []
                 {:hl_shortcut "DashboardShortCut"})
          (entry "SPC w r"
                 "  > Restore last session"
                 "<Cmd>lua require('persistence').load({last = true})<Cr>"
                 []
                 {:hl_shortcut "DashboardShortCut"})
          (entry "SPC f r"
                 "  > Recently opened files"
                 "<Cmd>Telescope oldfiles<Cr>"
                 []
                 {:hl_shortcut "DashboardShortCut"})
          (entry "SPC f f"
                 "  > Find File"
                 "<Cmd>Telescope find_files<Cr>"
                 []
                 {:hl_shortcut "DashboardShortCut"})
          (entry "SPC f b"
                 "  > Find browser"
                 "<Cmd>Telescope file_browser hidden=true<Cr>"
                 []
                 {:hl_shortcut "DashboardShortCut"})
          (entry "SPC f g"
                 "  > Find grep"
                 "<Cmd>Telescope live_grep<Cr>"
                 []
                 {:hl_shortcut "DashboardShortCut"})]
    :opts {:spacing 1}}])

(def- footer
  [{:type "text"
    :val ""
    :opts {:position "center"
           :hl "DashboardFooter"}}])

(defn config []
  "Configure alpha-nvim"
  ;; Call the setup function
  (alpha.setup
    {:layout
     (a.concat header
               main
               footer)
     :opts {:margin 5}}))
