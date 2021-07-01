local M = {}
local cmd = vim.cmd

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
  vim.g.vimwiki_hl_cb_checked = 2

  -- Change vimwiki header highlights to the nord color palette
  local nord_ok, nord = pcall(function()
    return require('nord.colors')
  end)

  if (nord_ok) then
    cmd('au BufEnter *.md hi VimwikiHeader1 guifg=' .. nord.nord11_gui)
    cmd('au BufEnter *.md hi VimwikiHeader2 guifg=' .. nord.nord12_gui)
    cmd('au BufEnter *.md hi VimwikiHeader3 guifg=' .. nord.nord13_gui)
    cmd('au BufEnter *.md hi VimwikiHeader4 guifg=' .. nord.nord14_gui)
    cmd('au BufEnter *.md hi VimwikiHeader5 guifg=' .. nord.nord15_gui)
    cmd('au BufEnter *.md hi VimwikiHeader6 guifg=' .. nord.nord10_gui)
  end
end

return M
