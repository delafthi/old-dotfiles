local M = {}

function M.setup()
  -- Define autocommand to automatically format files on save.
  vim.api.nvim_create_autocmd("BufWritePost", {
    command = "FormatWrite",
    group = vim.api.nvim_create_augroup("formatText", { clear = true }),
  })
end
function M.config()
  -- Call the setup function
  require("formatter").setup({
    filetype = {
      c = {
        function()
          return {
            exe = "clang-format",
            args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
            stdin = true,
            cwd = vim.fn.expand("%:p:h"),
          }
        end,
      },
      cmake = {
        function()
          return {
            exe = "cmake-format",
            args = {
              "--tab-size",
              2,
              "--enable-sort",
              "-o",
              "-",
              "-",
            },
            stdin = true,
            cwd = vim.fn.expand("%:p:h"),
          }
        end,
      },
      cpp = {
        function()
          return {
            exe = "clang-format",
            args = {
              "--assume-filename",
              vim.api.nvim_buf_get_name(0),
            },
            stdin = true,
            cwd = vim.fn.expand("%:p:h"),
          }
        end,
      },
      css = {
        function()
          return {
            exe = "prettier",
            args = {
              "--parser",
              "css",
              "--stdin-filepath",
              vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            },
            stdin = true,
          }
        end,
      },
      fish = {
        function()
          return {
            exe = "fish_indent",
            stdin = true,
          }
        end,
      },
      haskell = {
        function()
          return {
            exe = "hindent",
            args = {
              "--line-length",
              80,
              "--indent-size",
              2,
              "--sort-imports",
            },
            stdin = true,
            cwd = vim.fn.expand("%:p:h"),
          }
        end,
      },
      html = {
        function()
          return {
            exe = "prettier",
            args = {
              "--parser",
              "html",
              "--stdin-filepath",
              vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            },
            stdin = true,
          }
        end,
      },
      lua = {
        function()
          return {
            exe = "stylua",
            args = {
              "--stdin-filepath",
              vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
              "--search-parent-directories",
              "-",
            },
            stdin = true,
            cwd = vim.fn.expand("%:p:h"),
          }
        end,
      },
      markdown = {
        function()
          return {
            exe = "prettier",
            args = {
              "--parser",
              "markdown",
              "--stdin-filepath",
              vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            },
            stdin = true,
          }
        end,
      },
      python = {
        function()
          return {
            exe = "black",
            args = {
              "--stdin-filename",
              vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
              "-",
            },
            stdin = true,
            cwd = vim.fn.expand("%:p:h"),
          }
        end,
      },
      scala = {
        function()
          return {
            exe = "scalafmt",
            args = {
              "--stdout",
              "--stdin",
            },
            stdin = true,
            cwd = vim.fn.expand("%:p:h"),
          }
        end,
      },
      rmd = {
        function()
          return {
            exe = "prettier",
            args = {
              "--parser",
              "markdown",
              "--stdin-filepath",
              vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            },
            stdin = true,
          }
        end,
      },
      sh = {
        function()
          return {
            exe = "shfmt",
            args = {
              "-s",
              "-p",
              "-filename",
              vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
              "-i",
              2,
              "-ci",
              "-sr",
              "-fn",
              "-",
            },
            stdin = true,
            cwd = vim.fn.expand("%:p:h"),
          }
        end,
      },
      systemverilog = {
        function()
          return {
            exe = "iStyle",
            args = {
              "--style=gnu",
              "-s=spaces=2",
              "--brackets=break",
              "--one-line=keep-blocks",
              "--convert-tabs",
              "--break-blocks",
            },
            stdin = true,
            cwd = vim.fn.expand("%:p:h"),
          }
        end,
      },
      vhdl = {
        function()
          return {
            exe = "emacs",
            args = {
              "--batch",
              string.format(
                [[--eval '
(let (vhdl-file-content
      next-line)
  (while (setq next-line (ignore-errors (read-from-minibuffer "")))
         (setq vhdl-file-content (concat vhdl-file-content next-line "\n")))
  (with-temp-buffer
    (vhdl-mode)
    (vhdl-set-style "IEEE")
    (setq vhdl-basic-offset %d)
    (vhdl-set-offset \'arglist-close 0)
    (insert vhdl-file-content)
    (delete-region (- (point-max) 1) (point-max))
    (vhdl-beautify-region (point-min) (point-max))
    (princ (buffer-string))))
              ']],
                vim.opt.shiftwidth:get()
              ),
            },
            stdin = true,
          }
        end,
      },
      yaml = {
        function()
          return {
            exe = "prettier",
            args = {
              "--parser",
              "yaml",
              "--stdin-filepath",
              vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            },
            stdin = true,
          }
        end,
      },
    },
  })
end

return M
