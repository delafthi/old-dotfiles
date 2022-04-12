local M = {}

function M.foldtext()
  local foldstart = vim.api.nvim_get_vvar("foldstart")
  local line = vim.api.nvim_buf_get_lines(0, foldstart - 1, foldstart, false)
  local sub = string.gsub(line[1], "{{{.*", "")
  return "▸ " .. sub
end

function M.exec_and_restore_view(cmd)
  local curw = vim.fn.winsaveview()
  -- Save our undo file to be restored after we are done. This is needed to
  -- prevent an additional undp jump due to BufWritePre auto command.
  local tmpundofile = vim.fn.tempname()
  vim.cmd("wundo! " .. tmpundofile)
  vim.cmd("try | silent undojoin | catch | endtry")
  vim.cmd(cmd)
  vim.cmd("silent! rundo " .. tmpundofile)
  vim.fn.delete(tmpundofile)
  vim.fn.winrestview(curw)
end

return M
