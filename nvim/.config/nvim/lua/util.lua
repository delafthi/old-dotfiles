local M = {}
local fn = vim.fn
local cmd = vim.cmd

function M.open_terminal(split)
  if split == "h" then
    cmd([[botright 12 split term://$SHELL]])
  else
    cmd([[botright vsplit term://$SHELL]])
  end
  cmd([[setlocal nonumber]])
  cmd([[setlocal norelativenumber]])
  cmd([[startinsert]])
end

function M.foldtext()
  local foldstart = vim.api.nvim_get_vvar("foldstart")
  local line = vim.api.nvim_buf_get_lines(0, foldstart - 1, foldstart, false)
  local sub = string.gsub(line[1], "{{{.*", "")
  return "▸ " .. sub
end

function M.get_visual_selection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, "\n")
end

function M.eval_buffer()
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  if filetype == "vim" or filetype == "lua" then
    local buffer = fn.bufname()
    vim.api.nvim_command("source " .. buffer)
    vim.notify("Evaluated " .. buffer)
  else
    vim.notify("Current file is not a lua or vim file", vim.log.levels.INFO)
  end
end

function M.eval_line()
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

function M.eval_section()
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  local selection = M.get_visual_selection()
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
