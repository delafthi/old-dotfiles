local M = {}
local u = require("util")

function M.setup()
  vim.g.mkdp_autoclose = 0 -- Disable auto close, when changing to a different buffer.
  vim.g.mkdp_browser = "brave" -- Set default browser.
  vim.gmkdp_filetypes = { "markdown", "vimwiki" } -- Set compatible filetypes.
  vim.g.mkdp_page_title = "${name}" -- Set page title.
  vim.g.mkdp_refresh_slow = 0 -- Turn on faust auto refresh.
  vim.g.mkdp_preview_options = {
    mkit = {},
    katex = {},
    uml = {},
    disable_sync_scroll = 0,
    sync_scroll_type = "relative",
    hide_yaml_meta = 1,
    sequence_diagrams = {},
    flowchart_diagrams = {},
    content_editable = false,
    disable_filename = 0,
  }
end

function M.config()
  local opts = { noremap = false, silent = true }
  u.map("n", "<Leader>mp", "<Plug>MarkdownPreviewToggle", opts) -- Set keymap to toggle preview.
end

return M
