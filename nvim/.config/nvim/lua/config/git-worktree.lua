local M = {}
local u = require("util")

function M.config()
  local ok, git_worktree = pcall(function()
    return require("git-worktree")
  end)

  if not ok then
    return
  end

  git_worktree.setup({
    change_directory_command = "cd",
    update_on_change = true,
    update_on_change_command = "e .",
    clearjumps_on_change = true,
    autopush = false,
  })

  local opts = { noremap = true, silent = true }
  u.map(
    "n",
    "<Leader>gb",
    "<Cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<Cr>",
    opts
  )
  u.map(
    "n",
    "<Leader>gB",
    "<Cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<Cr>",
    opts
  )
end

return M
