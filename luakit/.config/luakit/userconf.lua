---@diagnostic disable
local luakit = luakit
---@diagnostic enable

-- General settings
-- ~~~~~~~~~~~~~~~~

local settings = require("settings")

settings.window.home_page = "htps://searx.fmac.xyz/"
settings.window.search_engines = {
  default = "https://searx.fmac.xyz/search?q=%s",
  sx = "https://searx.fmac.xyz/search?q=%s",
  ddg = "https://duckduckgo.com/?q=%s",
  aur = "https://aur.archlinux.org/packages/?O=0&K=%s",
  aw = "https://wiki.archlinux.org/index.php?search=%s",
  wiki = "https://en.wikipedia.org/w/index.php?search=%s",
  gs = "https://scholar.google.com/scholar?hl=de&as_sdt=0%2C5&q=%s&btnG=",
  thes = "https://www.powerthesaurus.org/%s/synonyms",
}

-- Adblocker
-- ~~~~~~~~~

--[[ local adblock = require("adblock") ]]
--[[ local http = require("socket.http") ]]
--[[ local filter_list = { ]]
--[[   easylist = "https://easylist.to/easylist/easylist.txt", ]]
--[[   easyprivacy = "https://easylist.to/easylist/easyprivacy.txt", ]]
--[[   ["fanboy-annoyance"] = "https://secure.fanboy.co.nz/fanboy-annoyance.txt", ]]
--[[ } ]]
--[[ local filter_dir = os.getenv("HOME") .. "/.local/share/luakit/adblock" ]]
--[[]]
--[[ print(os.execute("pwd")) ]]
--[[ local index = 0 ]]
--[[ for name, url in ipairs(filter_list) do ]]
--[[   local filename = filter_dir .. "/" .. name .. ".txt" ]]
--[[   -- TODO: Check if the file exists ]]
--[[   -- TODO: Check the expiration date in the header ]]
--[[]]
--[[   local body, code = http.request(url) ]]
--[[   if not body then ]]
--[[     error(code) ]]
--[[   end ]]
--[[   print(filename) ]]
--[[   local f = assert(io.open(filename, "wb")) ]]
--[[   f:write(body) ]]
--[[   f:close() ]]
--[[]]
--[[   adblock.list_set_enable(index, true) ]]
--[[   index = index + 1 ]]
--[[ end ]]

-- Check if a adblock list is available, else download one

-- Key bindings
-- ~~~~~~~~~~~~

local modes = require("modes")
modes.add_binds("normal", {
  {
    "yy",
    "Copy selected text",
    function()
      luakit.selection.clipboard = luakit.selection.primary
    end,
  },
})
