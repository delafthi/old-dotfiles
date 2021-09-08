local M = {}

function M.config()
  local ok, spellsitter = pcall(function()
    return require("spellsitter")
  end)

  if not ok then
    return
  end

  spellsitter.setup({ hl = "SpellBad", captures = { "comment" } })
end

return M
