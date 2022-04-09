local M = {}

function M.foldtext()
  local foldstart = vim.api.nvim_get_vvar("foldstart")
  local line = vim.api.nvim_buf_get_lines(0, foldstart - 1, foldstart, false)
  local sub = string.gsub(line[1], "{{{.*", "")
  return "▸ " .. sub
end

function M.exec_and_restore_view(cmd)
  local save = vim.fn.winsaveview()
  vim.api.nvim_exec(cmd, false)
  vim.fn.winrestview(save)
end

return M
