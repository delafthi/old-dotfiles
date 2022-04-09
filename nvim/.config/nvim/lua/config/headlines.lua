local M = {}

function M.config()
  -- Call the setup function
  require("headlines").setup({
    markdown = {
      source_pattern_start = "^```",
      source_pattern_end = "^```$",
      dash_pattern = "^---+$",
      headline_pattern = "^#+",
      headline_signs = { "Headline" },
      codeblock_sign = "CodeBlock",
      dash_highlight = "Dash",
    },
    rmd = {
      source_pattern_start = "^```",
      source_pattern_end = "^```$",
      dash_pattern = "^---+$",
      headline_pattern = "^#+",
      headline_signs = { "Headline" },
      codeblock_sign = "CodeBlock",
      dash_highlight = "Dash",
    },
  })
end

return M
