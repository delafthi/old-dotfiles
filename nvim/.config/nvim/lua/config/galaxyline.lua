local M = {}

function M.config()
  local gl = require("galaxyline")
  local glpf = require("galaxyline.provider_fileinfo")
  local condition = require("galaxyline.condition")

  local gls = gl.section

  -- Check if the nord theme is installed
  -- Write the color definitions
  local nord = require("nord.colors")

  local c = {
    black0 = nord.nord0,
    black1 = nord.nord1,
    black2 = nord.nord2,
    black3 = nord.nord3,
    white0 = nord.nord4,
    white1 = nord.nord5,
    white2 = nord.nord6,
    cyan = nord.nord7,
    blue0 = nord.nord8,
    blue1 = nord.nord9,
    blue2 = nord.nord10,
    red = nord.nord11,
    orange = nord.nord12,
    yellow = nord.nord13,
    green = nord.nord14,
    magenta = nord.nord15,
  }

  -- Overwrite the statusline hls to prevent interference
  vim.cmd("highlight Statusline guibg=" .. c.black0)
  vim.cmd("highlight StatuslineNC guibg=" .. c.black0)

  -- Shorter statusline for these filetypes
  gl.short_line_list = { "packer", "dashboard" }

  -- Set some defaults
  local left_cap = ""
  local right_cap = ""

  -- Local helper functions
  local modes = {
    n = { "NORMAL", c.green },
    i = { "INSERT", c.blue0 },
    c = { "COMMAND", c.red },
    t = { "TERMINAL", c.orange },
    v = { "VISUAL", c.yellow },
    V = { "V-LINE", c.yellow },
    [""] = { "V-BLOCK", c.yellow },
    R = { "REPLACE", c.magenta },
    s = { "SELECT", c.red },
    S = { "S-LINE", c.red },
    [""] = { "X-BLOCK", c.red },
  }

  -- Left side
  -- ViMode
  gls.left[1] = {
    ViModeLeftCap = {
      provider = function()
        local vim_mode = vim.fn.mode()
        local mode_style = modes[vim_mode]
        vim.api.nvim_command("hi GalaxyViModeLeftCap guifg=" .. mode_style[2])
        return left_cap
      end,
      highlight = { c.black2, c.black0, "bold" },
    },
  }
  gls.left[2] = {
    ViMode = {
      provider = function()
        local vim_mode = vim.fn.mode()
        local mode_style = modes[vim_mode]
        vim.api.nvim_command("hi GalaxyViMode guibg=" .. mode_style[2])
        return mode_style[1]
      end,
      highlight = { c.black0, c.black2, "bold" },
    },
  }
  gls.left[3] = {
    ViModeRightCap = {
      provider = function()
        local vim_mode = vim.fn.mode()
        local mode_style = modes[vim_mode]
        vim.api.nvim_command("hi GalaxyViModeRightCap guifg=" .. mode_style[2])
        return right_cap
      end,
      highlight = { c.black2, c.black1, "bold" },
    },
  }
  -- Spacer
  gls.left[4] = {
    Space = {
      provider = function()
        return " "
      end,
      highlight = { c.white0, c.black1 },
    },
  }
  -- LSP Diagnostics
  gls.left[5] = {
    DiagnosticError = {
      provider = "DiagnosticError",
      icon = "  ",
      highlight = { c.red, c.black1 },
    },
  }
  gls.left[6] = {
    DiagnosticWarn = {
      provider = "DiagnosticWarn",
      icon = "  ",
      highlight = { c.yellow, c.black1 },
    },
  }
  gls.left[7] = {
    DiagnosticInfo = {
      provider = "DiagnosticInfo",
      icon = "  ",
      highlight = { c.blue0, c.black1 },
    },
  }
  -- Middle

  -- Right side
  gls.right[1] = {
    FileInfoLeftCap = {
      provider = function()
        return left_cap
      end,
      condition = condition.buffer_not_empty,
      highlight = { c.black3, c.black1, "bold" },
    },
  }
  -- Git diff
  gls.right[2] = {
    GitDiffAdd = {
      provider = "DiffAdd",
      icon = "  ",
      condition = condition.buffer_not_empty,
      highlight = { c.green, c.black3 },
    },
  }
  gls.right[3] = {
    GitDiffModified = {
      provider = "DiffModified",
      icon = "  ",
      condition = condition.buffer_not_empty,
      highlight = { c.magenta, c.black3 },
    },
  }
  gls.right[4] = {
    GitDiffRemove = {
      provider = "DiffRemove",
      icon = "  ",
      condition = condition.buffer_not_empty,
      highlight = { c.red, c.black3 },
    },
  }
  -- Git branch
  gls.right[6] = {
    GitIcon = {
      provider = function()
        return "  "
      end,
      condition = function()
        return condition.buffer_not_empty() and condition.check_git_workspace()
      end,
      highlight = { c.orange, c.black3 },
    },
  }
  gls.right[7] = {
    GitBranch = {
      provider = {
        "GitBranch",
        function()
          return " "
        end,
      },
      condition = function()
        return condition.buffer_not_empty and condition.check_git_workspace
      end,
      highlight = { c.white0, c.black3 },
    },
  }
  -- File info
  gls.right[8] = {
    FileIcon = {
      provider = "FileIcon",
      condition = condition.buffer_not_empty,
      highlight = {
        glpf.get_file_icon_color,
        c.black3,
      },
    },
  }
  gls.right[9] = {
    FileName = {
      provider = { "FileName", "FileSize" },
      condition = condition.buffer_not_empty,
      highlight = { c.white0, c.black3 },
    },
  }
  -- Line Info
  gls.right[10] = {
    LineInfoLeftCap = {
      provider = function()
        return left_cap
      end,
      highlight = { c.blue1, c.black3, "bold" },
    },
  }
  gls.right[11] = {
    LineColumn = {
      provider = function()
        local line = vim.fn.line(".")
        local column = vim.fn.col(".")
        return line .. ":" .. column
      end,
      highlight = { c.black0, c.blue1 },
    },
  }
  gls.right[12] = {
    LineInfoSpacer = {
      provider = function()
        return " "
      end,
      highlight = { c.black0, c.blue1 },
    },
  }
  gls.right[13] = {
    LinePercent = {
      provider = function()
        local current_line = vim.fn.line(".")
        local total_line = vim.fn.line("$")
        if current_line == 1 then
          return "Top"
        elseif current_line == vim.fn.line("$") then
          return "Bot"
        end
        local result, _ = math.modf((current_line / total_line) * 100)
        return result .. "%"
      end,
      highlight = { c.black0, c.blue1 },
    },
  }
  gls.right[14] = {
    LineInfoRightCap = {
      provider = function()
        return right_cap
      end,
      highlight = { c.blue1, c.black0, "bold" },
    },
  }

  -- Short line status line
  -- Left side
  gls.short_line_left[1] = {
    ShortLeftCap = {
      provider = function()
        return left_cap
      end,
      highlight = { c.black1, c.black0, "bold" },
    },
  }
  gls.short_line_left[2] = {
    ShortSpacer = {
      provider = function()
        return " "
      end,
      highlight = { c.white0, c.black1, "bold" },
    },
  }

  -- Right side
  gls.short_line_right[1] = {
    ShortRightCap = {
      provider = function()
        return right_cap
      end,
      condition = function()
        return not condition.buffer_not_empty()
      end,
      highlight = { c.black1, c.black0, "bold" },
    },
  }
  gls.short_line_right[2] = {
    ShortFileInfoLeftCap = {
      provider = function()
        return left_cap
      end,
      condition = condition.buffer_not_empty,
      highlight = { c.black3, c.black1, "bold" },
    },
  }
  -- File info
  gls.short_line_right[3] = {
    ShortFileIcon = {
      provider = "FileIcon",
      condition = condition.buffer_not_empty,
      highlight = {
        c.blue2,
        c.black3,
      },
    },
  }
  gls.short_line_right[4] = {
    ShortFileName = {
      provider = {
        "FileName",
        function()
          return glpf.get_file_size():sub(1, -2)
        end,
      },
      condition = condition.buffer_not_empty,
      highlight = { c.white0, c.black3 },
    },
  }
  gls.short_line_right[5] = {
    ShortFileInfoRightCap = {
      provider = function()
        return right_cap
      end,
      condition = condition.buffer_not_empty,
      highlight = { c.black3, c.black0, "bold" },
    },
  }
end

return M
