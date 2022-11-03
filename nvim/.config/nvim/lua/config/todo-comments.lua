local M = {}

function M.config()
  -- Write the color definitions
  local c = require("nordic.palette")

  -- Call the setup function
  require("todo-comments").setup({
    colors = {
      error = { "DiagnosticError", c.red },
      warning = { "DiagnosticWarning", c.yellow },
      info = { "DiagnosticInformation", c.blue },
      hint = { "DiagnosticHint", c.green },
      default = { "Identifier", c.purple },
      test = { "Identifier", c.orange },
    },
  })
end

return M
