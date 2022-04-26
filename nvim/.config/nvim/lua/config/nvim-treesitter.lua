local M = {}

function M.config()
  local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
  parser_configs.vhdl = {
    install_info = {
      url = "https://github.com/alemuller/tree-sitter-vhdl",
      files = { "src/parser.c" },
      branch = "main",
    },
    filetype = { "vhdl", "vhd" },
  }
  parser_configs.norg_meta = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
      files = { "src/parser.c" },
      branch = "main",
    },
  }
  parser_configs.norg_table = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
      files = { "src/parser.c" },
      branch = "main",
    },
  }
  -- Call the setup function
  require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    highlight = { enable = true },
    indent = { enable = false },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },

    -- Treesitter Plugins
    context_commentstring = {
      enable = true,
    },
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
        swap_next = { ["<Leader>as"] = "@parameter.inner" },
        swap_previous = { ["<Leader>aS"] = "@parameter.inner" },
      },
      move = {
        enable = true,
        set_jumps = false, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["<C-g>nf"] = "@function.outer",
          ["<C-g>nc"] = "@class.outer",
        },
        goto_next_end = {
          ["<C-g>nF"] = "@function.outer",
          ["<C-g>nC"] = "@class.outer",
        },
        goto_previous_start = {
          ["<C-g>pf"] = "@function.outer",
          ["<C-g>pc"] = "@class.outer",
        },
        goto_previous_end = {
          ["<C-g>pF"] = "@function.outer",
          ["<C-g>pC"] = "@class.outer",
        },
      },
      -- lsp_interop = {
      --   enable = true,
      --   border = "none",
      --   peek_definition_code = {
      --     ["<C-g>f"] = "@function.outer",
      --     ["<C-g>c"] = "@class.outer",
      --   },
      -- },
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    },
  })
end

return M
