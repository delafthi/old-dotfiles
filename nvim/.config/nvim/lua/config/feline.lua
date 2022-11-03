local M = {}

function M.config()
  -- Write the color definitions
  local c = require("nordic.palette")

  -- Overwrite the statusline hls to prevent interference
  vim.cmd("highlight Statusline guibg=" .. c.dark_black)
  vim.cmd("highlight StatuslineNC guibg=" .. c.dark_black)

  -- Call the setup function
  require("feline").setup({
    components = {
      active = {
        -- Left section of statusline
        {
          {
            provider = "",
            hl = function()
              return {
                name = require("feline.providers.vi_mode").get_mode_highlight_name()
                    .. "LeftCap",
                fg = require("feline.providers.vi_mode").get_mode_color(),
                bg = "bg",
                style = "bold",
              }
            end,
          },
          {
            provider = "vi_mode",
            hl = function()
              return {
                name = require("feline.providers.vi_mode").get_mode_highlight_name(),
                fg = "black",
                bg = require("feline.providers.vi_mode").get_mode_color(),
                style = "bold",
              }
            end,
            icon = "",
          },
          {
            provider = "",
            hl = function()
              return {
                name = require("feline.providers.vi_mode").get_mode_highlight_name()
                    .. "RightCap",
                fg = require("feline.providers.vi_mode").get_mode_color(),
                bg = "dark_grey",
                style = "bold",
              }
            end,
          },
          {
            provider = "diagnostic_errors",
            hl = function()
              return {
                name = "StatusComponentLspErrors",
                fg = "red",
                bg = "dark_grey",
                style = "bold",
              }
            end,
            icon = " ",
            left_sep = "█",
          },
          {
            provider = "diagnostic_warnings",
            hl = function()
              return {
                name = "StatusComponentLspWarnings",
                fg = "yellow",
                bg = "dark_grey",
                style = "bold",
              }
            end,
            icon = " ",
            left_sep = "█",
          },
          {
            provider = "diagnostic_info",
            hl = function()
              return {
                name = "StatusComponentLspInfo",
                fg = "blue",
                bg = "dark_grey",
              }
            end,
            icon = " ",
            left_sep = "█",
          },
        },
        -- Right section of statusline
        {
          {
            provider = "",
            hl = function()
              return {
                name = "StatusComponentRightSideLeftCap",
                fg = "light_grey",
                bg = "dark_grey",
              }
            end,
          },
          {
            provider = "git_diff_added",
            hl = function()
              return {
                name = "StatusComponentGitDiffAdded",
                fg = "green",
                bg = "light_grey",
              }
            end,
            icon = " ",
            right_sep = "█",
          },
          {
            provider = "git_diff_changed",
            hl = function()
              return {
                name = "StatusComponentGitDiffChanged",
                fg = "yellow",
                bg = "light_grey",
              }
            end,
            icon = " ",
            right_sep = "█",
          },
          {
            provider = "git_diff_removed",
            hl = function()
              return {
                name = "StatusComponentGitDiffRemoved",
                fg = "red",
                bg = "light_grey",
              }
            end,
            icon = " ",
            right_sep = "█",
          },
          {
            provider = "git_branch",
            hl = function()
              return {
                name = "StatusComponentGitBranch",
                fg = "orange",
                bg = "light_grey",
              }
            end,
            icon = " ",
            right_sep = "█",
          },
          {
            provider = "file_info",
            hl = function()
              return {
                name = "StatusComponentFileInfo",
                fg = "white",
                bg = "light_grey",
              }
            end,
            right_sep = "█",
          },
          {
            provider = "file_size",
            hl = function()
              return {
                name = "StatusComponentFileSize",
                fg = "white",
                bg = "light_grey",
              }
            end,
            right_sep = "█",
          },
          {
            provider = "",
            hl = function()
              return {
                name = "StatusComponentPositionLeftCap",
                fg = "blue",
                bg = "light_grey",
              }
            end,
          },
          {
            provider = "position",
            hl = function()
              return {
                name = "StatusComponentPosition",
                fg = "black",
                bg = "blue",
              }
            end,
            right_sep = "█",
          },
          {
            provider = "line_percentage",
            hl = function()
              return {
                name = "StatusComponentLinePercentage",
                fg = "black",
                bg = "blue",
              }
            end,
          },
          {
            provider = "",
            hl = function()
              return {
                name = "StatusComponentLinePercentageRightCap",
                fg = "blue",
                bg = "bg",
              }
            end,
          },
        },
      },
      inactive = {
        {
          {
            provider = "",
            hl = function()
              return {
                name = "StatusNCComponentEmptyLeftCap",
                fg = "dark_grey",
                bg = "bg",
              }
            end,
          },
          {
            provider = " ",
            hl = function()
              return {
                name = "StatusNCComponentEmpty",
                fg = "white",
                bg = "dark_grey",
              }
            end,
          },
        },
        {
          {
            provider = "",
            hl = function()
              return {
                name = "StatusNCComponentPositionLeftCap",
                fg = "light_grey",
                bg = "dark_grey",
              }
            end,
          },
          {
            provider = "file_info",
            hl = function()
              return {
                name = "StatusNCComponentFileInfo",
                fg = "white",
                bg = "light_grey",
              }
            end,
            right_sep = "█",
          },
          {
            provider = "position",
            hl = function()
              return {
                name = "StatusNCComponentPosition",
                fg = "white",
                bg = "light_grey",
              }
            end,
            right_sep = "█",
          },
          {
            provider = "line_percentage",
            hl = function()
              return {
                name = "StatusNCComponentLinePercentage",
                fg = "white",
                bg = "light_grey",
              }
            end,
          },
          {
            provider = "",
            hl = function()
              return {
                name = "StatusNCComponentLinePercentageRightCap",
                fg = "light_grey",
                bg = "bg",
              }
            end,
          },
        },
      },
    },
    custom_providers = {},
    theme = {
      fg = c.dark_white,
      bg = c.dark_black,
      black = c.dark_black,
      dark_grey = c.black,
      grey = c.bright_black,
      light_grey = c.gray,
      white = c.dark_white,
      light_white = c.white,
      dark_blue = c.intense_blue,
      blue = c.blue,
      skyblue = c.blue,
      light_blue = c.cyan,
      cyan = c.bright_cyan,
      red = c.red,
      orange = c.orange,
      yellow = c.yellow,
      green = c.green,
      magenta = c.purple,
      violet = c.purple,
    },
    force_inactive = {
      filetypes = {
        "^packer$",
        "^alpha$",
        "^Neogit",
        "^Telescope",
        "^help$",
      },
      buftypes = { "^terminal$" },
    },
  })
end

return M
