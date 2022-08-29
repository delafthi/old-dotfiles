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
      prompt_prefix = ">> ",
      selection_caret = "> ",
      entry_prefix = " ",
      initial_mode = "insert",
      selection_strategy = "reset",
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
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "%.git", "node_modules", "%.cache" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      path_display = {
        shorten = 3,
      },
      set_env = { ["COLORTERM"] = "truecolor" },
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
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
  telescope.load_extension("fzy_native")
  telescope.load_extension("file_browser")
  telescope.load_extension("project")
end

return M
