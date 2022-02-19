local wk = require("which-key")

-- nvim
wk.register({
  j = { "gj", "Move the cursor a visual line down" },
})
wk.register({
  j = { "gj", "Move the cursor a visual line down", mode = "v" },
})
wk.register({
  k = { "gk", "Move the cursor a visual line up" },
})
wk.register({
  k = { "gk", "Move the cursor a visual line up", mode = "v" },
})
wk.register({
  n = { "nzzzv", "Go to the next found element" },
})
wk.register({
  n = { "nzzzv", "Go to the next found element", mode = "v" },
})
wk.register({
  N = { "Nzzzv", "Go to the previous found element" },
})
wk.register({
  N = { "Nzzzv", "Go to the previous found element", mode = "v" },
})
wk.register({
  J = { "mzJ`z", "Merge with the next line" },
  Y = { "y$", "Copy from cursor to the end of the line" },
})
wk.register({
  ["<C-h>"] = {
    "<C-\\><C-n><C-w>h",
    "Move to the left pane",
  },
})
wk.register({
  ["<C-h>"] = {
    "<C-\\><C-n><C-w>h",
    "Move to the left pane",
    mode = "i",
  },
})
wk.register({
  ["<C-h>"] = {
    "<C-\\><C-n><C-w>h",
    "Move to the left pane",
    mode = "t",
  },
})
wk.register({
  ["<C-j>"] = {
    "<C-\\><C-n><C-w>j",
    "Move to the lower pane",
  },
})
wk.register({
  ["<C-j>"] = {
    "<C-\\><C-n><C-w>j",
    "Move to the lower pane",
    mode = "i",
  },
})
wk.register({
  ["<C-j>"] = {
    "<C-\\><C-n><C-w>j",
    "Move to the lower pane",
    mode = "t",
  },
})
wk.register({
  ["<C-k>"] = {
    "<C-\\><C-n><C-w>k",
    "Move to the upper pane",
  },
})
wk.register({
  ["<C-k>"] = {
    "<C-\\><C-n><C-w>k",
    "Move to the upper pane",
    mode = "i",
  },
})
wk.register({
  ["<C-k>"] = {
    "<C-\\><C-n><C-w>k",
    "Move to the upper pane",
    mode = "t",
  },
})
wk.register({
  ["<C-l>"] = {
    "<C-\\><C-n><C-w>l",
    "Move to the right pane",
  },
})
wk.register({
  ["<C-l>"] = {
    "<C-\\><C-n><C-w>l",
    "Move to the right pane",
    mode = "i",
  },
})
wk.register({
  ["<C-l>"] = {
    "<C-\\><C-n><C-w>l",
    "Move to the right pane",
    mode = "t",
  },
})
wk.register({
  ["<C-Left>"] = {
    "<C-\\><C-n>:vertical resize -2<Cr>",
    "Decrease pane width",
  },
})
wk.register({
  ["<C-Left>"] = {
    "<C-\\><C-n>:vertical resize -2<Cr>",
    "Decrease pane width",
    mode = "i",
  },
})
wk.register({
  ["<C-Left>"] = {
    "<C-\\><C-n>:vertical resize -2<Cr>",
    "Decrease pane width",
    mode = "t",
  },
})
wk.register({
  ["<C-Up>"] = {
    "<C-\\><C-n>:resize +2<Cr>",
    "Increase pane height",
  },
})
wk.register({
  ["<C-Up>"] = {
    "<C-\\><C-n>:resize +2<Cr>",
    "Increase pane height",
    mode = "i",
  },
})
wk.register({
  ["<C-Up>"] = {
    "<C-\\><C-n>:resize +2<Cr>",
    "Increase pane height",
    mode = "t",
  },
})
wk.register({
  ["<C-Down>"] = {
    "<C-\\><C-n>:resize +2<Cr>",
    "Decrease pane height",
  },
})
wk.register({
  ["<C-Down>"] = {
    "<C-\\><C-n>:resize +2<Cr>",
    "Decrease pane height",
    mode = "i",
  },
})
wk.register({
  ["<C-Down>"] = {
    "<C-\\><C-n>:resize +2<Cr>",
    "Decrease pane height",
    mode = "t",
  },
})
wk.register({
  ["<C-Right>"] = {
    "<C-\\><C-n>:vertical resize +2<Cr>",
    "Increase pane width",
  },
})
wk.register({
  ["<C-Right>"] = {
    "<C-\\><C-n>:vertical resize +2<Cr>",
    "Increase pane width",
    mode = "i",
  },
})
wk.register({
  ["<C-Right>"] = {
    "<C-\\><C-n>:vertical resize +2<Cr>",
    "Increase pane width",
    mode = "t",
  },
})
wk.register({
  ["<"] = { "<gv", "Decrease indentation level", mode = "v" },
  [">"] = { ">gv", "Increase indentation level", mode = "v" },
})

-- Lightspeed
wk.register({
  [";"] = {
    "<Plug>Lightspeed_;_sx",
    "Go to next match",
  },
})
wk.register({
  [";"] = {
    "<Plug>Lightspeed_;_sx",
    "Go to next match",
    mode = "v",
  },
})
wk.register({
  [","] = {
    "<Plug>Lightspeed_,_sx",
    "Go to next match",
  },
})
wk.register({
  [","] = {
    "<Plug>Lightspeed_,_sx",
    "Go to next match",
    mode = "v",
  },
})

