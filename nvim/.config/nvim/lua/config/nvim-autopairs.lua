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
  })
end

return M
