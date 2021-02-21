local M = {}

function M.setup()
  vim.g.qs_buftype_blacklist = {'terminal', 'nofile', 'NvimTree', 'help'}
  vim.api.nvim_exec([[
  augroup qs_color
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary gui=bold,underline cterm=bold,underline
    autocmd ColorScheme * highlight QuickScopeSecondary gui=bold,underline cterm=bold,underline
  augroup END
  ]], false)
end

return M
