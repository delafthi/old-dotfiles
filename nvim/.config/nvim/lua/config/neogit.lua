local M = {}
local keymap = vim.keymap

function M.config()
  local ok, neogit = pcall(function()
    return require("neogit")
  end)

  if not ok then
    return
  end

  neogit.setup({
    disable_signs = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = true,
    auto_refresh = true,
    disable_builtin_notifications = false,
    commit_popup = {
      kind = "split",
    },
    -- customize displayed signs
    signs = {
      -- { CLOSED, OPENED }
      section = { ">", "v" },
      item = { ">", "v" },
      hunk = { "", "" },
    },
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

  local opts = { silent = true }
  keymap.set("n", "<Leader>ng", function()
    neogit.open({ kind = "vsplit" })
  end, opts)
end

return M
