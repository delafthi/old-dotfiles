local M = {}

function M.config()
  local c = require("nord.colors")

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
    colors = {
      white = c.nord4,
      grey = c.nord3,
      black = c.nord0,
      red = c.nord11,
      dark_red = c.nord11,
      green = c.nord14,
      dark_green = c.nord14,
      yellow = c.nord13,
      dark_yellow = c.nord13,
      blue = c.nord8,
      dark_blue = c.nord10,
      purple = c.nord15,
    },
    mappings = {
      issue = {
        close_issue = "<C-s>ic", -- close issue
        reopen_issue = "<C-s>io", -- reopen issue
        list_issues = "<C-s>il", -- list open issues on same repo
        reload = "<C-s>u", -- reload issue
        open_in_browser = "<C-s>b", -- open issue in browser
        copy_url = "<C-s>y", -- copy url to system clipboard
        add_assignee = "<C-s>aa", -- add assignee
        remove_assignee = "<C-s>ad", -- remove assignee
        create_label = "<C-s>lc", -- create label
        add_label = "<C-s>la", -- add label
        remove_label = "<C-s>ld", -- remove label
        goto_issue = "<C-s>gi", -- navigate to a local repo issue
        add_comment = "<C-s>ca", -- add comment
        delete_comment = "<C-s>cd", -- delete comment
        next_comment = "<C-s>n", -- go to next comment
        prev_comment = "<C-s>p", -- go to previous comment
        react_hooray = "<C-s>ro", -- add/remove 🎉 reaction
        react_heart = "<C-s>rh", -- add/remove ❤️ reaction
        react_eyes = "<C-s>re", -- add/remove 👀 reaction
        react_thumbs_up = "<C-s>rp", -- add/remove 👍 reaction
        react_thumbs_down = "<C-s>rd", -- add/remove 👎 reaction
        react_rocket = "<C-s>rr", -- add/remove 🚀 reaction
        react_laugh = "<C-s>rl", -- add/remove 😄 reaction
        react_confused = "<C-s>rc", -- add/remove 😕 reaction
      },
      pull_request = {
        checkout_pr = "<C-s>po", -- checkout PR
        merge_pr = "<C-s>pm", -- merge commit PR
        squash_and_merge_pr = "<C-s>psm", -- squash and merge PR
        list_commits = "<C-s>pc", -- list PR commits
        list_changed_files = "<C-s>pf", -- list PR changed files
        show_pr_diff = "<C-s>pd", -- show PR diff
        add_reviewer = "<C-s>va", -- add reviewer
        remove_reviewer = "<C-s>vd", -- remove reviewer request
        close_issue = "<C-s>ic", -- close PR
        reopen_issue = "<C-s>io", -- reopen PR
        list_issues = "<C-s>il", -- list open issues on same repo
        reload = "<C-s>u", -- reload PR
        open_in_browser = "<C-s>y", -- open PR in browser
        copy_url = "<C-s>y", -- copy url to system clipboard
        add_assignee = "<C-s>aa", -- add assignee
        remove_assignee = "<C-s>ad", -- remove assignee
        create_label = "<C-s>lc", -- create label
        add_label = "<C-s>la", -- add label
        remove_label = "<C-s>ld", -- remove label
        goto_issue = "<C-s>gi", -- navigate to a local repo issue
        add_comment = "<C-s>ca", -- add comment
        delete_comment = "<C-s>cd", -- delete comment
        next_comment = "]c", -- go to next comment
        prev_comment = "[c", -- go to previous comment
        react_hooray = "<C-s>rp", -- add/remove 🎉 reaction
        react_heart = "<C-s>rh", -- add/remove ❤️ reaction
        react_eyes = "<C-s>re", -- add/remove 👀 reaction
        react_thumbs_up = "<C-s>ru", -- add/remove 👍 reaction
        react_thumbs_down = "<C-s>rd", -- add/remove 👎 reaction
        react_rocket = "<C-s>rr", -- add/remove 🚀 reaction
        react_laugh = "<C-s>rl", -- add/remove 😄 reaction
        react_confused = "<C-s>rc", -- add/remove 😕 reaction
      },
      review_thread = {
        goto_issue = "<C-s>gi", -- navigate to a local repo issue
        add_comment = "<C-s>ca", -- add comment
        add_suggestion = "<C-s>sa", -- add suggestion
        delete_comment = "<C-s>cd", -- delete comment
        next_comment = "]c", -- go to next comment
        prev_comment = "[c", -- go to previous comment
        select_next_entry = "]q", -- move to previous changed file
        select_prev_entry = "[q", -- move to next changed file
        close_review_tab = "<C-s>", -- close review tab
        react_hooray = "<C-s>rp", -- add/remove 🎉 reaction
        react_heart = "<C-s>rh", -- add/remove ❤️ reaction
        react_eyes = "<C-s>re", -- add/remove 👀 reaction
        react_thumbs_up = "<C-s>r+", -- add/remove 👍 reaction
        react_thumbs_down = "<C-s>r-", -- add/remove 👎 reaction
        react_rocket = "<C-s>rr", -- add/remove 🚀 reaction
        react_laugh = "<C-s>rl", -- add/remove 😄 reaction
        react_confused = "<C-s>rc", -- add/remove 😕 reaction
      },
      submit_win = {
        approve_review = "<C-s>a", -- approve review
        comment_review = "<C-s>c", -- comment review
        request_changes = "<C-s>r", -- request changes review
        close_review_tab = "q", -- close review tab
      },
      review_diff = {
        add_review_comment = "<C-s>ca", -- add a new review comment
        add_review_suggestion = "<C-s>sa", -- add a new review suggestion
        focus_files = "<C-s>e", -- move focus to changed file panel
        toggle_files = "<C-s>t", -- hide/show changed files panel
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
        refresh_files = "<C-s>u", -- refresh changed files panel
        focus_files = "<C-s>e", -- move focus to changed file panel
        toggle_files = "<C-s>t", -- hide/show changed files panel
        select_next_entry = "]q", -- move to previous changed file
        select_prev_entry = "[q", -- move to next changed file
        close_review_tab = "q", -- close review tab
        toggle_viewed = "<Tab>", -- toggle viewer viewed state
      },
    },
  })
end

return M
