local M = {}

function M.config()
  -- Call the setup function
  require("spellsitter").setup({ hl = "SpellBad", captures = { "comment" } })
end

return M
