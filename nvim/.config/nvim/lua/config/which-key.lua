local M = {}

function M.config()
  vim.o.timeoutlen = 300

  -- Call the setup function
  require("which-key").setup({
    key_labels = {
      ["<Leader>"] = "<Space>",
    },
    hidden = {
      "<Silent>",
      "<Cmd>",
      "<CR>",
      "<Cr>",
      "call",
      "lua",
      "^:",
      "^ ",
    },
  })
end

return M
