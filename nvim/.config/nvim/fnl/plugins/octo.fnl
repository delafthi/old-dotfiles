(module plugins.octo
  {autoload {nordic-palette nordic.palette
             : octo
             : util}})

(defn setup []
  "Setup nvim for octo.nvim"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Find issue"
      ["n"] ["<Leader>" "g" "i"] "<Cmd>Octo issue list<Cr>" opts)
    (util.set-keymap "Find PR"
      ["n"] ["<Leader>" "g" "P"] "<Cmd>Octo pr list<Cr>" opts)
    (util.set-keymap "Create new issue"
      ["n"] ["<Leader>" "c" "i"] "<Cmd>Octo issue create<Cr>" opts)))

(defn config []
  "Configure octo.nvim"
  ;; Call the setup function
  (let [c nordic-palette]
    (octo.setup
      {:colors
        {:white c.dark_white
        :grey c.gray
        :black c.dark_black
        :red c.red
        :dark_red c.red
        :green c.green
        :dark_green c.green
        :yellow c.yellow
        :dark_yellow c.yellow
        :blue c.blue
        :dark_blue c.intense_blue
        :purple c.purple}
      :mappings
        {:issue
          {:close_issue {:desc "close issue" :lhs "<LocalLeader>ic"}
           :reopen_issue {:desc "reopen issue" :lhs "<LocalLeader>io"}
           :list_issues {:desc "list open issues on same repo"
                         :lhs "<LocalLeader>il"}
           :reload {:desc "reload issue" :lhs "<LocalLeader>u"}
           :open_in_browser {:desc "open issue in browser"
                             :lhs "<LocalLeader>b"}
           :copy_url {:desc "copy url to system clipboard"
                      :lhs "<LocalLeader>y"}
           :add_assignee {:desc "add assignee" :lhs "<LocalLeader>aa"}
           :remove_assignee {:desc "remove assignee" :lhs "<LocalLeader>ad"}
           :create_label {:desc "create label" :lhs "<LocalLeader>lc"}
           :add_label {:desc "add label" :lhs "<LocalLeader>la"}
           :remove_label {:desc "remove label" :lhs "<LocalLeader>ld"}
           :goto_issue {:desc "navigate to a local repo issue"
                        :lhs "<LocalLeader>gi"}
           :add_comment {:desc "add comment" :lhs "<LocalLeader>ca"}
           :delete_comment {:desc "delete comment" :lhs "<LocalLeader>cd"}
           :next_comment {:desc "go to next comment" :lhs "<LocalLeader>n"}
           :prev_comment {:desc "go to previous comment" :lhs "<LocalLeader>p"}
           :react_hooray {:desc "add/remove 🎉 reaction" :lhs "<LocalLeader>ro"}
           :react_heart {:desc "add/remove ❤️ reaction" :lhs "<LocalLeader>rh"}
           :react_eyes {:desc "add/remove 👀 reaction" :lhs "<LocalLeader>re"}
           :react_thumbs_up {:desc "add/remove 👍 reaction"
                             :lhs "<LocalLeader>rp"}
           :react_thumbs_down {:desc "add/remove 👎 reaction"
                               :lhs "<LocalLeader>rd"}
           :react_rocket {:desc "add/remove 🚀 reaction" :lhs "<LocalLeader>rr"}
           :react_laugh {:desc "add/remove 😄 reaction" :lhs "<LocalLeader>rl"}
           :react_confused {:desc "add/remove 😕 reaction"
                            :lhs "<LocalLeader>rc"}}
         :pull_request
          {:checkout_pr {:desc "checkout PR" :lhs "<LocalLeader>po"}
           :merge_pr {:desc "merge commit PR" :lhs "<LocalLeader>pm"}
           :squash_and_merge_pr {:desc "squash and merge PR"
                                 :lhs "<LocalLeader>psm"}
           :list_commits {:desc "list PR commits" :lhs "<LocalLeader>pc"}
           :list_changed_files {:desc "list PR changed files"
                                :lhs "<LocalLeader>pf"}
           :show_pr_diff {:desc "show PR diff" :lhs "<LocalLeader>pd"}
           :add_reviewer {:desc "add reviewer" :lhs "<LocalLeader>va"}
           :remove_reviewer {:desc "remove reviewer request"
                             :lhs "<LocalLeader>vd"}
           :close_issue {:desc "close PR" :lhs "<LocalLeader>ic"}
           :reopen_issue {:desc "reopen PR" :lhs "<LocalLeader>io"}
           :list_issues {:desc "list open issues on same repo"
                         :lhs "<LocalLeader>il"}
           :reload {:desc "reload PR" :lhs "<LocalLeader>u"}
           :open_in_browser {:desc "open PR in browser" :lhs "<LocalLeader>y"}
           :copy_url {:desc "copy url to system clipboard" :lhs "<LocalLeader>y"}
           :add_assignee {:desc "add assignee" :lhs "<LocalLeader>aa"}
           :remove_assignee {:desc "remove assignee" :lhs "<LocalLeader>ad"}
           :create_label {:desc "create label" :lhs "<LocalLeader>lc"}
           :add_label {:desc "add label" :lhs "<LocalLeader>la"}
           :remove_label {:desc "remove label" :lhs "<LocalLeader>ld"}
           :goto_issue {:desc "navigate to a local repo issue"
                        :lhs "<LocalLeader>gi"}
           :add_comment {:desc "add comment" :lhs "<LocalLeader>ca"}
           :delete_comment {:desc "delete comment" :lhs "<LocalLeader>cd"}
           :next_comment {:desc "go to next comment" :lhs "]c"}
           :prev_comment {:desc "go to previous comment" :lhs "[c"}
           :react_hooray {:desc "add/remove 🎉 reaction" :lhs "<LocalLeader>rp"}
           :react_heart {:desc "add/remove ❤️ reaction" :lhs "<LocalLeader>rh"}
           :react_eyes {:desc "add/remove 👀 reaction" :lhs "<LocalLeader>re"}
           :react_thumbs_up {:desc "add/remove 👍 reaction"
                             :lhs "<LocalLeader>ru"}
           :react_thumbs_down {:desc "add/remove 👎 reaction"
                               :lhs "<LocalLeader>rd"}
           :react_rocket {:desc "add/remove 🚀 reaction" :lhs "<LocalLeader>rr"}
           :react_laugh {:desc "add/remove 😄 reaction" :lhs "<LocalLeader>rl"}
           :react_confused {:desc "add/remove 😕 reaction"
                            :lhs "<LocalLeader>rc"}}
         :review_thread
          {:goto_issue {:desc "navigate to a local repo issue"
                        :lhs "<LocalLeader>gi"}
           :add_comment {:desc "add comment" :lhs "<LocalLeader>ca"}
           :add_suggestion {:desc "add suggestion" :lhs "<LocalLeader>sa"}
           :delete_comment {:desc "delete comment" :lhs "<LocalLeader>cd"}
           :next_comment {:desc "go to next comment" :lhs "]c"}
           :prev_comment {:desc "go to previous comment" :lhs "[c"}
           :select_next_entry {:desc "move to previous changed file" :lhs "]q"}
           :select_prev_entry {:desc "move to next changed file" :lhs "[q"}
           :close_review_tab {:desc "close review tab" :lhs "<LocalLeader>"}
           :react_hooray {:desc "add/remove 🎉 reaction" :lhs "<LocalLeader>rp"}
           :react_heart {:desc "add/remove ❤️ reaction" :lhs "<LocalLeader>rh"}
           :react_eyes {:desc "add/remove 👀 reaction" :lhs "<LocalLeader>re"}
           :react_thumbs_up {:desc "add/remove 👍 reaction"
                             :lhs "<LocalLeader>r+"}
           :react_thumbs_down {:desc "add/remove 👎 reaction"
                               :lhs "<LocalLeader>r-"}
           :react_rocket {:desc "add/remove 🚀 reaction" :lhs "<LocalLeader>rr"}
           :react_laugh {:desc "add/remove 😄 reaction" :lhs "<LocalLeader>rl"}
           :react_confused {:desc "add/remove 😕 reaction"
                            :lhs "<LocalLeader>rc"}}
         :submit_win
          {:approve_review {:desc "approve review" :lhs "<LocalLeader>a"}
           :comment_review {:desc "comment review" :lhs "<LocalLeader>c"}
           :request_changes {:desc "request changes review"
                             :lhs "<LocalLeader>r"}
           :close_review_tab {:desc "close review tab" :lhs "q"}}
         :review_diff
          {:add_review_comment {:desc "add a new review comment"
                                :lhs "<LocalLeader>ca"}
           :add_review_suggestion
            {:desc "add a new review suggestion"
             :lhs "<LocalLeader>sa"}
           :focus_files {:desc "move focus to changed file panel"
                         :lhs "<LocalLeader>e"}
           :toggle_files {:desc "hide/show changed files panel"
                          :lhs "<LocalLeader>t"}
           :next_thread {:desc "move to next thread" :lhs "]t"}
           :prev_thread {:desc "move to previous thread" :lhs "[t"}
           :select_next_entry {:desc "move to previous changed file" :lhs "]q"}
           :select_prev_entry {:desc "move to next changed file" :lhs "[q"}
           :close_review_tab {:desc "close review tab" :lhs "q"}
           :toggle_viewed {:desc "toggle viewer viewed state" :lhs "<Tab>"}}
         :file_panel
          {:next_entry {:desc "move to next changed file" :lhs "j"}
           :prev_entry {:desc "move to previous changed file" :lhs "k"}
           :select_entry {:desc "show selected changed file diffs" :lhs "<Cr>"}
           :refresh_files {:desc "refresh changed files panel"
                           :lhs "<LocalLeader>u"}
           :focus_files {:desc "move focus to changed file panel"
                         :lhs "<LocalLeader>e"}
           :toggle_files {:desc "hide/show changed files panel"
                          :lhs "<LocalLeader>t"}
           :select_next_entry {:desc "move to previous changed file" :lhs "]q"}
           :select_prev_entry {:desc "move to next changed file" :lhs "[q"}
           :klose_review_tab {:desc "close review tab" :lhs "q"}
           :toggle_viewed {:desc "toggle viewer viewed state"
                           :lhs "<Tab>"}}}})))
