local M = {}

function M.config()
  local ok_cmp, cmp = pcall(function() return require('cmp') end)
  local ok_luasnip, ls = pcall(function() return require('luasnip') end)

  if not ok_cmp or not ok_luasnip then return end

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
      {name = 'buffer'}, {name = 'path'}, {name = 'nvim_lua'},
      {name = 'nvim_lsp'}, {name = 'calc'}, {name = 'latex_symbols'},
      {name = 'luasnip'}
    }
  }
end

return M
