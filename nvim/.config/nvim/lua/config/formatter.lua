local M = {}

function M.setup()
  -- Define a custum user-command to write without executing autocommands and
  -- formatting the file
  vim.api.nvim_create_user_command("W", ":noautocmd w", {})

  -- Define autocommand to automatically format files on save.
  vim.api.nvim_create_autocmd("BufWritePost", {
    command = "FormatWrite",
    group = vim.api.nvim_create_augroup("FormatText", { clear = true }),
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
            args = { "--assume-filename " .. vim.api.nvim_buf_get_name(0) },
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
              "--tab-size " .. vim.opt.shiftwidth:get(),
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
              "--assume-filename " .. vim.api.nvim_buf_get_name(0),
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
              "--stdin-filepath "
                .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
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
      html = {
        function()
          return {
            exe = "prettier",
            args = {
              "--stdin-filepath "
                .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            },
            stdin = true,
          }
        end,
      },
      javascript = {
        function()
          return {
            exe = "prettier",
            args = {
              "--stdin-filepath "
                .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            },
            stdin = true,
          }
        end,
      },
      markdown = {
        function()
          return {
            exe = "prettier",
            args = {
              "--stdin-filepath "
                .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
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
              "--stdin-filename "
                .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
              "-",
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
              "--stdin-filepath "
                .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            },
            stdin = true,
          }
        end,
      },
      rust = {
        function()
          return {
            exe = "rustfmt",
            args = { "--emit stdout", "--" },
            stdin = true,
          }
        end,
      },
      scheme = {
        function()
          return {
            exe = "emacs",
            args = {
              "--batch",
              string.format(
                [[--eval '
(let (scheme-file-content
      next-line)
  (while (setq next-line (ignore-errors (read-from-minibuffer "")))
         (setq scheme-file-content (concat scheme-file-content next-line "\n")))
  (with-temp-buffer
    (scheme-mode)
    (setq indent-tabs-mode nil)
    (setq standard-indent %d)
    (setq tab-width %d)
    (insert scheme-file-content)
    (delete-region (- (point-max) 1) (point-max))
    (indent-region (point-min) (point-max))
    (princ (buffer-string))))
              ']],
                vim.opt.shiftwidth:get(),
                vim.opt.shiftwidth:get()
              ),
            },
            stdin = true,
          }
        end,
      },
      ["scheme.guile"] = {
        function()
          return {
            exe = "emacs",
            args = {
              "--batch",
              string.format(
                [[--eval '
(let (scheme-file-content
      next-line)
  (while (setq next-line (ignore-errors (read-from-minibuffer "")))
         (setq scheme-file-content (concat scheme-file-content next-line "\n")))
  (with-temp-buffer
    (scheme-mode)
    (setq indent-tabs-mode nil)
    (setq standard-indent %d)
    (setq tab-width %d)
    (insert scheme-file-content)
    (delete-region (- (point-max) 1) (point-max))
    (indent-region (point-min) (point-max))
    (princ (buffer-string))))
              ']],
                vim.opt.shiftwidth:get(),
                vim.opt.shiftwidth:get()
              ),
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
              "-filename " .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
              "-i " .. vim.opt.shiftwidth:get(),
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
      typescript = {
        function()
          return {
            exe = "prettier",
            args = {
              "--stdin-filepath "
                .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            },
            stdin = true,
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
              "--stdin-filepath "
                .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            },
            stdin = true,
          }
        end,
      },
    },
  })
end

return M
