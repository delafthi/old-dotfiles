local M = {}

function M.config()
  local ok, org_bullets = pcall(function()
    return require("org-bullets")
  end)

  if not ok then
    return
  end

  org_bullets.setup({
    symbols = { "◉", "○", "✸", "✿" },
  })
end

return M
