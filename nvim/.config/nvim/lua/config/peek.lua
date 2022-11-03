local M = {}

function M.config()
  -- Call the setup function
  require("peek").setup({
    auto_load = false, -- whether to automatically load preview when
    -- entering another markdown buffer
    throttle_time = 5, -- minimum amount of time in milliseconds
    -- that has to pass before starting new render
  })

  -- Create user command to toggle peek
  vim.api.nvim_create_user_command("PeekToggle", function()
    local peek = require("peek")
    if peek.is_open() then
      peek.close()
    else
      peek.open()
    end
  end, {})
end

-- Create keybindings
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.md", "*.rmd" },
  callback = function()
    require("which-key").register({
      ["<Leader>"] = {
        t = {
          m = {
            "<Cmd>PeekToggle<Cr>",
            "Toggle markdown peek",
            buffer = vim.api.nvim_get_current_buf(),
          },
        },
      },
    })
  end,
  group = vim.api.nvim_create_augroup("PeekBufferMappings", { clear = true }),
})

return M
