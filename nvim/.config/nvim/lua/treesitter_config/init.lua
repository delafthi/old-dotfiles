--------------------------------------------------------------------------------
-- Treesitter config
--------------------------------------------------------------------------------

local ts = require 'nvim-treesitter.configs'
ts.setup{ensure_installed = 'all', highlight = {enable = true}}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.vhdl = {
  install_info = {
    url = "~/Projects/private/tree-sitter-vhdl",
    files = { "src/parser.c" }
  },
  filetype = "vhd",
}
