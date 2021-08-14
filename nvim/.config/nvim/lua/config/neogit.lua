local M = {}
local u = require('utils')

function M.config()
  local ok, neogit = pcall(function() return require('neogit') end)

  if not ok then return end

  neogit.setup {
    disable_signs = false,
    disable_context_highlighting = false,
    -- customize displayed signs
    signs = {
      -- { CLOSED, OPENED }
      section = {'>', 'v'},
      item = {'>', 'v'},
      hunk = {'', ''}
    },
    -- override/add mappings
    mappings = {
      -- modify status buffer mappings
      status = {
        ['<C-c>'] = 'Close',
        ['<Esc>'] = 'Close',
        ['<Tab>'] = 'Toggle',
        ['$'] = 'CommandHistory',
        ['b'] = 'BranchPopup',
        ['s'] = 'Stage',
        ['S'] = 'StageUnstaged',
        ['<C-s>'] = 'StageAll',
        ['u'] = 'Unstage',
        ['U'] = 'UnstageStaged',
        ['c'] = 'CommitPopup',
        ['L'] = 'LogPopup',
        ['p'] = 'PullPopup',
        ['P'] = 'PushPopup',
        ['Z'] = 'StashPopup',
        ['x'] = 'Discard changes',
        ['<Enter>'] = 'GoToFile',
        ['<C-r>'] = 'RefreshBuffer'
      }
    }
  }

  local opts = {noremap = true, silent = true}
  u.map('n', '<Leader>ng',
        '<Cmd>lua require("neogit").open({kind="split"})<Cr>', opts)

end

return M
