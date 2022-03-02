local M = {}
local fn = vim.fn
local u = require("util")

function M.buffer()
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  if filetype == "vim" or filetype == "lua" then
    local buffer = fn.bufname()
    vim.api.nvim_command("source " .. buffer)
    vim.notify("Evaluated " .. buffer)
  else
    vim.notify("Current file is not a lua or vim file", vim.log.levels.INFO)
  end
end

function M.line()
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  local line = vim.api.nvim_get_current_line()
  if filetype == "vim" then
    vim.api.nvim_command(line)
  elseif filetype == "lua" then
    line = "do\n" .. line .. "\nend"
    vim.notify("Execute current line...")
    vim.api.nvim_command("luado " .. line)
  else
    vim.notify("Current file is not a lua or vim file", vim.log.levels.INFO)
  end
end

function M.section()
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  local selection = u.get_visual_selection()
  if filetype == "vim" then
    vim.api.nvim_command(selection)
  elseif filetype == "lua" then
    selection = "do\n" .. selection .. "\nend"
    vim.notify("Execute selection...")
    vim.api.nvim_command("luado " .. selection)
  else
    vim.notify("Current file is not a lua or vim file", vim.log.levels.INFO)
  end
end

return M
