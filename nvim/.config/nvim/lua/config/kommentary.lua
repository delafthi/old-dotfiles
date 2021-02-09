local M = {}

function M.setup()
	vim.g.kommentary_create_default_mappings = false
end

function M.config()
  require'kommentary.config'.use_extended_mappings()
  vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_default", {})
  vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>kommentary_motion_default", {})
  vim.api.nvim_set_keymap("v", "<leader>c", "<Plug>kommentary_visual_default", {})
end

return M
