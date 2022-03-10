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

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
          :sub(col, col)
          :match("%s")
        == nil
  end

  local cmp = require("cmp")
  local ok_ls, ls = pcall(function()
    return require("luasnip")
  end)
  local ok_ng, ng = pcall(function()
    return require("neogen")
  end)

  -- Call the setup function
  cmp.setup({
    snippet = {
      expand = function(args)
        if ok_ls then
          ls.lsp_expand(args.body)
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
      ["<C-Space>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      ["<C-n>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif ok_ng and ng.jumpable() then
          ng.jump_next()
        elseif ok_ls and ls.expand_or_jumpable() then
          ls.expand_or_jump()
        elseif vim.bo.buftype ~= "prompt" and has_words_before() then
          cmp.complete()
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
        elseif ok_ng and ng.jumpable(-1) then
          ng.jump_prev()
        elseif ok_ls and ls.jumpable(-1) then
          ls.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "c",
      }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    },
    sources = {
      { name = "nvim_lua" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
      { name = "buffer", keyword_length = 5, max_item_count = 5 },
    },
    experimental = {
      ghost_text = false,
    },
  })

  cmp.setup.cmdline(":", {
    sources = {
      { name = "cmdline" },
    },
  })

  cmp.setup.cmdline("/", {
    sources = {
      { name = "buffer" },
    },
  })

  local nvim_cmpBuffer = vim.api.nvim_create_augroup(
    "nvim_cmpBuffer",
    { clear = true }
  )
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "latex", "markdown" },
    callback = function()
      require("cmp").setup.buffer({
        sources = { { name = "spell" }, { name = "latex_symbols" } },
      })
    end,
    group = nvim_cmpBuffer,
  })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "norg",
    callback = function()
      require("cmp").setup.buffer({
        sources = { { name = "neorg" }, { name = "spell" } },
      })
    end,
    group = nvim_cmpBuffer,
  })

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
