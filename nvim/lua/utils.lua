local api = vim.api

local M = {}

local get_options = function (custom_opts)
  local options = { noremap: true, silent: true }
  if custom_opts then
    options = vim.tbl_extend("force", options, custom_opts)
  end
  print(vim.inspect(options))
  return options
end

M.command = function (mode, target, source, opts)
  api.nvim_set_keymap(mode, target, source, get_options(opts)) 
end
