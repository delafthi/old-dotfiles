local M = {}

function M.config()
  local gl_ok, gl = pcall(function()
    return require("galaxyline")
  end)

  local nord_ok, nord = pcall(function()
    return require("nord.colors")
  end)

  if not (gl_ok and nord_ok) then
    return
  end

  local glpf = require("galaxyline.provider_fileinfo")
  local condition = require("galaxyline.condition")

  local gls = gl.section

  -- Overwrite the statusline hls to prevent interference
  vim.cmd("highlight Statusline guibg=" .. nord.nord0)
  vim.cmd("highlight StatuslineNC guibg=" .. nord.nord0)

  -- Shorter statusline for these filetypes
  gl.short_line_list = { "packer", "dashboard" }

  -- Set some defaults
  local left_cap = ""
  local right_cap = ""

  -- Local helper functions
  local modes = {
    n = { "NORMAL", nord.nord14 },
    i = { "INSERT", nord.nord8 },
    c = { "COMMAND", nord.nord11 },
    t = { "TERMINAL", nord.nord12 },
    v = { "VISUAL", nord.nord13 },
    V = { "V-LINE", nord.nord13 },
    [""] = { "V-BLOCK", nord.nord13 },
    R = { "REPLACE", nord.nord15 },
    s = { "SELECT", nord.nord11 },
    S = { "S-LINE", nord.nord11 },
    [""] = { "X-BLOCK", nord.nord11 },
  }

  -- Left side
  ---------------------------------------------------------
  -- ViMode
  gls.left[1] = {
    ViModeLeftCap = {
      provider = function()
        local vim_mode = vim.fn.mode()
        local mode_style = modes[vim_mode]
        vim.api.nvim_command("hi GalaxyViModeLeftCap guifg=" .. mode_style[2])
        return left_cap
      end,
      highlight = { nord.nord2, nord.nord0, "bold" },
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
      highlight = { nord.nord0, nord.nord2, "bold" },
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
      highlight = { nord.nord2, nord.nord1, "bold" },
    },
  }
  -- Spacer
  gls.left[4] = {
    Space = {
      provider = function()
        return " "
      end,
      condition = condition.buffer_not_empty(),
      highlight = { nord.nord4, nord.nord1 },
    },
  }
  -- LSP Diagnostics
  gls.left[5] = {
    DiagnosticError = {
      provider = "DiagnosticError",
      icon = "  ",
      highlight = { nord.nord11, nord.nord1 },
    },
  }
  gls.left[6] = {
    DiagnosticWarn = {
      provider = "DiagnosticWarn",
      icon = "  ",
      highlight = { nord.nord14, nord.nord1 },
    },
  }
  gls.left[7] = {
    DiagnosticInfo = {
      provider = "DiagnosticInfo",
      icon = "  ",
      highlight = { nord.nord8, nord.nord1 },
    },
  }
  -- Middle
  ---------------------------------------------------------

  -- Right side
  ---------------------------------------------------------
  gls.right[1] = {
    FileInfoLeftCap = {
      provider = function()
        return left_cap
      end,
      highlight = { nord.nord3, nord.nord1, "bold" },
    },
  }
  -- Git diff
  gls.right[2] = {
    GitDiffAdd = {
      provider = "DiffAdd",
      icon = "  ",
      highlight = { nord.nord14, nord.nord3 },
    },
  }
  gls.right[3] = {
    GitDiffModified = {
      provider = "DiffModified",
      icon = "  ",
      highlight = { nord.nord15, nord.nord3 },
    },
  }
  gls.right[4] = {
    GitDiffRemove = {
      provider = "DiffRemove",
      icon = "  ",
      highlight = { nord.nord11, nord.nord3 },
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
      highlight = { nord.nord12, nord.nord3 },
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
        return condition.buffer_not_empty() and condition.check_git_workspace()
      end,
      highlight = { nord.nord4, nord.nord3 },
    },
  }
  -- File info
  gls.right[8] = {
    FileIcon = {
      provider = "FileIcon",
      highlight = {
        glpf.get_file_icon_color,
        nord.nord3,
      },
    },
  }
  gls.right[9] = {
    FileName = {
      provider = { "FileName", "FileSize" },
      condition = function()
        return condition.buffer_not_empty()
      end,
      highlight = { nord.nord4, nord.nord3 },
    },
  }
  -- Line Info
  gls.right[10] = {
    LineInfoLeftCap = {
      provider = function()
        return left_cap
      end,
      highlight = { nord.nord9, nord.nord3, "bold" },
    },
  }
  gls.right[11] = {
    LineColumn = {
      provider = function()
        local line = vim.fn.line(".")
        local column = vim.fn.col(".")
        return line .. ":" .. column
      end,
      highlight = { nord.nord0, nord.nord9 },
    },
  }
  gls.right[12] = {
    LineInfoSpacer = {
      provider = function()
        return " "
      end,
      highlight = { nord.nord0, nord.nord9 },
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
      highlight = { nord.nord0, nord.nord9 },
    },
  }
  gls.right[14] = {
    LineInfoRightCap = {
      provider = function()
        return right_cap
      end,
      highlight = { nord.nord9, nord.nord0, "bold" },
    },
  }

  ---------------------------------------------------------
  -- Short line status line
  ---------------------------------------------------------
  -- Left side
  ---------------------------------------------------------
  gls.short_line_left[1] = {
    ShortLeftCap = {
      provider = function()
        return left_cap
      end,
      highlight = { nord.nord1, nord.nord0, "bold" },
    },
  }
  gls.short_line_left[2] = {
    ShortSpacer = {
      provider = function()
        return " "
      end,
      highlight = { nord.nord4, nord.nord1, "bold" },
    },
  }

  -- Right side
  ---------------------------------------------------------
  gls.short_line_right[1] = {
    ShortFileInfoLeftCap = {
      provider = function()
        return left_cap
      end,
      highlight = { nord.nord3, nord.nord1, "bold" },
    },
  }
  -- File info
  gls.short_line_right[2] = {
    ShortFileIcon = {
      provider = "FileIcon",
      highlight = {
        nord.nord10,
        nord.nord3,
      },
    },
  }
  gls.short_line_right[3] = {
    ShortFileName = {
      provider = {
        "FileName",
        function()
          return glpf.get_file_size():sub(1, -2)
        end,
      },
      highlight = { nord.nord4, nord.nord3 },
    },
  }
  gls.short_line_right[4] = {
    ShortFileInfoRightCap = {
      provider = function()
        return right_cap
      end,
      highlight = { nord.nord3, nord.nord0, "bold" },
    },
  }
end

return M
