local u = require('utils')
local cmp = require('cmp_nvim_lsp')

local lsp = vim.lsp
local api = vim.api

local border_opts = { border = "single", focusable = false, scope = "line" }

vim.diagnostic.config({ virtual_text = false, float = border_opts })

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, border_opts)

-- use lsp formatting if it's available (and if it's good)
-- otherwise, fall back to null-ls
local preferred_formatting_clients = { "eslint_d" }
local fallback_formatting_client = "null-ls"

local formatting = function()
    local bufnr = api.nvim_get_current_buf()

    local selected_client
    for _, client in ipairs(lsp.get_active_clients()) do
        if vim.tbl_contains(preferred_formatting_clients, client.name) then
            selected_client = client
            break
        end

        if client.name == fallback_formatting_client then
            selected_client = client
        end
    end

    if not selected_client then
        return
    end

    local params = lsp.util.make_formatting_params()
    local result, err = selected_client.request_sync("textDocument/formatting", params, 5000, bufnr)
    if result and result.result then
        lsp.util.apply_text_edits(result.result, bufnr)
    elseif err then
        vim.notify("global.lsp.formatting: " .. err, vim.log.levels.WARN)
    end
end

global.lsp = {
    border_opts = border_opts,
    formatting = formatting,
}

local on_attach = function(client, bufnr)
  if client.resolved_capabilities.completion then
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end

  if client.resolved_capabilities.document_formatting then
    print(vim.inspect('caiu no '))
    vim.cmd("autocmd BufWritePre <buffer> lua global.lsp.formatting()")
  end

  -- commands
  u.lua_command("LspFormatting", "vim.lsp.buf.formatting()")
  u.lua_command("LspHover", "vim.lsp.buf.hover()")
  u.lua_command("LspRename", "vim.lsp.buf.rename()")
  u.lua_command("LspDiagPrev", "vim.diagnostic.goto_prev()")
  u.lua_command("LspDiagNext", "vim.diagnostic.goto_next()")
  u.lua_command("LspDiagLine", "vim.diagnostic.open_float(nil, global.lsp.border_opts)")
  u.lua_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")
  u.lua_command("LspTypeDef", "vim.lsp.buf.type_definition()")

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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp.update_capabilities(capabilities)

for _, servers in ipairs({
  "bashls",
  "eslint",
  "css",
  "null-ls",
  "pyright",
  "sumneko",
  "tsserver"
}) do
  require("lsp." .. servers).setup(on_attach, capabilities)
end
