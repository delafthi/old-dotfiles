local M = {}

function M.config()
  -- Call the setup function
  require("neorg").setup({
    load = {
      ["core.defaults"] = {},
      ["core.keybinds"] = {
        config = { default_keybinds = true },
      },
      ["core.gtd.base"] = {
        config = {
          workspace = "gtd",
        },
      },
      ["core.norg.concealer"] = {
        config = { icon_preset = "diamond" },
      },
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            default = vim.fn.getcwd(),
            work = "~/Projects/work/notes",
            notes = "~/Notes",
            school = "~/Notes/school",
            gtd = "~/Notes/gtd",
          },
          autochdir = false,
          index = "index.norg",
          last_workspace = vim.fn.stdpath("cache")
            .. "/neorg_last_workspace.txt",
        },
      },
    },
    ["core.presenter"] = {
      config = { slide_count = { position = "bottom" } },
    },
    ["core.integrations.telescope"] = {},
    ["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
  })
end

return M
