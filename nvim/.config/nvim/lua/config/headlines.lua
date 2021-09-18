local M = {}

function M.config()
  local ok, headlines = pcall(function()
    return require("headlines")
  end)

  if not ok then
    return
  end

  headlines.setup({
    markdown = {
      source_pattern_start = "^```",
      source_pattern_end = "^```$",
      dash_pattern = "^---+$",
      headline_pattern = "^#+",
      headline_signs = { "Headline" },
      codeblock_sign = "CodeBlock",
      dash_highlight = "Dash",
    },
    -- TODO:
    norg = {
      source_pattern_start = "@%+[bB][eE][gG][iI][nN]_[sS][rR][cC]",
      source_pattern_end = "@%+[eE][nN][dD]_[sS][rR][cC]",
      dash_pattern = "^-----+$",
      headline_pattern = "^%*+",
      headline_signs = { "Headline" },
      codeblock_sign = "CodeBlock",
      dash_highlight = "Dash",
    },
    org = {
      source_pattern_start = "#%+[bB][eE][gG][iI][nN]_[sS][rR][cC]",
      source_pattern_end = "#%+[eE][nN][dD]_[sS][rR][cC]",
      dash_pattern = "^-----+$",
      headline_pattern = "^%*+",
      headline_signs = { "Headline" },
      codeblock_sign = "CodeBlock",
      dash_highlight = "Dash",
    },
  })
end

return M
