local M = {}
local fn = vim.fn

function M.config()
  local ls = require("luasnip")
  local s = ls.snippet
  local i = ls.insert_node
  local fmt = require("luasnip.extras.fmt").fmt
  local rep = require("luasnip.extras").rep
  local types = require("luasnip.util.types")

  -- Every unspecified option will be set to the default.
  ls.config.set_config({
    -- If true, Snippets that were exited can still be jumped back into. As
    -- Snippets are not removed when their text is deleted, they have to be
    -- removed manually via LuasnipUnlinkCurrent if delete_check_events is not
    -- enabled (set to eg. 'TextChanged').
    history = true,
    -- Choose which events trigger an update of the active nodes' dependents.
    -- Default is just 'InsertLeave', 'TextChanged,TextChangedI' would update on
    -- every change.
    updateevents = "TextChanged,TextChangedI",
    -- Events on which to leave the current snippet if the cursor is outside
    -- its' 'region'. Disabled by default, 'CursorMoved', 'CursorHold' or
    -- 'InsertEnter' seem reasonable.
    region_check_events = "CursorHold,InsertLeave",
    -- When to check if the current snippet was deleted, and if so, remove it
    -- from the history. Off by default, 'TextChanged' (perhaps 'InsertLeave',
    -- to react to changes done in Insert mode) should work just fine
    -- (alternatively, this can also be mapped using
    -- <Plug>luasnip-delete-check).
    delete_check_events = "TextChanged,InsertEnter",
    -- Autosnippets are disabled by default to minimize performance penalty if
    -- unused. Set to true to enable.
    enable_autosnippets = true,
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { " ", "Number" } },
          priority = 0,
        },
      },
    },
  })

  -- Load snippets
  require("luasnip.loaders.from_vscode").lazy_load()

  -- Define snippets
  ls.add_snippets("markdown", {
    s(
      {
        trig = "---",
        name = "Markdown header",
        docstring = "Insert the markdown document header",
      },
      fmt(
        "---\n"
          .. "title: {}\n"
          .. "author: {}\n"
          .. "date: {}\n"
          .. "output: {}\n"
          .. "---\n"
          .. "{}",
        {
          i(1, fn.fnamemodify(fn.bufname(), ":t:r")),
          i(2, "Thierry Delafontaine"),
          i(3, fn.strftime("%d.%m.%Y")),
          i(4, fn.fnamemodify(fn.bufname(), ":t:r") .. "pdf_document"),
          i(0),
        }
      )
    ),
    s(
      {
        trig = "$$",
        name = "Math array",
        docstring = "Insert a math environment",
      },
      fmt(
        "$$\n"
          .. "\\begin{{array}}{{{}}}\n"
          .. "{}\n"
          .. "\\end{{array}}\n"
          .. "$$\n"
          .. "{}",
        {
          i(1, "rcl"),
          i(2),
          i(0),
        }
      )
    ),
  })
end

return M
