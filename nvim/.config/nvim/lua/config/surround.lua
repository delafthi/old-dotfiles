local M = {}

function M.setup()
  vim.g.surround_mappings_style = 'surround'
end

function M.config()
  local ok, surround = pcall(function()
    return require('surround')
  end)

  if not ok then
    return
  end

  surround.setup({})
end

return M
