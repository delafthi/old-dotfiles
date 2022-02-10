local M = {}

function M.config()
  local npairs = require("nvim-autopairs")
  local rule = require("nvim-autopairs.rule")

  -- Call the setup function
  npairs.setup({
    check_ts = true,
    map_bs = false,
  })

  -- Add additional autopairs rules
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
