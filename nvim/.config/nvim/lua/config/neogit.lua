local M = {}
local u = require('utils')

function M.config()
  local ok, neogit = pcall(function()
    return require('neogit')
  end)

  if not ok then
    return
  end

  neogit.setup({
    disable_signs = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = false,
    auto_refresh = true,
    didsable_builtin_notifications = true,
    commit_popup = {
      kind = 'split',
    },
    -- customize displayed signs
    signs = {
      -- { CLOSED, OPENED }
      section = { '>', 'v' },
      item = { '>', 'v' },
      hunk = { '', '' },
    },
    integrations = {
      diffview = true,
    },
    -- override/add mappings
    mappings = {
      -- modify status buffer mappings
      status = {
        ['q'] = 'Close',
        ['1'] = 'Depth1',
        ['2'] = 'Depth2',
        ['3'] = 'Depth3',
        ['4'] = 'Depth4',
        ['<tab>'] = 'Toggle',
        ['x'] = 'Discard',
        ['s'] = 'Stage',
        ['S'] = 'StageUnstaged',
        ['<c-s>'] = 'StageAll',
        ['u'] = 'Unstage',
        ['U'] = 'UnstageStaged',
        ['d'] = 'DiffAtFile',
        ['$'] = 'CommandHistory',
        ['<c-r>'] = 'RefreshBuffer',
        ['<enter>'] = 'GoToFile',
        ['<c-v>'] = 'VSplitOpen',
        ['<c-x>'] = 'SplitOpen',
        ['<c-t>'] = 'TabOpen',
        ['?'] = 'HelpPopup',
        ['D'] = 'DiffPopup',
        ['p'] = 'PullPopup',
        ['r'] = 'RebasePopup',
        ['P'] = 'PushPopup',
        ['c'] = 'CommitPopup',
        ['L'] = 'LogPopup',
        ['Z'] = 'StashPopup',
        ['b'] = 'BranchPopup',
      },
    },
  })

  local opts = { noremap = true, silent = true }
  u.map(
    'n',
    '<Leader>ng',
    '<Cmd>lua require("neogit").open({kind="vsplit"})<Cr>',
    opts
  )
end

return M
