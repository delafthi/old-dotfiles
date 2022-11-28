(module plugins.neogit
  {autoload {: neogit
             : util}})

(defn setup []
  "Setup nvim for neogit"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Open neogit"
      ["n"] ["<Leader>" "g" "g"]
      (fn [] (neogit.open {:kind  "vsplit"})) opts)))

(defn config []
  "Configure neogit"
  ;; Call the setup function
  (neogit.setup
    {:disable_commit_confirmation true
     :integrations {:diffview true}
     :mappings
      {:status
        {:q "Close"
         :1 "Depth1"
         :2 "Depth2"
         :3 "Depth3"
         :4 "Depth4"
         :<Tab> "Toggle"
         :x "Discard"
         :s "Stage"
         :S "StageUnstaged"
         :<C-s> "StageAll"
         :u "Unstage"
         :U "UnstageStaged"
         :d "DiffAtFile"
         :$ "CommandHistory"
         :<C-r> "RefreshBuffer"
         :<Enter> "GoToFile"
         :<C-v> "VSplitOpen"
         :<C-x> "SplitOpen"
         :<C-t> "TabOpen"
         :? "HelpPopup"
         :D "DiffPopup"
         :p "PullPopup"
         :r "RebasePopup"
         :P "PushPopup"
         :c "CommitPopup"
         :L "LogPopup"
         :Z "StashPopup"
         :b "BranchPopup"}}}))