-- keymap.set("v", ";", "<Plug>Lightspeed_;_sx", opts)
-- keymap.set("v", ";", "<Plug>Lightspeed_;_ft", opts)
-- keymap.set("v", ",", "<Plug>Ligthspeed_,_sx", opts)
-- keymap.set("v", ",", "<Plug>Ligthspeed_,_ft", opts)

-- Leader
wk.register({
  ["<Leader>"] = {
    j = {
      ":m .+1<Cr>==",
      "Move the current line down",
    },
    k = { ":m .-2<Cr>==", "Move the current line up" },
    o = { ":setlocal spell!<Cr>", "Enable spell check" },
  },
})
wk.register({
  ["<Leader>"] = {
    j = {
      ":m '>+1<Cr>gv=gv",
      "Move the current line down",
      mode = "v",
    },
    k = { ":m <-2<Cr>gv=gv", "Move the current line up", mode = "v" },
  },
})
-- Leader t
wk.register({
  ["<Leader>"] = {
    t = {
      name = "+terminal",
      t = {
        function()
          require("util").open_terminal("h")
        end,
        "Quickly open a terminal",
      },
      h = {
        function()
          require("util").open_terminal("h")
        end,
        "Open a terminal in a horizontal split",
      },
      v = {
        function()
          require("util").open_terminal("v")
        end,
        "Open a terminal in a vertical split",
      },
    },
  },
})
-- Leader e
wk.register({
  ["<Leader>"] = {
    e = {
      name = "+evaluate",
      b = {
        function()
          require("util").eval_buffer()
        end,
        "Evaluate the current buffer",
      },
      e = {
        function()
          require("util").eval_line()
        end,
        "Evaluate the current line",
      },
    },
  },
})
wk.register({
  ["<Leader>e"] = {
    function()
      require("util").eval_section()
    end,
    "Evaluate section",
    mode = "v",
  },
})
-- Leader b
wk.register({
  ["<Leader>"] = {
    b = {
      name = "+buffer",
      d = { ":ls<Cr>:bd<Space>", "Delete buffer" },
      f = { ":Format<Cr>", "Format the buffer" },
      b = {
        function()
          require("telescope.builtin").buffers()
        end,
        "Show buffers",
      },
    },
  },
})

-- Leader f
wk.register({
  ["<Leader>"] = {
    f = {
      name = "+file",
      n = { ":DashboardNewFile<Cr>", "New file" },
      h = { ":DashboardNewFile<Cr>", "Search in file history" },
      b = {
        function()
          require("telescope").extensions.file_browser.file()
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
        "Find Git files",
      },
    },
  },
})

--Leader g
wk.register({
  ["<Leader>"] = {
    g = {
      name = "+git",
      s = {
        function()
          require("telescope.builtin").git_status()
        end,
        "Git status",
      },
      g = {
        function()
          require("neogit").open({ kind = "vsplit" })
        end,
        "Neogit",
      },
    },
  },
})

-- Dashboard
wk.register({
  ["<Leader>"] = {
    s = {
      name = "+session",
      s = { ":<C-u>SessionSave<Cr>", "Save the session" },
      l = { ":<C-u>SessionLoad<Cr>", "Load a session" },
    },
  },
})

-- Telescope
wk.register({
  ["<Leader>"] = {
    ["rg"] = {
      function()
        require("telescope.builtin").live_grep()
      end,
      "Live grep",
    },
    h = {
      name = "+help",
      h = {
        function()
          require("telescope.builtin").help_tags()
        end,
        "Search help tags",
      },
      k = {
        function()
          require("telescope.builtin").keymaps()
        end,
        "Search keymaps",
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
  },
})

-- Neogit
wk.register({
  ["<Leader>"] = {
    g = {
      name = "+git",
    },
  },
})

-- Harpoon
wk.register({
  ["<Leader>"] = {
    ["<Space>"] = {
      name = "+harpoon",
      m = {
        function()
          require("harpoon.mark").add_file()
        end,
        "Add file to harpoon list",
      },
      ["<Space>"] = {
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        "Toggle harpoon menu",
      },
    },
    ["1"] = {
      function()
        require("harpoon.ui").nav_file(1)
      end,
      "Jump to file 1",
    },
    ["2"] = {
      function()
        require("harpoon.ui").nav_file(2)
      end,
      "Jump to file 1",
    },
    ["3"] = {
      function()
        require("harpoon.ui").nav_file(3)
      end,
      "Jump to file 1",
    },
    ["4"] = {
      function()
        require("harpoon.ui").nav_file(4)
      end,
      "Jump to file 1",
    },
  },
})

-- nvim-dap
wk.register({
  ["<Leader>"] = {
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
  },
})

-- nvim-dap-ui
wk.register({
  ["<Leader>"] = {
    d = {
      name = "+debugger",
      g = {
        function()
          require("dapui").toggle()
        end,
        "Toggle GUI",
      },
    },
  },
})

-- markdown-preview
wk.register({
  ["<Leader>"] = {
    ["mp"] = { "<Plug>MarkdownPreviewToggle", "Toggle markdown preview" },
  },
})

-- Navigator
wk.register({
  ["<C-h>"] = {
    function()
      require("Navigator").left()
    end,
    "Move to the left pane",
  },
  ["<C-j>"] = {
    function()
      require("Navigator").down()
    end,
    "Move to the lower pane",
  },
  ["<C-k>"] = {
    function()
      require("Navigator").up()
    end,
    "Move to the upper pane",
  },
  ["<C-l>"] = {
    function()
      require("Navigator").right()
    end,
    "Move to the right pane",
  },
})
