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
    rule("$", "$", { "markdown", "md", "tex", "latex" }):with_cr(cond.none()),
    rule("$$", "$$", { "markdown", "md", "tex", "latex" }),
  })
end

return M
