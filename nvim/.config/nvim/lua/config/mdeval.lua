local M = {}

function M.config()
  require("mdeval").setup({
    -- Don't ask before executing code blocks
    require_confirmation = true,
    -- Change code blocks evaluation options.
    eval_options = {
      -- Set custom configuration for C++
      cpp = {
        command = { "clang++", "-std=c++20", "-O0" },
        default_header = [[
#include <iostream>
#include <vector>
using namespace std;
      ]],
      },
    },
  })
  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*.norg", "*.md", "*.rmd" },
    callback = function()
      vim.keymap.set("n", "<C-c>e", function()
        require("mdeval").eval_code_block()
      end, { buffer = 0 })
    end,
    group = vim.api.nvim_create_augroup("MdEval", { clear = true }),
  })
end

return M
