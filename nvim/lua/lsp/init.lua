-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  u.buf_map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', nil)
  u.buf_map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', nil)
  u.buf_map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', nil)
  u.buf_map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', nil)
  u.buf_map(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', nil)
  u.buf_map(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', nil)
  u.buf_map(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', nil)
  u.buf_map(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', nil)
  u.buf_map(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', nil)
  u.buf_map(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', nil)
  u.buf_map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', nil)
  u.buf_map(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', nil)
  u.buf_map(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', nil)
  u.buf_map(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', nil)
  u.buf_map(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', nil)
  u.buf_map(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', nil)
  u.buf_map(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', nil)
  u.buf_map(bufnr, 'n', '<leader>so', '<cmd>lua vim.lsp.buf.formatting()<CR>', nil)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
