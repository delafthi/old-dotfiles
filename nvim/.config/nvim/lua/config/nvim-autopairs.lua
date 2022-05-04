local M = {}

function M.config()
  local npairs = require("nvim-autopairs")
  local Rule = require("nvim-autopairs.rule")
  local cond = require("nvim-autopairs.conds")

  -- Call the setup function
  npairs.setup({
    check_ts = true,
    map_bs = false,
  })

  -- Add additional autopairs rules
  npairs.add_rules({
    -- Latex/Markdown
    Rule("$", "$", { "latex", "markdown", "rmd" }),
  })
end

return M
