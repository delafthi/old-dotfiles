local M = {}
local u = require("util")
local fn = vim.fn

function M.config()
  local ok, ls = pcall(function()
    return require("luasnip")
  end)

  if not ok then
    return
  end

  local s = ls.snippet
  local sn = ls.snippet_node
  local t = ls.text_node
  local i = ls.insert_node
  local f = ls.function_node
  local c = ls.choice_node
  local d = ls.dynamic_node
  local l = require("luasnip.extras").lambda
  local r = require("luasnip.extras").rep
  local p = require("luasnip.extras").partial
  local m = require("luasnip.extras").match
  local n = require("luasnip.extras").nonempty
  local dl = require("luasnip.extras").dynamic_lambda
  local types = require("luasnip.util.types")

  -- Every unspecified option will be set to the default.
  ls.config.set_config({
    history = true,
    -- Update more often, :h events for more info.
    updateevents = "TextChanged,TextChangedI",
    ext_opts = {
      [types.choiceNode] = {
        active = { virt_text = { { "choiceNode", "Comment" } } },
      },
    },
    -- treesitter-hl has 100, use something higher (default is 200).
    ext_base_prio = 300,
    -- minimal increase in priority.
    ext_prio_increase = 1,
    enable_autosnippets = true,
  })

  local function copy(args)
    return args[1]
  end

  -- Load snippets
  require("luasnip.loaders.from_vscode").lazy_load()

  ls.snippets = {
    all = {},
    markdown = {
      s({
        trig = "---",
        name = "markdown header",
        wordTrig = true,
        docstring = "Insert the markdown document header",
      }, {
        t({ "---", "title: " }),
        i(1, fn.fnamemodify(fn.bufname(), ":t:r")),
        t({ "", "author: " }),
        i(2, "Thierry Delafontaine"),
        t({ "", "date: " }),
        i(3, fn.strftime("%d.%m.%Y")),
        t({ "", "output: " }),
        i(4, fn.fnamemodify(fn.bufname(), ":t:r") .. ".pdf"),
        t({ "", "---", "" }),
        i(0),
      }),
      s({
        trig = "$$",
        name = "math array",
        wordTrig = true,
        docstring = "Insert a math environment",
      }, {
        t({ "$$", "\\begin{array}{" }),
        i(1, "rcl"),
        t({ "}", "" }),
        i(2, " "),
        t({ "", "\\end{array}", "$$", "" }),
        i(0),
      }),
    },
  }
end

return M
