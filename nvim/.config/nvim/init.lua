-- Entrypoint of Neovim's configuration
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

local exec = vim.api.nvim_command
local fn = vim.fn

-- Set leader and localleader keys here, because they are required to be set
-- before packer_compile loads
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Install dependencies, if they are not yet installed
local plugin_path = fn.stdpath("data") .. "/site/pack/packer"

local function ensure(plugin)
  local fmt = string.format
  local repo = plugin[1]
  local plugin_type = plugin.opt and "opt" or "start"
  local repo_name = repo:match("/(.+)")
  local install_path = fmt("%s/%s/%s", plugin_path, plugin_type, repo_name)
  if fn.empty(fn.glob(install_path)) > 0 then
    local git_log = fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      fmt("https://github.com/%s", repo),
      install_path,
    })
    print(git_log)
    exec(fmt("packadd %s", repo_name))
    print(fmt("%s installed successfully", repo_name))
    return true
  else
    return false
  end
end

-- Bootstrap essential plugins required to install and load the rest
_G.PACKER_BOOTSTRAP = ensure({ "wbthomason/packer.nvim", opt = true })
ensure({ "Olical/aniseed", opt = false })
ensure({ "lewis6991/impatient.nvim", opt = false })

require("impatient")

-- Enable Aniseed's automatic compilation and loading of Fennel source code
vim.g["aniseed#env"] = { compile = true }
