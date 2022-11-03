local keymap = vim.keymap
local wk = require("which-key")

local opts = { silent = true }

-- Tab
wk.register({
  ["<Tab>"] = { "Indent cursor" },
})

-- Navigate tabs
keymap.set({ "n", "i", "t" }, "<C-t>d", "<C-\\><C-n><Cmd>tabclose<Cr>", opts)
keymap.set(
  { "n", "i", "t" },
  "<C-t>n",
  "<C-\\><C-n><Cmd>BufferLineCycleNext<Cr>",
  opts
)
keymap.set(
  { "n", "i", "t" },
  "<C-t>p",
  "<C-\\><C-n><Cmd>BufferLineCyclePrev<Cr>",
  opts
)
keymap.set({ "n", "i", "t" }, "<C-t>t", "<C-\\><C-n><Cmd>tabnew<Cr>", opts)
wk.register({
  ["<C-t>"] = {
    name = "+tabs",
    d = { "Close tab" },
    n = { "Next tab" },
    p = { "Previous tab" },
    t = { "Create new tab" },
  },
})

-- Exit the terminal
keymap.set({ "t" }, "<C-x>", "<C-\\><C-n>", opts)
wk.register({
  ["<C-x>"] = { "Exit insert mode" },
})

-- Move visual lines
keymap.set({ "n", "v" }, "j", "gj", opts)
keymap.set({ "n", "v" }, "k", "gk", opts)

-- The cursor should stay in the expected place
keymap.set({ "n", "v" }, "n", "nzzzv", opts)
keymap.set({ "n", "v" }, "N", "Nzzzv", opts)
keymap.set("n", "J", "mzJ`z", opts)
keymap.set("n", "K", "mzkJ`z", opts)
wk.register({
  n = { "Next search result" },
  N = { "Previous search result" },
  J = { "Merge with next line" },
})

-- Add the expected behaviour of Y
keymap.set("n", "Y", "y$", opts)
wk.register({
  Y = { "Yank until end of line" },
})

-- Enter new line without automatically inserting comment leaders
keymap.set("i", "<C-Cr>", "<Cr><Esc>0DI")

-- Add undo breakpoints
keymap.set("i", ",", ",<C-g>u", opts)
keymap.set("i", ".", ".<C-g>u", opts)
keymap.set("i", ";", ";<C-g>u", opts)

-- Clear searches with <Esc>
keymap.set("n", "<Esc>", "<Cmd>noh<Cr>", opts)

-- Move lines
keymap.set("n", "<M-J>", "<Cmd>m .+1<Cr>==", opts)
keymap.set("n", "<M-K>", "<Cmd>m .-2<Cr>==", opts)
keymap.set("v", "<M-J>", "<Cmd>m '>+1<Cr>gv=gv", opts)
keymap.set("v", "<M-K>", "<Cmd>m '<-2<Cr>gv=gv", opts)
keymap.set("i", "<M-J>", "<Esc><Cmd>m .+1<Cr>==gi", opts)
keymap.set("i", "<M-K>", "<Esc><Cmd>m .-2<Cr>==gi", opts)
wk.register({
  ["<M-J>"] = { "Move line down" },
  ["<M-K>"] = { "Move line up" },
})

-- Easier window resizing
keymap.set({ "n", "i" }, "<M-h>", "<Cmd>vertical resize -2<Cr>", opts)
keymap.set({ "n", "i" }, "<M-j>", "<Cmd>resize +2<Cr>", opts)
keymap.set({ "n", "i" }, "<M-k>", "<Cmd>resize -2<Cr>", opts)
keymap.set({ "n", "i" }, "<M-l>", "<Cmd>vertical resize +2<Cr>", opts)
keymap.set("t", "<M-h>", "<C-\\><C-n><Cmd>vertical resize -2<Cr>i", opts)
keymap.set("t", "<M-j>", "<C-\\><C-n><Cmd>resize +2<Cr>i", opts)
keymap.set("t", "<M-k>", "<C-\\><C-n><Cmd>resize -2<Cr>i", opts)
keymap.set("t", "<M-l>", "<C-\\><C-n><Cmd>vertical resize +2<Cr>i", opts)
wk.register({
  ["<M-h>"] = { "Horizontally decrease window size" },
  ["<M-j>"] = { "Vertically increase window size" },
  ["<M-k>"] = { "Vertically decrease window size" },
  ["<M-l>"] = { "Horizontally increase window size" },
})

-- Keep the selection when indenting
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Evaluate a code section
keymap.set("v", "<Leader>e", function()
  require("util.evaluate").section()
end, opts)

