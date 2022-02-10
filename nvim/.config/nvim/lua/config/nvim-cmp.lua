local M = {}

function M.config()
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

  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local neogen = require("neogen")

  -- Call the setup function
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
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
        elseif neogen.jumpable() then
          neogen.jump_next()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {
        "i",
        "c",
      }),
      ["<C-p>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif neogen.jumpable(-1) then
          neogen.jump_prev()
        elseif luasnip and luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "c",
      }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<Cr>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
    },
    sources = {
      { name = "nvim_lua" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
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
