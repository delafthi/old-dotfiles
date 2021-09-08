local M = {}

function M.setup()
  vim.g.nord_borders = true
  vim.g.nord_contrast = true
  vim.g.nord_italic = true
end

function M.config()
  local ok, nord = pcall(function()
    return require("nord")
  end)

  if not ok then
    return
  end

  nord.set()
end

return M
