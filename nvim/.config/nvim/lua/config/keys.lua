local keymap = vim.keymap
local wk = require("which-key")

local opts = { silent = true }

-- Move visual lines
keymap.set({ "n", "v" }, "j", "gj", opts)
keymap.set({ "n", "v" }, "k", "gk", opts)

-- The cursor should stay in the expected place
keymap.set({ "n", "v" }, "n", "nzzzv", opts)
keymap.set({ "n", "v" }, "N", "Nzzzv", opts)
keymap.set("n", "J", "mzJ`z", opts)

-- Add the expected behaviour of Y
keymap.set("n", "Y", "y$", opts)

-- Add undo breakpoints
keymap.set("i", ",", ",<C-g>u", opts)
keymap.set("i", ".", ".<C-g>u", opts)
keymap.set("i", ";", ";<C-g>u", opts)

-- Clear searches with <Esc>
keymap.set("n", "<Esc>", ":noh<Cr>", opts)

-- Move lines
keymap.set("n", "<A-j>", ":m .+1<Cr>==", opts)
keymap.set("n", "<A-k>", ":m .-2<Cr>==", opts)
keymap.set("v", "<A-j>", ":m '>+1<Cr>gv=gv", opts)
keymap.set("v", "<A-k>", ":m '<-2<Cr>gv=gv", opts)
keymap.set("i", "<A-j>", "<Esc>:m .+1<Cr>==gi", opts)
keymap.set("i", "<A-k>", "<Esc>:m .-2<Cr>==gi", opts)

-- Easier window resizing
keymap.set({ "n", "i", "t" }, "<C-Left>", ":vertical resize -2<Cr>", opts)
keymap.set({ "n", "i", "t" }, "<C-Up>", ":resize +2<Cr>", opts)
keymap.set({ "n", "i", "t" }, "<C-Left>", ":resize -2<Cr>", opts)
keymap.set({ "n", "i", "t" }, "<C-Left>", ":vertical resize +2<Cr>", opts)

-- Keep the selection when indenting
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Jump to previous and next matches for the f and t search
keymap.set({ "n", "v" }, ";", "<Plug>Lightspeed_;_ft", opts)
keymap.set({ "n", "v" }, ",", "<Plug>Lightspeed_,_ft", opts)

-- Evaluate a code section
keymap.set("v", "<Leader>e", function()
  require("util.evaluate").section()
end, opts)

-- Harpoon
keymap.set({ "n", "i", "t" }, "<A-1>", function()
  require("harpoon.ui").nav_file(1)
end, opts)
keymap.set({ "n", "i", "t" }, "<A-2>", function()
  require("harpoon.ui").nav_file(2)
end, opts)
keymap.set({ "n", "i", "t" }, "<A-3>", function()
  require("harpoon.ui").nav_file(3)
end, opts)
keymap.set({ "n", "i", "t" }, "<A-4>", function()
  require("harpoon.ui").nav_file(4)
end, opts)

-- Luasnip
keymap.set({ "n", "i" }, "<C-Tab>", function()
  local ls = require("luasnip")
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, opts)
keymap.set({ "n", "i" }, "<C-e>", function()
  local ls = require("luasnip")
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, opts)

-- Navigator
keymap.set({ "n", "v", "t" }, "<C-h>", function()
  require("Navigator").left()
end, opts)
keymap.set({ "n", "v", "t" }, "<C-j>", function()
  require("Navigator").down()
end, opts)
keymap.set({ "n", "v", "t" }, "<C-k>", function()
  require("Navigator").up()
end, opts)
keymap.set({ "n", "v", "t" }, "<C-l>", function()
  require("Navigator").right()
end, opts)

-- Leader
wk.register({
  ["<Leader>"] = {
    a = {
      name = "+action",
      g = {
        name = "+generate",
        c = {
          function()
            require("neogen").generate()
          end,
          "Generate documentation",
        },
      },
    },
    b = {
      name = "+buffer",
      b = {
        function()
          require("telescope.builtin").buffers()
        end,
        "Show buffers",
      },
      d = { ":bdelete %<Cr>:bd<Space>", "Delete buffer" },
      f = { ":Format<Cr>", "Format the buffer" },
      n = { ":pnext<Cr>", "Next buffer" },
      p = { ":bprevious<Cr>", "Previous buffer" },
    },
    e = {
      name = "+evaluate",
      b = {
        function()
          require("util.evaluate").buffer()
        end,
        "Evaluate the current buffer",
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
            require("dapui").toggle()
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
      n = { ":enew<Cr>", "New file" },
      b = {
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        "File browser",
      },
      f = {
        function()
          require("telescope.builtin").fd({ hidden = true })
        end,
        "Find file",
      },
      g = {
        function()
          require("telescope.builtin").git_files()
        end,
        "Files",
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
    o = {
      name = "+open",
      m = { "<Plug>MarkdownPreviewToggle", "Toggle markdown preview" },
      t = {
        name = "+terminal",
        t = {
          function()
            require("util.terminal").open("h")
          end,
          "Quickly open a terminal",
        },
        h = {
          function()
            require("util.terminal").open("h")
          end,
          "Open a terminal in a horizontal split",
        },
        v = {
          function()
            require("util.terminal").open("v")
          end,
          "Open a terminal in a vertical split",
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
      s = { ":setlocal spell!<Cr>", "Spell check" },
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
      m = {
        function()
          require("harpoon.mark").add_file()
        end,
        "Add file to harpoon list",
      },
      s = {
        name = "+session",
        l = {
          function()
            require("persistence").load({ last = true })
          end,
          "Restore last",
        },
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
