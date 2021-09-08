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

  -- Shorter statusline for these filetypes
  gl.short_line_list = { "packer", "dashboard" }

  -- Set some defaults
  local left_cap = ""
  local right_cap = ""

  -- Local helper functions
  local modes = {
    n = { "NORMAL", nord.nord14_gui },
    i = { "INSERT", nord.nord8_gui },
    c = { "COMMAND", nord.nord11_gui },
    t = { "TERMINAL", nord.nord12_gui },
    v = { "VISUAL", nord.nord13_gui },
    V = { "V-LINE", nord.nord13_gui },
    [""] = { "V-BLOCK", nord.nord13_gui },
    R = { "REPLACE", nord.nord15_gui },
    s = { "SELECT", nord.nord11_gui },
    S = { "S-LINE", nord.nord11_gui },
    [""] = { "X-BLOCK", nord.nord11_gui },
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
      highlight = { nord.nord2_gui, nord.nord0_gui, "bold" },
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
      highlight = { nord.nord0_gui, nord.nord2_gui, "bold" },
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
      highlight = { nord.nord2_gui, nord.nord1_gui, "bold" },
    },
  }
  -- Spacer
  gls.left[4] = {
    Space = {
      provider = function()
        return " "
      end,
      condition = condition.buffer_not_empty(),
      highlight = { nord.nord4_gui, nord.nord1_gui },
    },
  }
  -- LSP Diagnostics
  gls.left[5] = {
    DiagnosticError = {
      provider = "DiagnosticError",
      icon = "  ",
      highlight = { nord.nord11_gui, nord.nord1_gui },
    },
  }
  gls.left[6] = {
    DiagnosticWarn = {
      provider = "DiagnosticWarn",
      icon = "  ",
      highlight = { nord.nord14_gui, nord.nord1_gui },
    },
  }
  gls.left[7] = {
    DiagnosticInfo = {
      provider = "DiagnosticInfo",
      icon = "  ",
      highlight = { nord.nord8_gui, nord.nord1_gui },
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
      highlight = { nord.nord3_gui, nord.nord1_gui, "bold" },
    },
  }
  -- Git diff
  gls.right[2] = {
    GitDiffAdd = {
      provider = "DiffAdd",
      icon = "  ",
      highlight = { nord.nord14_gui, nord.nord3_gui },
    },
  }
  gls.right[3] = {
    GitDiffModified = {
      provider = "DiffModified",
      icon = "  ",
      highlight = { nord.nord15_gui, nord.nord3_gui },
    },
  }
  gls.right[4] = {
    GitDiffRemove = {
      provider = "DiffRemove",
      icon = "  ",
      highlight = { nord.nord11_gui, nord.nord3_gui },
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
      highlight = { nord.nord12_gui, nord.nord3_gui },
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
      highlight = { nord.nord4_gui, nord.nord3_gui },
    },
  }
  -- File info
  gls.right[8] = {
    FileIcon = {
      provider = "FileIcon",
      highlight = {
        glpf.get_file_icon_color,
        nord.nord3_gui,
      },
    },
  }
  gls.right[9] = {
    FileName = {
      provider = { "FileName", "FileSize" },
      condition = function()
        return condition.buffer_not_empty()
      end,
      highlight = { nord.nord4_gui, nord.nord3_gui },
    },
  }
  -- Line Info
  gls.right[10] = {
    LineInfoLeftCap = {
      provider = function()
        return left_cap
      end,
      highlight = { nord.nord9_gui, nord.nord3_gui, "bold" },
    },
  }
  gls.right[11] = {
    LineColumn = {
      provider = function()
        local line = vim.fn.line(".")
        local column = vim.fn.col(".")
        return line .. ":" .. column
      end,
      highlight = { nord.nord0_gui, nord.nord9_gui },
    },
  }
  gls.right[12] = {
    LineInfoSpacer = {
      provider = function()
        return " "
      end,
      highlight = { nord.nord0_gui, nord.nord9_gui },
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
      highlight = { nord.nord0_gui, nord.nord9_gui },
    },
  }
  gls.right[14] = {
    LineInfoRightCap = {
      provider = function()
        return right_cap
      end,
      highlight = { nord.nord9_gui, nord.nord0_gui, "bold" },
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
      highlight = { nord.nord1_gui, nord.nord0_gui, "bold" },
    },
  }
  gls.short_line_left[2] = {
    ShortSpacer = {
      provider = function()
        return " "
      end,
      highlight = { nord.nord4_gui, nord.nord1_gui, "bold" },
    },
  }

  -- Right side
  ---------------------------------------------------------
  gls.short_line_right[1] = {
    ShortFileInfoLeftCap = {
      provider = function()
        return left_cap
      end,
      highlight = { nord.nord3_gui, nord.nord1_gui, "bold" },
    },
  }
  -- File info
  gls.short_line_right[2] = {
    ShortFileIcon = {
      provider = "FileIcon",
      highlight = {
        nord.nord10_gui,
        nord.nord3_gui,
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
      highlight = { nord.nord4_gui, nord.nord3_gui },
    },
  }
  gls.short_line_right[4] = {
    ShortFileInfoRightCap = {
      provider = function()
        return right_cap
      end,
      highlight = { nord.nord3_gui, nord.nord0_gui, "bold" },
    },
  }
end

return M
