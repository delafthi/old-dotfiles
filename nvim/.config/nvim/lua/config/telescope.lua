local M = {}

function M.config()
  local telescope = require("telescope")

  -- Call the setup function
  telescope.setup({
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--hidden",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--glob",
        "!.git/*",
        "--trim",
      },
      prompt_prefix = " ",
      selection_caret = " ",
      multi_icon = "│",
      sorting_strategy = "ascending",
      layout_strategy = "flex",
      layout_config = {
        height = 0.8,
        width = 0.8,
        prompt_position = "top",
        preview_cutoff = 120,
        horizontal = { mirror = false, preview_width = 0.6 },
        vertical = { mirror = true },
      },
      file_ignore_patterns = { "%.git", "node_modules", "%.cache" },
      path_display = { shorten = 3 },
      set_env = { ["COLORTERM"] = "truecolor" },
    },
    extensions = {
      file_browser = {
        mappings = {
          ["i"] = {
            ["<C-c>"] = telescope.extensions.file_browser.actions.create,
          },
        },
      },
      project = {
        base_dirs = {
          "~/projects/work",
          "~/projects/private",
        },
        hidden_files = true,
      },
    },
    pickers = {
      find_files = {
        find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
      },
    },
  })
  telescope.load_extension("file_browser")
  telescope.load_extension("fzf")
  telescope.load_extension("project")
end

return M
