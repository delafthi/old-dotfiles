local M = {}
local fn = vim.fn

function M.config()
  local ok_cmp, cmp = pcall(function() return require('cmp') end)
  local ok_luasnip, ls = pcall(function() return require('luasnip') end)
  local ok_neogen, neogen = pcall(function() return require('neogen') end)

  if not ok_cmp then return end

  local check_back_space = function()
    local col = fn.col('.') - 1
    return col == 0 or fn.getline('.'):sub(col, col):match('%s')
  end

  cmp.setup {
    snippet = {expand = function(args) ls.lsp_expand(args.body) end},
    documentation = {
      border = {'', '', '', ' ', '', '', '', ' '},
      winhighlight = 'NormalFloat:CmpDocumentation,FloatBorder:CmpDocumentationBorder'
    },
    mapping = {
      ['<Tab>'] = cmp.mapping(function(fallback)
        if fn.pumvisible() == 1 then
          fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true),
                      'n')
        elseif ok_neogen and neogen.jumpable() then
          fn.feedkeys(vim.api.nvim_replace_termcodes(
                          '<Cmd>lua require("neogen").jump_next()<Cr>', true,
                          true, true), '')
        elseif ok_luasnip and ls and ls.expand_or_jumpable() then
          fn.feedkeys(vim.api.nvim_replace_termcodes(
                          '<Plug>luasnip-expand-or-jump', true, true, true), '')
        elseif check_back_space() then
          fn.feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true),
                      'n')
        else
          fallback()
        end
      end, {'i', 's'}),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if fn.pumvisible() == 1 then
          fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true),
                      'n')
        elseif ok_luasnip and ls and ls.jumpable(-1) then
          fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev',
                                                     true, true, true), '')
        else
          fallback()
        end
      end, {'i', 's'}),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<Cr>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true
      })
    },
    sources = {
      {name = 'nvim_lsp'}, {name = 'path'}, {name = 'luasnip'},
      {name = 'latex_symbols'}, {name = 'nvim_lua'}, {name = 'buffer'},
      {name = 'calc'}
    }
  }
end

return M
