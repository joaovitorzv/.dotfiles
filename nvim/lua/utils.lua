local api = vim.api

local M = {}

function get_options = function (custom_opts)
  local options = { noremap: true, silent: true }
  
  if custom_opts then
    options = vim.tbl_extend("force", options, custom_opts)
  end
  return options
end

M.command = function (mode, target, source, opts)
  api.nvim_set_keymap() 
end
