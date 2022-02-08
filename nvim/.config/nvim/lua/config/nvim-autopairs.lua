local M = {}

function M.config()
  local ok, npairs = pcall(function()
    return require("nvim-autopairs")
  end)

  if not ok then
    return
  end

  local rule = require("nvim-autopairs.rule")
  local cond = require("nvim-autopairs.conds")

  npairs.setup({
    check_ts = true,
    map_bs = false,
  })

  npairs.add_rules({
    -- Latex/Markdown
    rule("$", "$", { "markdown", "md", "tex", "latex" }),
    rule("\\begin%{%w*%}$", "\\end{xxx}", {
      "markdown",
      "md",
      "tex",
      "latex",
    }):use_regex(true):use_key("<Cr>"):replace_endpair(function(opts)
      return "<Cr>\\end{"
        .. opts.prev_char:match("\\begin%{(%w*)%}$")
        .. "}<Esc>O"
    end),
  })
end

return M
