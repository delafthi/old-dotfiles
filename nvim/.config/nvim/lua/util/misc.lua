local M = {}

function M.foldtext()
  local foldstart = vim.api.nvim_get_vvar("foldstart")
  local line = vim.api.nvim_buf_get_lines(0, foldstart - 1, foldstart, false)
  local sub = string.gsub(line[1], "{{{.*", "")
  return "▸ " .. sub
end

return M
