local M = {}
local fn = vim.fn

function M.config()
  local ok_cmp, cmp = pcall(function()
    return require("cmp")
  end)
  local ok_luasnip, ls = pcall(function()
    return require("luasnip")
  end)
  local ok_neogen, neogen = pcall(function()
    return require("neogen")
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

  cmp.setup({
    snippet = {
      expand = function(args)
        ls.lsp_expand(args.body)
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
          latex_symbols = "[Tex]",
          luasnip = "[Snip]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[Lua]",
          orgmode = "[Org]",
          neorg = "[Norg]",
          path = "[Path]",
          spell = "[Spell]",
        })[entry.source.name]
        return vim_item
      end,
    },
    mapping = {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if fn.pumvisible() == 1 then
          fn.feedkeys(
            vim.api.nvim_replace_termcodes("<C-n>", true, true, true),
            "n"
          )
        elseif ok_neogen and neogen.jumpable() then
          fn.feedkeys(
            vim.api.nvim_replace_termcodes(
              "<Cmd>lua require('neogen').jump_next()<Cr>",
              true,
              true,
              true
            ),
            ""
          )
        elseif ok_luasnip and ls and ls.expand_or_jumpable() then
          fn.feedkeys(
            vim.api.nvim_replace_termcodes(
              "<Plug>luasnip-expand-or-jump",
              true,
              true,
              true
            ),
            ""
          )
        elseif check_back_space() then
          fn.feedkeys(
            vim.api.nvim_replace_termcodes("<Tab>", true, true, true),
            "n"
          )
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if fn.pumvisible() == 1 then
          fn.feedkeys(
            vim.api.nvim_replace_termcodes("<C-p>", true, true, true),
            "n"
          )
        elseif ok_luasnip and ls and ls.jumpable(-1) then
          fn.feedkeys(
            vim.api.nvim_replace_termcodes(
              "<Plug>luasnip-jump-prev",
              true,
              true,
              true
            ),
            ""
          )
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<Cr>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "luasnip" },
      { name = "buffer" },
    },
  })

  vim.cmd([[
    augroup nvim-cmp
      autocmd!
      autocmd FileType lua,nvim lua require("cmp").setup.buffer({
      \  sources = {
      \    { name = "nvim_lsp" },
      \    { name = "path" },
      \    { name = "luasnip" },
      \    { name = "buffer" },
      \    { name = "nvim_lua" },
      \  },
      \})
      autocmd FileType latex,markdown lua require("cmp").setup.buffer({
      \  sources = {
      \    { name = "nvim_lsp" },
      \    { name = "path" },
      \    { name = "luasnip" },
      \    { name = "buffer" },
      \    { name = "spell" },
      \    { name = "latex_symbols" },
      \  },
      \})
      autocmd FileType org lua require("cmp").setup.buffer({
      \  sources = {
      \    { name = "nvim_lsp" },
      \    { name = "path" },
      \    { name = "luasnip" },
      \    { name = "buffer" },
      \    { name = "spell" },
      \    { name = "orgmode" },
      \  },
      \})
      autocmd FileType norg lua require("cmp").setup.buffer({
      \  sources = {
      \    { name = "nvim_lsp" },
      \    { name = "path" },
      \    { name = "luasnip" },
      \    { name = "buffer" },
      \    { name = "spell" },
      \    { name = "neorg" },
      \  },
      \})
    augroup END
  ]])
end

return M
