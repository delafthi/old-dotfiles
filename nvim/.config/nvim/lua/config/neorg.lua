local M = {}

function M.config()
  -- Call the setup function
  require("neorg").setup({
    load = {
      ["core.defaults"] = {},
      ["core.keybinds"] = {
        config = { default_keybinds = false },
      },
      ["core.gtd.base"] = {
        config = {
          workspace = "gtd",
        },
      },
      ["core.presenter"] = {
        config = { slide_count = { position = "bottom" } },
      },
      ["core.norg.concealer"] = {
        config = { icon_preset = "diamond" },
      },
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            default = vim.fn.getcwd(),
            notes = "~/Notes",
            school = "~/Notes/school",
            projects = "~/Notes/projects",
            gtd = "~/Notes/gtd",
          },
          autochdir = false,
          index = "index.norg",
          last_workspace = vim.fn.stdpath("cache")
            .. "/neorg_last_workspace.txt",
        },
      },
    },
    ["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
    ["core.integrations.telescope"] = {},
  })
end

return M