-- Harpoon
keymap.set({ "n", "i", "t" }, "<M-1>", function()
  require("harpoon.ui").nav_file(1)
end, opts)
keymap.set({ "n", "i", "t" }, "<M-2>", function()
  require("harpoon.ui").nav_file(2)
end, opts)
keymap.set({ "n", "i", "t" }, "<M-3>", function()
  require("harpoon.ui").nav_file(3)
end, opts)
keymap.set({ "n", "i", "t" }, "<M-4>", function()
  require("harpoon.ui").nav_file(4)
end, opts)
wk.register({
  ["<M-1>"] = { "Jump to first marked file" },
  ["<M-2>"] = { "Jump to second marked file" },
  ["<M-3>"] = { "Jump to third marked file" },
  ["<M-4>"] = { "Jump to fourth marked file" },
})

-- Luasnip
keymap.set({ "n", "i" }, "<C-Tab>", function()
  local ls = require("luasnip")
  if ls.choice_active() then
    ls.change_choice(1)
  else
  end
end, opts)
keymap.set({ "n", "i" }, "<C-e>", function()
  local ls = require("luasnip")
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, opts)
wk.register({
  ["<C-Tab>"] = { "Switch between choices" },
  ["<C-e>"] = { "Expand or jump in snippets" },
})

-- Navigator
keymap.set({ "n", "i", "v", "t" }, "<C-h>", function()
  require("Navigator").left()
end, opts)
keymap.set({ "n", "i", "v", "t" }, "<C-j>", function()
  require("Navigator").down()
end, opts)
keymap.set({ "n", "i", "v", "t" }, "<C-k>", function()
  require("Navigator").up()
end, opts)
keymap.set({ "n", "i", "v", "t" }, "<C-l>", function()
  require("Navigator").right()
end, opts)
wk.register({
  ["<C-h>"] = { "Activate left window" },
  ["<C-j>"] = { "Activate lower window" },
  ["<C-k>"] = { "Activate upper window" },
  ["<C-l>"] = { "Activate right window" },
})

-- <C-g>
wk.register({
  ["<C-g>"] = {
    name = "+goto/get",
    n = {
      name = "+next",
      c = {
        "Go to the beginning of the next class",
      }, -- Defined in nvim-treesitter.lua
      C = {
        "Go to the end of the next class ",
      }, -- Defined in nvim-treesitter.lua
      f = {
        "Go to the beginning of the next function",
      }, -- Defined in nvim-treesitter.lua
      F = {
        "Go to the end of the next function",
      }, -- Defined in nvim-treesitter.lua
      t = {
        "<Cmd>tn<Cr>",
        "Go to the next matching tag",
      },
    },
    p = {
      name = "+previous",
      c = {
        "Go to the beginning of the previous class",
      }, -- Defined in nvim-treesitter.lua
      C = {
        "Go to the end of the previous class ",
      }, -- Defined in nvim-treesitter.lua
      f = {
        "Go to the beginning of the previous function",
      }, -- Defined in nvim-treesitter.lua
      F = {
        "Go to the end of the previous function",
      }, -- Defined in nvim-treesitter.lua
      t = {
        "<Cmd>tN<Cr>",
        "Go to the previous matching tag",
      },
    },
  },
})

-- C-s
wk.register({
  ["<C-s>"] = {
    name = "+special/specific",
  },
})

