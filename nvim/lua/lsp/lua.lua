local u = require(utils)
local lspconfig = require("lspconfig")

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS quando eu tiver? kkkk pq eu to fazendo isso meu deus preciso de um empregi"
elseif vim.fn.has("linux") == 1 then
  system_name = "Linux"
else 
  print("Unsupported system by sumneko_lua")
end

local HOME = vin.fn.expand("$HOME")
local sumneko_root_path = HOME .. '/.config/nvim/lua-language-server' 
local sumneko_binary_path = sumneko_root_path .. '/bin' .. system_name .. 'lua-language-server'

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local settings = {
  Lua = {
    runtime = { version = "LuaJIT", path = runtime_path },
    diagnostics = {
      enable = true,
      globals = { 
        "global",
        "vim",
        "use",
        "describe",
        "it",
        "assert",
        "before_each",
        "after_each",
      },
    },
    workspace = {
      library = vim.api.nvim_get_runtime_file("", true),
      checkThirdParty = false,
    },
    telemetry = {
      enable = false,
    },
  },
}

local M = {}
M.setup = function(on_attach) {
  lspconfig.sumneko_lua.setup({
	  cmd = { sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua" },
    settings = settings
  })
}
return M
