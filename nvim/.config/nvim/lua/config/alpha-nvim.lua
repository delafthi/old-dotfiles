local M = {}

function M.config()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")
  -- Set header
  dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
  }

  -- Set menu
  dashboard.section.buttons.val = {
    dashboard.button("SPC f n", "  > New File", ":enew<Cr>", {}),
    dashboard.button(
      "SPC w s l",
      "  > Restore last session",
      ":lua require('persistence').load({last = true})<Cr>",
      {}
    ),
    dashboard.button(
      "SPC f r",
      "  > Recently opened files",
      ":Telescope oldfiles<Cr>",
      {}
    ),
    dashboard.button(
      "SPC f f",
      "  > Find File",
      ":Telescope find_files<Cr>",
      {}
    ),
    dashboard.button(
      "SPC f b",
      "  > File Browser",
      ":Telescope find_browser<Cr>",
      {}
    ),
    dashboard.button(
      "SPC s g",
      "  > Find Word",
      ":Telescope live_grep<Cr>",
      {}
    ),
    dashboard.button("SPC f n", "  > New File", ":enew<Cr>", {}),
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
