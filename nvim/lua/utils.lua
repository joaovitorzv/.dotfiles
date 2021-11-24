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

M.command = function (mode, keymap, source, opts)
  print(vim.inspect(mode, keymap, source, opts))
  api.nvim_set_keymap(mode, keymap, source, get_options(opts))
end

return M
