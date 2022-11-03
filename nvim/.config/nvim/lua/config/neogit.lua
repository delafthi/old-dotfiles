local M = {}

function M.config()
  -- Call the setup function
  require("neogit").setup({
    disable_commit_confirmation = true,
    integrations = {
      diffview = true,
    },
    -- override/add mappings
    mappings = {
      -- modify status buffer mappings
      status = {
        ["q"] = "Close",
        ["1"] = "Depth1",
        ["2"] = "Depth2",
        ["3"] = "Depth3",
        ["4"] = "Depth4",
        ["<Tab>"] = "Toggle",
        ["x"] = "Discard",
        ["s"] = "Stage",
        ["S"] = "StageUnstaged",
        ["<c-s>"] = "StageAll",
        ["u"] = "Unstage",
        ["U"] = "UnstageStaged",
        ["d"] = "DiffAtFile",
        ["$"] = "CommandHistory",
        ["<C-r>"] = "RefreshBuffer",
        ["<Enter>"] = "GoToFile",
        ["<C-v>"] = "VSplitOpen",
        ["<C-x>"] = "SplitOpen",
        ["<C-t>"] = "TabOpen",
        ["?"] = "HelpPopup",
        ["D"] = "DiffPopup",
        ["p"] = "PullPopup",
        ["r"] = "RebasePopup",
        ["P"] = "PushPopup",
        ["c"] = "CommitPopup",
        ["L"] = "LogPopup",
        ["Z"] = "StashPopup",
        ["b"] = "BranchPopup",
      },
    },
  })
end

return M
