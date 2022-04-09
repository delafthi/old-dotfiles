local M = {}

function M.config()
  local signs = require("config.nvim-lspconfig").signs

  signs = {
    error = signs.Error,
    warning = signs.Warn,
    info = signs.Info,
    hint = signs.Hint,
  }

  local severities = {
    "error",
    "warning",
    -- "info",
    -- "hint",
  }

  require("bufferline").setup({
    options = {
      mode = "tabs", -- set to "tabs" to only show tabpages instead
      numbers = "none", -- buffer_id at index 1, ordinal at index 2
      close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
      middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
      -- NOTE: this plugin is designed with this icon in mind,
      -- and so changing this is NOT recommended, this is intended
      -- as an escape hatch for people who cannot bear it for whatever reason
      indicator_icon = "▎",
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 18,
      max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
      tab_size = 18,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(_, _, diag)
        local s = {}
        for _, severity in ipairs(severities) do
          if diag[severity] then
            table.insert(s, signs[severity] .. diag[severity])
          end
        end
        return table.concat(s, " ")
      end,
      color_icons = true, -- whether or not to add the filetype icon highlights
      show_buffer_icons = true, -- disable filetype icons for buffers
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = true,
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      separator_style = "thin",
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      sort_by = "id",
    },
    highlights = {
      fill = {
        guifg = {
          attribute = "fg",
          highlight = "TabLineFill",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineFill",
        },
      },
      background = {
        guifg = {
          attribute = "fg",
          highlight = "TabLine",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      tab = {
        guifg = {
          attribute = "fg",
          highlight = "TabLine",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      tab_selected = {
        guifg = {
          attribute = "fg",
          highlight = "TabLineSel",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
      },
      tab_close = {
        guifg = {
          attribute = "fg",
          highlight = "TabLineFill",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineFill",
        },
      },
      close_button = {
        guifg = {
          attribute = "fg",
          highlight = "TabLine",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      close_button_visible = {
        guifg = {
          attribute = "fg",
          highlight = "TabLine",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      close_button_selected = {
        guifg = {
          attribute = "fg",
          highlight = "TabLineSel",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
      },
      buffer_visible = {
        guifg = {
          attribute = "fg",
          highlight = "TabLine",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      buffer_selected = {
        guifg = {
          attribute = "fg",
          highlight = "TabLineSel",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
      },
      diagnostic = {
        guifg = {
          attribute = "fg",
          highlight = "TabLine",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      diagnostic_visible = {
        guifg = {
          attribute = "fg",
          highlight = "TabLine",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      diagnostic_selected = {
        guifg = {
          attribute = "fg",
          highlight = "TabLineSel",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
      },
      info = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticInfo",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      info_visible = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticInfo",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      info_selected = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticInfo",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
      },
      info_diagnostic = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticInfo",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      info_diagnostic_visible = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticInfo",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      info_diagnostic_selected = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticInfo",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
      },
      warning = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticWarn",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      warning_visible = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticWarn",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      warning_selected = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticWarn",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
      },
      warning_diagnostic = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticWarn",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      warning_diagnostic_visible = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticWarn",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      warning_diagnostic_selected = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticWarn",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
      },
      error = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticError",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      error_visible = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticError",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      error_selected = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticError",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
      },
      error_diagnostic = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticError",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      error_diagnostic_visible = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticError",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      error_diagnostic_selected = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticError",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
      },
      modified = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticWarn",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      modified_visible = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticWarn",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      modified_selected = {
        guifg = {
          attribute = "fg",
          highlight = "DiagnosticWarn",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
      },
      duplicate = {
        guifg = {
          attribute = "fg",
          highlight = "TabLineDuplicate",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      duplicate_visible = {
        guifg = {
          attribute = "fg",
          highlight = "TabLineDuplicate",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      duplicate_selected = {
        guifg = {
          attribute = "fg",
          highlight = "TabLineDuplicate",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
      },
      separator = {
        guifg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      separator_visible = {
        guifg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      separator_selected = {
        guifg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
      },
      indicator_selected = {
        guifg = {
          attribute = "fg",
          highlight = "TabLineSelector",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
      },
      pick = {
        guifg = {
          attribute = "fg",
          highlight = "TabLine",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      pick_visible = {
        guifg = {
          attribute = "fg",
          highlight = "TabLine",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLine",
        },
      },
      pick_selected = {
        guifg = {
          attribute = "fg",
          highlight = "TabLineSel",
        },
        guibg = {
          attribute = "bg",
          highlight = "TabLineSel",
        },
      },
    },
  })
end

return M
