local M = {}
local keymap = vim.keymap

function M.setup()
  -- Define global variables
  vim.g.dashboard_default_executive = "telescope"
  vim.g.dashboard_custom_header = {
    "                                                       ",
    "                                                       ",
    " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
    " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
    " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
    " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
    " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
    " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
    "                                                       ",
    "                                                       ",
  }

  vim.g.dashboard_custom_section = {
    restore_session = {
      description = {
        " Restore last session                       SPC s l",
      },
      command = "SessionLoad",
    },
    find_history = {
      description = {
        " Recently opened files                      SPC h h",
      },
      command = "DashboardFindHistory",
    },
    find_files = {
      description = {
        " Find File                                  SPC f f",
      },
      command = "Telescope find_files",
    },
    file_browser = {
      description = {
        " File Browser                               SPC f b",
      },
      command = "Telescope find_browser",
    },
    find_word = {
      description = {
        " Find Word                                  SPC r g",
      },
      command = "Telescope grep_string",
    },
    new_file = {
      description = {
        " New File                                   SPC n f",
      },
      command = "DashboardNewFile",
    },
  }

  vim.g.dashboard_custom_footer = {}
end

return M
