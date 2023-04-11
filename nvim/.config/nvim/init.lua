-- Entrypoint of Neovim's configuration
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- Install dependencies, if they are not yet installed
local plugin_path = vim.fn.stdpath("data") .. "/lazy"

local function ensure(plugin, opts)
  local plugin_name = plugin:match("/(.+)")
  local install_path = string.format("%s/%s", plugin_path, plugin_name)

  if not vim.loop.fs_stat(install_path) then
    opts = opts or {}
    local args = { "--filter=blob:none" }
    for k, v in pairs(opts) do
      table.insert(args, string.format("--%s=%s", k, v))
    end

    local git_log = vim.fn.system({
      "git",
      "clone",
      unpack(args),
      "https://github.com/" .. plugin,
      install_path,
    })
    print(git_log)

    print("Installed " .. plugin_name)
  end
  vim.opt.rtp:prepend(install_path)
end

-- Bootstrap essential plugins required to install and load the rest
if not vim.loop.fs_stat(plugin_path) then
  print("Bootstrapping neovim...")
end
ensure("Olical/aniseed")
ensure("folke/lazy.nvim", { branch = "stable" })

-- Enable Aniseed's automatic compilation and loading of Fennel source code
vim.g["aniseed#env"] = { compile = true }
