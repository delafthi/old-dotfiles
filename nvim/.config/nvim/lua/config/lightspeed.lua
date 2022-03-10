local M = {}

function M.config()
  -- Call the setup function
  require("lightspeed").setup({
    match_only_the_start_of_same_char_seqs = true,
    jump_to_unique_chars = {
      highlight_unique_chars = false,
      safety_timeout = 400,
    },
    labels = nil,
    cycle_group_fwd_key = nil,
    cycle_group_bwd_key = nil,
    limit_ft_matches = 4,
  })

  local lightspeedNohlsearch = vim.api.nvim_create_augroup(
    "lightspeedNohlsearch",
    { clear = true }
  )
  vim.api.nvim_create_autocmd("User", {
    pattern = "LightspeedEnter",
    command = "let &hlsearch = 0",
    group = lightspeedNohlsearch,
  })
  vim.api.nvim_create_autocmd("User", {
    pattern = "LightspeedLeave",
    command = "let &hlsearch = 1",
    group = lightspeedNohlsearch,
  })
end

return M
