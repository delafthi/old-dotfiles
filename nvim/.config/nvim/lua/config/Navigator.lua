local M = {}

function M.config()
  -- Call the setup function
  require("Navigator").setup({
    auto_save = nil,
    disable_on_zoom = false,
  })
end

return M
