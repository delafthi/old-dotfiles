local M = {}
local fn = vim.fn

function M.config()
  local ok_cmp, cmp = pcall(function()
    return require("cmp")
  end)

  if not ok_cmp then
    return
  end

  local check_back_space = function()
    local col = fn.col(".") - 1
    return col == 0 or fn.getline("."):sub(col, col):match("%s")
  end

  -- Custom completion kind icons
  local icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
  }

  local ok_luasnip, luasnip = pcall(function()
    return require("luasnip")
  end)
  local ok_neogen, neogen = pcall(function()
    return require("neogen")
  end)

  cmp.setup({
    snippet = {
      expand = function(args)
        if ok_luasnip then
          luasnip.lsp_expand(args.body)
        end
      end,
    },
    documentation = {
      border = { "", "", "", " ", "", "", "", " " },
      winhighlight = "NormalFloat:CmpDocumentation,FloatBorder:CmpDocumentationBorder",
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.kind = icons[vim_item.kind]
        vim_item.menu = ({
          buffer = "[Bufr]",
          calc = "[Calc]",
          latex_symbols = "[TeX]",
          luasnip = "[Snip]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[API]",
          orgmode = "[Org]",
          neorg = "[Norg]",
          path = "[Path]",
          spell = "[Spell]",
        })[entry.source.name]
        return vim_item
      end,
    },
    mapping = {
      ["<C-n>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif ok_neogen and neogen.jumpable() then
          neogen.jump_next()
        elseif ok_luasnip and luasnip and luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<C-p>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif ok_luasnip and luasnip and luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<Cr>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
    },
    sources = {
      { name = "nvim_lua" },
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "luasnip" },
      { name = "buffer", keyword_length = 5 },
    },
    experimental = {
      ghost_text = false,
    },
  })

  vim.cmd([[
    augroup nvim-cmp-buffer
      autocmd!
      autocmd FileType latex,markdown lua require("cmp").setup.buffer({
      \  sources = {
      \    { name = "spell" },
      \    { name = "latex_symbols" },
      \  },
      \})
      autocmd FileType org lua require("cmp").setup.buffer({
      \  sources = {
      \    { name = "spell" },
      \    { name = "orgmode" },
      \  },
      \})
      autocmd FileType norg lua require("cmp").setup.buffer({
      \  sources = {
      \    { name = "spell" },
      \    { name = "neorg" },
      \  },
      \})
    augroup END
  ]])

  pcall(function()
    cmp.event:on(
      "confirm_done",
      require("nvim-autopairs.completion.cmp").on_confirm_done({
        map_char = { tex = "" },
      })
    )
  end)
end

return M
