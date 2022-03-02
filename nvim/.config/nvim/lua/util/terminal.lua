local M = {}
local cmd = vim.cmd

function M.open(split)
  if split == "h" then
    cmd([[botright 12 split term://$SHELL]])
  else
    cmd([[botright vsplit term://$SHELL]])
  end
  cmd([[setlocal nonumber]])
  cmd([[setlocal norelativenumber]])
  cmd([[startinsert]])
end

return M
