local api = vim.api

local get_options = function (custom_opts)
  print(vim.inspect(custom_opts))
  local options = { noremap = true, silent = true }
  if custom_opts then
    options = vim.tbl_extend("force", options, custom_opts)
  end
  return options
end

local M = {}

M.command = function (mode, target, source, opts)
  print(vim.inspect(mode, target, source, opts))
  api.nvim_set_keymap(mode, target, source, get_options(opts))
end

return M
