local M = {}

function M.setup()
  vim.g.vimwiki_list = {
    {
      path = '~/Vimwiki/',
      syntax = 'markdown',
      ext = '.md',
    }
  }
  vim.g.vimwiki_use_mouse = 1
  vim.g.vimwiki_auto_chdir = 1
  vim.g.vimwiki_tags_header = 'Wiki tags'
  vim.g.vimwiki_auto_header = 1
  vim.g.vimwiki_hl_headers = 1
end

return M
