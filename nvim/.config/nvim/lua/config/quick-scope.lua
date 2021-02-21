local M = {}

function M.setup()
  vim.g.qs_buftype_blacklist = {'terminal', 'nofile', 'NvimTree', 'help'}
end

return M
