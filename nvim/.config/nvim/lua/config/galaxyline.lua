local M = {}

function M.config()
  local gl = require('galaxyline')
  local gls = gl.section
  gl.short_line_list = {'defx', 'packager', 'vista', 'NvimTree'}

  local colors = {
    red = '#e06c75',
    green = '#98c379',
    orange = '#e59F70',
    yellow = '#e5c07b',
    blue = '#61afef',
    purple = '#c678dd',
    cyan = '#56b6c2',

    red_dark = '#be646a',
    green_dark = '#7e9d69',
    orange_dark = '#c08768',
    yellow_dark = '#bd9e6f',
    blue_dark = '#5f96c9',
    purple_dark = '#a86cbb',
    cyan_dark = '#51969f',

    red_light = '#e8838c',
    green_light = '#a6d18c',
    orange_light = '#ecb07e',
    yellow_light = '#eccd84',
    blue_light = '#75c2f3',
    purple_light = '#d38de6',
    cyan_light = '#69c7d1',

    black = '#282c34',
    white = '#dcdfe4',

    mono1 = '#313640',
    mono2 = '#4b5263',
    mono3 = '#5c6370',
    mono4 = '#919baa',
    mono5 = '#abb2bf',
  }

  -- Local helper functions
  local buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end

  local mode_color = function()
    local mode_colors = {
      n = colors.green,
      i = colors.blue,
      c = colors.red,
      t = colors.orange,
      v = colors.yellow,
      V = colors.yellow,
      [''] = colors.yellow,
      R = colors.purple,
      s = colors.red,
      S = colors.red,
      [''] = colors.red,
    }

    local mode_color = mode_colors[vim.fn.mode()]
    if mode_color ~= nil then
      return mode_color
    else
      return colors.red
    end
  end

  -- Left side
  gls.left[1] = {
    ViMode = {
      provider = function()
        local aliases = {
          n = 'NORMAL',
          i = 'INSERT',
          c = 'COMMAND',
          t = 'TERMINAL',
          v = 'VISUAL',
          V = 'V-LINE',
          [''] = 'V-BLOCK',
          R = 'REPLACE',
          s = 'SELECT',
          S = 'S-LINE',
          [''] = 'X-BLOCK',
        }
        vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color())
        local alias = aliases[vim.fn.mode()]
        if alias ~= nil then
          return '  ' .. alias .. ' '
        else
          return '  ' .. vim.fn.mode() .. ' '
        end
      end,
      highlight = {colors.black, colors.mono2, 'bold'},
    }
  }
  gls.left[2] = {
    Space = {
      provider = function() return ' ' end,
      condition = buffer_not_empty,
      highlight = {colors.mono2, colors.mono2},
    }
  }
  gls.left[3] = {
    FileIcon = {
      provider = 'FileIcon',
      condition = buffer_not_empty,
      highlight = {
          require('galaxyline.provider_fileinfo').get_file_icon_color,
          colors.mono2
      },
    }
  }
  gls.left[4] = {
    FileName = {
      provider = {'FileName', 'FileSize'},
      condition = buffer_not_empty,
      highlight = {colors.white, colors.mono2},
      separator = "",
      separator_highlight = {colors.mono2, colors.mono1},
    }
  }
  gls.left[5] = {
    DiagnosticError = {
      provider = 'DiagnosticError',
      icon = '  ',
      highlight = {colors.red, colors.mono1},
    }
  }
  gls.left[6] = {
    DiagnosticWarn = {
      provider = 'DiagnosticWarn',
      icon = '  ',
      highlight = {colors.yellow, colors.mono1},
    }
  }
  gls.left[7] = {
    DiagnosticInfo = {
      provider = 'DiagnosticInfo',
      icon = '  ',
      highlight = {colors.blue, colors.mono1},
    }
  }

  -- Right side
  gls.right[1] = {
    GitIcon = {
      provider = function() return '  ' end,
      condition = function()
        return buffer_not_empty and require('galaxyline.condition').check_git_workspace()
      end,
      highlight = {colors.orange, colors.mono1},
    }
  }
  gls.right[2] = {
    GitBranch = {
      provider = {'GitBranch', function() return ' ' end},
      condition = buffer_not_empty,
      highlight = {colors.white, colors.mono1},
    }
  }
  gls.right[3] = {
    DiffAdd = {
      provider = 'DiffAdd',
      icon = '  ',
      highlight = {colors.green, colors.mono1},
    }
  }
  gls.right[4] = {
    DiffModified = {
      provider = 'DiffModified',
      icon = '  ',
      highlight = {colors.yellow, colors.mono1},
    }
  }
  gls.right[5] = {
    DiffRemove = {
      provider = 'DiffRemove',
      icon = '  ',
      highlight = {colors.red, colors.mono1},
    }
  }
  gls.right[6] = {
    PerCent = {
      provider = 'LinePercent',
      highlight = {colors.black, colors.blue},
      separator = '',
      separator_highlight = {colors.blue, colors.mono1},
    }
  }
end

return M
