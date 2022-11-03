local M = {}

function M.config()
  -- Call the setup function
  require("mdeval").setup({
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
      ]] ,
      },
    },
  })

  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.norg", "*.md", "*.rmd" },
    callback = function()
      require("which-key").register({
        ["<C-c>"] = {
          e = {
            function()
              require("mdeval").eval_code_block({})
            end,
            "Evaluate code block",
            buffer = vim.api.nvim_get_current_buf(),
          },
        },
      })
    end,
    group = vim.api.nvim_create_augroup(
      "MdEvalBufferMappings",
      { clear = true }
    ),
  })
end

return M
