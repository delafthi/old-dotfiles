local M = {}

function M.config()
  -- Call the setup function
  require("neorg").setup({
    load = {
      ["core.defaults"] = {},
      ["core.keybinds"] = {
        config = {
          default_keybinds = false,
          leader = "<Leader>",
          hook = function(keybinds)
            local leader = keybinds.leader
            keybinds.map_event_to_mode("norg", {
              n = {

                -- Keys for managing TODO items and setting their states
                { "<C-g>tu", "core.norg.qol.todo_items.todo.task_undone" },
                { "<C-g>tp", "core.norg.qol.todo_items.todo.task_pending" },
                { "<C-g>td", "core.norg.qol.todo_items.todo.task_done" },
                { "<C-g>th", "core.norg.qol.todo_items.todo.task_on_hold" },
                { "<C-g>tc", "core.norg.qol.todo_items.todo.task_cancelled" },
                { "<C-g>tr", "core.norg.qol.todo_items.todo.task_recurring" },
                { "<C-g>ti", "core.norg.qol.todo_items.todo.task_important" },
                { "<C-Space>", "core.norg.qol.todo_items.todo.task_cycle" },

                -- Keys for managing GTD
                { "<C-g>tC", "core.gtd.base.capture" },
                { "<C-g>tv", "core.gtd.base.views" },
                { "<C-g>te", "core.gtd.base.edit" },

                -- Keys for managing notes
                { leader .. "fn", "core.norg.dirman.new.note" },
                { "<C-g>Tg", "core.norg.qol.toc.generate_toc" },
                { "<C-g>Td", "core.norg.qol.toc.display_toc" },

                { "<CR>", "core.norg.esupports.hop.hop-link" },
                { "<M-CR>", "core.norg.esupports.hop.hop-link", "vsplit" },

                { "<M-K>", "core.norg.manoeuvre.item_up" },
                { "<M-J>", "core.norg.manoeuvre.item_down" },

                {
                  leader .. "sl",
                  "core.integrations.telescope.find_linkable",
                },
                { "<C-g>l", "core.integrations.telescope.insert_link" },
                { "<C-g>f", "core.integrations.telescope.insert_file_link" },
              },
              o = {
                { "ah", "core.norg.manoeuvre.textobject.around-heading" },
                { "ih", "core.norg.manoeuvre.textobject.inner-heading" },
                { "at", "core.norg.manoeuvre.textobject.around-tag" },
                { "it", "core.norg.manoeuvre.textobject.inner-tag" },
                { "al", "core.norg.manoeuvre.textobject.around-whole-list" },
              },
              i = {
                { "<C-g>l", "core.integrations.telescope.insert_link" },
                { "<C-g>f", "core.integrations.telescope.insert_file_link" },
              },
            }, { silent = true, noremap = true })

            -- Map the below keys only when traverse-heading mode is active
            keybinds.map_event_to_mode("traverse-heading", {
              n = {
                -- Rebind j and k to move between headings in traverse-heading mode
                { "j", "core.integrations.treesitter.next.heading" },
                { "k", "core.integrations.treesitter.previous.heading" },
              },
            }, {
              silent = true,
              noremap = true,
            })

            keybinds.map_event_to_mode("toc-split", {
              n = {
                { "<CR>", "core.norg.qol.toc.hop-toc-link" },

                -- Keys for closing the current display
                { "q", "core.norg.qol.toc.close" },
                { "<Esc>", "core.norg.qol.toc.close" },
              },
            }, {
              silent = true,
              noremap = true,
              nowait = true,
            })

            -- Map the below keys on gtd displays
            keybinds.map_event_to_mode("gtd-displays", {
              n = {
                { "<CR>", "core.gtd.ui.goto_task" },

                -- Keys for closing the current display
                { "q", "core.gtd.ui.close" },
                { "<Esc>", "core.gtd.ui.close" },

                { "e", "core.gtd.ui.edit_task" },
                { "<Tab>", "core.gtd.ui.details" },
              },
            }, {
              silent = true,
              noremap = true,
              nowait = true,
            })

            -- Map the below keys on presenter mode
            keybinds.map_event_to_mode("presenter", {
              n = {
                { "<CR>", "core.presenter.next_page" },
                { "j", "core.presenter.next_page" },
                { "k", "core.presenter.previous_page" },

                -- Keys for closing the current display
                { "q", "core.presenter.close" },
                { "<Esc>", "core.presenter.close" },
              },
            }, {
              silent = true,
              noremap = true,
              nowait = true,
            })
            -- Apply the below keys to all modes
            keybinds.map_to_mode("all", {
              n = {
                { leader .. "mn", ":Neorg mode norg<CR>" },
                { leader .. "mh", ":Neorg mode traverse-heading<CR>" },
              },
            }, {
              silent = true,
              noremap = true,
            })
          end,
        },
      },
      ["core.gtd.base"] = {
        config = {
          workspace = "gtd",
        },
      },
      ["core.presenter"] = {
        config = {
          slide_count = { position = "bottom" },
          zen_mode = "zen-mode",
        },
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
