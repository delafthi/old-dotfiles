local M = {}

function M.config()
  local ok, ts = pcall(function()
    return require("nvim-treesitter.configs")
  end)

  if not ok then
    return
  end

  -- Additional parsers
  local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

  parser_configs.norg = {
    install_info = {
      url = "https://github.com/vhyrro/tree-sitter-norg",
      branch = "main",
      files = { "src/parser.c" },
    },
  }

  parser_configs.org = {
    install_info = {
      url = "https://github.com/milisims/tree-sitter-org",
      branch = "main",
      files = { "src/parser.c", "src/scanner.cc" },
    },
  }

  ts.setup({
    ensure_installed = "maintained",
    highlight = { enable = true },
    indent = { enable = false },
    incremental_selection = { enable = false },
    -- Treesitter Plugins
    context_commentstring = {
      enable = true,
    },
    rainbow = { enable = true, extended_mode = true, max_file_lines = 1000 },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = { ["<Leader>a"] = "@parameter.inner" },
        swap_previous = { ["<Leader>A"] = "@parameter.inner" },
      },
      move = {
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
        goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      lsp_interop = {
        enable = true,
        border = "none",
        peek_definition_code = {
          ["df"] = "@function.outer",
          ["dF"] = "@class.outer",
        },
      },
    },
  })
end

return M
