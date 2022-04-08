local M = {}

function M.config()
  require("octo").setup({
    default_remote = { "upstream", "origin" }, -- order to try remotes
    reaction_viewer_hint_icon = "", -- marker for user reactions
    user_icon = " ", -- user icon
    timeline_marker = "", -- timeline marker
    timeline_indent = "2", -- timeline indentation
    right_bubble_delimiter = "", -- Bubble delimiter
    left_bubble_delimiter = "", -- Bubble delimiter
    github_hostname = "", -- GitHub Enterprise host
    snippet_context_lines = 4, -- number or lines around commented lines
    file_panel = {
      size = 10, -- changed files panel rows
      use_icons = true, -- use web-devicons in file panel
    },
    mappings = {
      issue = {
        close_issue = "<C-c>ic", -- close issue
        reopen_issue = "<C-c>io", -- reopen issue
        list_issues = "<C-c>il", -- list open issues on same repo
        reload = "<C-c>u", -- reload issue
        open_in_browser = "<C-c>b", -- open issue in browser
        copy_url = "<C-c>y", -- copy url to system clipboard
        add_assignee = "<C-c>aa", -- add assignee
        remove_assignee = "<C-c>ad", -- remove assignee
        create_label = "<C-c>lc", -- create label
        add_label = "<C-c>la", -- add label
        remove_label = "<C-c>ld", -- remove label
        goto_issue = "<C-c>gi", -- navigate to a local repo issue
        add_comment = "<C-c>ca", -- add comment
        delete_comment = "<C-c>cd", -- delete comment
        next_comment = "<C-c>n", -- go to next comment
        prev_comment = "<C-c>p", -- go to previous comment
        react_hooray = "<C-c>ro", -- add/remove 🎉 reaction
        react_heart = "<C-c>rh", -- add/remove ❤️ reaction
        react_eyes = "<C-c>re", -- add/remove 👀 reaction
        react_thumbs_up = "<C-c>rp", -- add/remove 👍 reaction
        react_thumbs_down = "<C-c>rd", -- add/remove 👎 reaction
        react_rocket = "<C-c>rr", -- add/remove 🚀 reaction
        react_laugh = "<C-c>rl", -- add/remove 😄 reaction
        react_confused = "<C-c>rc", -- add/remove 😕 reaction
      },
      pull_request = {
        checkout_pr = "<C-c>po", -- checkout PR
        merge_pr = "<C-c>pm", -- merge commit PR
        squash_and_merge_pr = "<C-c>psm", -- squash and merge PR
        list_commits = "<C-c>pc", -- list PR commits
        list_changed_files = "<C-c>pf", -- list PR changed files
        show_pr_diff = "<C-c>pd", -- show PR diff
        add_reviewer = "<C-c>va", -- add reviewer
        remove_reviewer = "<C-c>vd", -- remove reviewer request
        close_issue = "<C-c>ic", -- close PR
        reopen_issue = "<C-c>io", -- reopen PR
        list_issues = "<C-c>il", -- list open issues on same repo
        reload = "<C-c>u", -- reload PR
        open_in_browser = "<C-c>y", -- open PR in browser
        copy_url = "<C-c>y", -- copy url to system clipboard
        add_assignee = "<C-c>aa", -- add assignee
        remove_assignee = "<C-c>ad", -- remove assignee
        create_label = "<C-c>lc", -- create label
        add_label = "<C-c>la", -- add label
        remove_label = "<C-c>ld", -- remove label
        goto_issue = "<C-c>gi", -- navigate to a local repo issue
        add_comment = "<C-c>ca", -- add comment
        delete_comment = "<C-c>cd", -- delete comment
        next_comment = "]c", -- go to next comment
        prev_comment = "[c", -- go to previous comment
        react_hooray = "<C-c>rp", -- add/remove 🎉 reaction
        react_heart = "<C-c>rh", -- add/remove ❤️ reaction
        react_eyes = "<C-c>re", -- add/remove 👀 reaction
        react_thumbs_up = "<C-c>ru", -- add/remove 👍 reaction
        react_thumbs_down = "<C-c>rd", -- add/remove 👎 reaction
        react_rocket = "<C-c>rr", -- add/remove 🚀 reaction
        react_laugh = "<C-c>rl", -- add/remove 😄 reaction
        react_confused = "<C-c>rc", -- add/remove 😕 reaction
      },
      review_thread = {
        goto_issue = "<C-c>gi", -- navigate to a local repo issue
        add_comment = "<C-c>ca", -- add comment
        add_suggestion = "<C-c>sa", -- add suggestion
        delete_comment = "<C-c>cd", -- delete comment
        next_comment = "]c", -- go to next comment
        prev_comment = "[c", -- go to previous comment
        select_next_entry = "]q", -- move to previous changed file
        select_prev_entry = "[q", -- move to next changed file
        close_review_tab = "<C-c>", -- close review tab
        react_hooray = "<C-c>rp", -- add/remove 🎉 reaction
        react_heart = "<C-c>rh", -- add/remove ❤️ reaction
        react_eyes = "<C-c>re", -- add/remove 👀 reaction
        react_thumbs_up = "<C-c>r+", -- add/remove 👍 reaction
        react_thumbs_down = "<C-c>r-", -- add/remove 👎 reaction
        react_rocket = "<C-c>rr", -- add/remove 🚀 reaction
        react_laugh = "<C-c>rl", -- add/remove 😄 reaction
        react_confused = "<C-c>rc", -- add/remove 😕 reaction
      },
      submit_win = {
        approve_review = "<C-c>a", -- approve review
        comment_review = "<C-c>c", -- comment review
        request_changes = "<C-c>r", -- request changes review
        close_review_tab = "q", -- close review tab
      },
      review_diff = {
        add_review_comment = "<C-c>ca", -- add a new review comment
        add_review_suggestion = "<C-c>sa", -- add a new review suggestion
        focus_files = "<C-c>e", -- move focus to changed file panel
        toggle_files = "<C-c>t", -- hide/show changed files panel
        next_thread = "]t", -- move to next thread
        prev_thread = "[t", -- move to previous thread
        select_next_entry = "]q", -- move to previous changed file
        select_prev_entry = "[q", -- move to next changed file
        close_review_tab = "q", -- close review tab
        toggle_viewed = "<Tab>", -- toggle viewer viewed state
      },
      file_panel = {
        next_entry = "j", -- move to next changed file
        prev_entry = "k", -- move to previous changed file
        select_entry = "<Cr>", -- show selected changed file diffs
        refresh_files = "<C-c>u", -- refresh changed files panel
        focus_files = "<C-c>e", -- move focus to changed file panel
        toggle_files = "<C-c>t", -- hide/show changed files panel
        select_next_entry = "]q", -- move to previous changed file
        select_prev_entry = "[q", -- move to next changed file
        close_review_tab = "q", -- close review tab
        toggle_viewed = "<Tab>", -- toggle viewer viewed state
      },
    },
  })
end

return M
