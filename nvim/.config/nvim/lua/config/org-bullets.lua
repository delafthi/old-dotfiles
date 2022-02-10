local M = {}

function M.config()
  --  Call the setup function
  require("org_bullets").setup({
    symbols = { "◉", "○", "✸", "✿" },
  })
end

return M
