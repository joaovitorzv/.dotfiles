local api = vim.api

local get_options = function (custom_opts)
  local options = { noremap = true, silent = true }
  if custom_opts then
    options = vim.tbl_extend("force", options, custom_opts)
  end
  return options
end

local M = {}

M.map = function (mode, keymap, source, opts)
  api.nvim_set_keymap(mode, keymap, source, get_options(opts))
end

M.buf_map = function (bufnr, mode, keymap, source, opts)
  vim.api.nvim_buf_set_keymap(bufnr or 0, mode, keymap, source, get_options(opts))
end

return M