-- Leader
wk.register({
  ["<Leader>"] = {
    a = {
      name = "+action",
      g = {
        name = "+generate",
        c = {
          function()
            require("neogen").generate({})
          end,
          "Generate documentation",
        },
      },
      s = { "Swap with next parameter" }, -- Defined in nvim-treesitter.lua
      S = { "Swap with previous parameter" }, -- Defined in nvim-treesitter.lua
    },
    b = {
      name = "+buffer",
      b = {
        function()
          require("telescope.builtin").buffers()
        end,
        "Show buffers",
      },
      d = { "<Cmd>bdelete %<Cr><Cmd>bd<Space>", "Delete buffer" },
      n = { "<Cmd>pnext<Cr>", "Next buffer" },
      p = { "<Cmd>bprevious<Cr>", "Previous buffer" },
    },
    e = {
      name = "+evaluate",
      b = {
        function()
          require("util.evaluate").buffer()
        end,
        "Evaluate the current buffer",
      },
      c = {
        function()
          require("util.evaluate").config()
        end,
        "Evaluate config",
      },
      e = {
        function()
          require("util.evaluate").line()
        end,
        "Evaluate the current line",
      },
    },
    d = {
      name = "+debugger",
      b = {
        name = "+breakpoint",
        b = {
          function()
            require("dap").toggle_breakpoint()
          end,
          "Toggle breakpoint",
        },
        g = {
          function()
            require("dapui").toggle({})
          end,
          "Toggle GUI",
        },
        l = {
          function()
            require("dap").set_breakpoint(
              nil,
              nil,
              vim.fn.input("Log point message: ")
            )
          end,
          "Log breakpoint",
        },
      },
      r = {
        function()
          require("dap").repl.toggle()
        end,
        "Toggle REPL",
      },
    },
    f = {
      name = "+file",
      n = { "<Cmd>enew<Cr>", "New file" },
      b = {
        function()
          require("telescope").extensions.file_browser.file_browser({
            hidden = true,
          })
        end,
        "File browser",
      },
      f = {
        function()
          require("telescope.builtin").find_files()
        end,
        "Find file",
      },
      g = {
        function()
          require("telescope.builtin").git_files()
        end,
        "Git files",
      },
      r = {
        function()
          require("telescope.builtin").oldfiles()
        end,
        "Recent files",
      },
    },
    g = {
      name = "+git",
      b = {
        function()
          require("telescope.builtin").git_branches()
        end,
        "Branches",
      },
      c = {
        function()
          require("telescope.builtin").git_commits()
        end,
        "Commits",
      },
      g = {
        function()
          require("neogit").open({ kind = "vsplit" })
        end,
        "Neogit",
      },
      i = {
        name = "+issue",
        l = {
          "<Cmd>Octo issue list<Cr>",
          "List issues",
        },
        n = {
          "<Cmd>Octo issue create<Cr>",
          "Create new issue",
        },
      },
      l = {
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local lazygit = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            float_opts = {
              border = "single",
            },
            hidden = true,
          })
          lazygit:toggle()
        end,
        "Toggle lazygit",
      },
      p = {
        name = "+pull request",
        l = {
          "<Cmd>Octo pr list<Cr>",
          "List PRs",
        },
      },
      s = {
        function()
          require("telescope.builtin").git_status()
        end,
        "Status",
      },
    },
    h = {
      name = "+help",
      a = {
        function()
          require("telescope.builtin").autocommands()
        end,
        "Auto commands",
      },
      c = {
        function()
          require("telescope.builtin").commands()
        end,
        "Commands",
      },
      f = {
        function()
          require("telescope.builtin").filetypes()
        end,
        "File types",
      },
      h = {
        function()
          require("telescope.builtin").help_tags()
        end,
        "Help pages",
      },
      k = {
        function()
          require("telescope.builtin").keymaps()
        end,
        "Keymaps",
      },
      l = {
        "<Cmd>TSHighlightCapturesUnderCursor<Cr>",
        "Highlight group under cursor",
      },
      m = {
        function()
          require("telescope.builtin").man_pages()
        end,
        "Man pages",
      },
      p = {
        name = "+packer",
        c = { "<Cmd>PackerCompile<Cr>", "Compile" },
        i = { "<Cmd>PackerInstall<Cr>", "Install" },
        p = { "<Cmd>PackerSync<Cr>", "Sync" },
        s = { "<Cmd>PackerStatus<Cr>", "Status" },
      },
      o = {
        function()
          require("telescope.builtin").vim_options()
        end,
        "Options",
      },
      s = {
        function()
          require("telescope.builtin").highlights()
        end,
        "Highlight groups",
      },
      t = {
        function()
          require("telescope.builtin").builtin()
        end,
        "Telescope",
      },
    },
    n = {
      name = "+neorg",
      n = { "<Cmd>Neorg news all<Cr>", "View news" },
      w = {
        name = "+workspace",
        b = { "<Cmd>Neorg workspace bible<Cr>", "Bible" },
        g = { "<Cmd>Neorg workspace gtd<Cr>", "GTD" },
        n = { "<Cmd>Neorg workspace notes<Cr>", "Notes" },
        s = { "<Cmd>Neorg workspace school<Cr>", "School" },
      },
    },
    o = {
      name = "+open",
      t = {
        name = "+terminal",
        f = {
          function()
            local Terminal = require("toggleterm.terminal").Terminal
            local floatterm = Terminal:new({
              direction = "float",
              float_opts = {
                border = "single",
              },
              hidden = true,
            })
            floatterm:toggle()
          end,
          "Open a floating terminal",
        },
        t = {
          function()
            local Terminal = require("toggleterm.terminal").Terminal
            local tabterm = Terminal:new({
              direction = "tab",
              hidden = true,
            })
            tabterm:toggle()
          end,
          "Open a terminal tab",
        },
        v = {
          function()
            local Terminal = require("toggleterm.terminal").Terminal
            local vertterm = Terminal:new({
              direction = "vertical",
              hidden = true,
            })
            vertterm:toggle()
          end,
          "Open a terminal in a vertical split",
        },
        x = {
          function()
            local Terminal = require("toggleterm.terminal").Terminal
            local horizterm = Terminal:new({
              direction = "horizontal",
              hidden = true,
            })
            horizterm:toggle()
          end,
          "Open a terminal in a horizontal split",
        },
      },
    },
    p = {
      name = "+project",
      p = {
        function()
          require("telescope").extensions.project.project({})
        end,
        "Open Projects",
      },
    },
    t = {
      name = "+toggle",
      s = { "<Cmd>setlocal spell!<Cr>", "Spell check" },
      v = {
        function()
          local venn_enabled = vim.inspect(vim.b.venn_enabled)
          if venn_enabled == "nil" then
            vim.b.venn_enabled = true
            vim.opt.virtualedit = "all"
            -- draw a line on HJKL keystokes
            vim.keymap.set(
              "n",
              "J",
              "<C-v>j<Cmd>VBox<Cr>",
              { noremap = true, buffer = 0 }
            )
            vim.keymap.set(
              "n",
              "K",
              "<C-v>k<Cmd>VBox<Cr>",
              { noremap = true, buffer = 0 }
            )
            vim.keymap.set(
              "n",
              "L",
              "<C-v>l<Cmd>VBox<Cr>",
              { noremap = true, buffer = 0 }
            )
            vim.keymap.set(
              "n",
              "H",
              "<C-v>h<Cmd>VBox<Cr>",
              { noremap = true, buffer = 0 }
            )
            -- draw a box by pressing "f" with visual selection
            vim.keymap.set(
              "v",
              "f",
              "<Cmd>VBox<Cr>",
              { noremap = true, buffer = 0 }
            )
          else
            -- Remove kepmaps
            vim.keymap.del("n", "J", { noremap = true, buffer = 0 })
            vim.keymap.del("n", "K", { noremap = true, buffer = 0 })
            vim.keymap.del("n", "L", { noremap = true, buffer = 0 })
            vim.keymap.del("n", "H", { noremap = true, buffer = 0 })
            vim.keymap.del("v", "f", { noremap = true, buffer = 0 })
            vim.opt.virtualedit = nil
            vim.b.venn_enabled = nil
          end
        end,
        "Toggle venn",
      },
      z = {
        function()
          require("zen-mode").toggle()
        end,
        "Toggle zen mode",
      },
    },
    s = {
      name = "+search",
      g = {
        function()
          require("telescope.builtin").live_grep()
        end,
        "Grep",
      },
      b = {
        function()
          require("telescope.builtin").current_buffer_fuzzy_find()
        end,
        "Buffer",
      },
      h = {
        function()
          require("telescope.builtin").command_history()
        end,
        "Command history",
      },
      m = {
        function()
          require("telescope.builtin").marks()
        end,
        "Marks",
      },
      s = {
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
            },
          })
        end,
        "Symbols",
      },
    },
    w = {
      name = "+workspace",
      h = {
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        "Toggle harpoon menu",
      },
      l = {
        function()
          require("persistence").load({ last = true })
        end,
        "Restore last",
      },
      m = {
        function()
          require("harpoon.mark").add_file()
        end,
        "Add file to harpoon list",
      },
      s = {
        name = "+session",
        s = {
          function()
            require("persistence").load()
          end,
          "Restore",
        },
        q = {
          function()
            require("persistence").stop()
          end,
          "Stop",
        },
      },
      x = {
        name = "+errors",
        x = { "<Cmd>TroubleToggle<Cr>", "Trouble" },
        w = { "<Cmd>TroubleWorkspaceToggle<Cr>", "Workspace Trouble" },
        d = { "<Cmd>TroubleDocumentToggle<Cr>", "Document Trouble" },
        t = { "<Cmd>TodoTrouble<Cr>", "Todo Trouble" },
        T = { "<Cmd>TodoTelescope<Cr>", "Todo Telescope" },
        l = { "<Cmd>lopen<Cr>", "Open Location List" },
        q = { "<Cmd>copen<Cr>", "Open Quickfix List" },
      },
    },
  },
})
