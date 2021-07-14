local M = {}

function M.config()
  local ok, neorg = pcall(function()
    return require('neorg')
  end)

  if not ok then
    return
  end

  neorg.setup {
    load = {
      ['core.defaults'] = {},
      ['core.keybinds'] = {},
      ['core.norg.concealer'] = {},
      ['core.norg.dirman'] = {
        config = {
          workspaces = {
            notes = '~/neorg',
          }
        }
      }
    }
  }
end

return M
