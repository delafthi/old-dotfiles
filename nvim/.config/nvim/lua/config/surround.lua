local M = {}

function M.setup()
  vim.g.surround_mappings_style = 'surround'
end

function M.config()
  require('surround').setup{}
end

return M
