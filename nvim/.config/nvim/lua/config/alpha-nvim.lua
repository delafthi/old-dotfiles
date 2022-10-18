local M = {}

function M.config()
  local leader = "SPC"

  local function button(sc, txt, keybind, keybind_opts, opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    opts.position = opts.position or "center"
    opts.shortcut = opts.shortcut or sc
    opts.cursor = opts.cursor or 5
    opts.width = opts.width or 50
    opts.align_shortcut = opts.align_shortcut or "right"
    opts.hl_shortcut = opts.hl_shortcut or "Keyword"

    if keybind then
      keybind_opts = keybind_opts
        or { noremap = true, silent = true, nowait = true }
      opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
      local key = vim.api.nvim_replace_termcodes(
        keybind or sc_ .. "<Ignore>",
        true,
        false,
        true
      )
      vim.api.nvim_feedkeys(key, "tx", false)
    end

    return {
      type = "button",
      val = txt,
      on_press = on_press,
      opts = opts,
    }
  end

  local alpha = require("alpha")
  local dashboard = {
    config = {
      layout = {
        {
          type = "padding",
          val = 2,
        },
        {
          type = "text",
          val = {
            "                                                     ",
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
            "                                                     ",
          },
          opts = {
            position = "center",
            hl = "DashboardHeader",
          },
        },
        {
          type = "padding",
          val = 2,
        },
        {
          type = "group",
          val = {
            button(
              "SPC f n",
              "  > New File",
              ":enew<Cr>",
              {},
              { hl_shortcut = "DashboardShortCut" }
            ),
            button(
              "SPC w s l",
              "  > Restore last session",
              ":lua require('persistence').load({last = true})<Cr>",
              {},
              { hl_shortcut = "DashboardShortCut" }
            ),
            button(
              "SPC f r",
              "  > Recently opened files",
              ":Telescope oldfiles<Cr>",
              {},
              { hl_shortcut = "DashboardShortCut" }
            ),
            button(
              "SPC f f",
              "  > Find File",
              ":Telescope find_files<Cr>",
              {},
              { hl_shortcut = "DashboardShortCut" }
            ),
            button(
              "SPC f b",
              "  > File Browser",
              ":Telescope find_browser<Cr>",
              {},
              { hl_shortcut = "DashboardShortCut" }
            ),
            button(
              "SPC s g",
              "  > Find Word",
              ":Telescope live_grep<Cr>",
              {},
              { hl_shortcut = "DashboardShortCut" }
            ),
          },
          opts = {
            spacing = 1,
          },
        },
        {
          type = "text",
          val = "",
          opts = {
            position = "center",
            hl = "DashboardFooter",
          },
        },
      },
    },
    opts = {
      margin = 5,
    },
  }

  -- Disable folding on alpha buffer
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "alpha",
    command = "setlocal nofoldenable",
    group = vim.api.nvim_create_augroup("alpha", { clear = true }),
  })

  -- Send config to alpha
  alpha.setup(dashboard.config)
end

return M
