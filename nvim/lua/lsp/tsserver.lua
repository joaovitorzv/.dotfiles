local lspconfig = require('lspconfig')
local ts_utils = require("nvim-lsp-ts-utils")

local u = require('utils')

local ts_utils_settings = {
    debug = true,
    enable_import_on_completion = true,
    import_all_scan_buffers = 100,
    update_imports_on_move = true,
    -- filter out dumb module warning
    filter_out_diagnostics_by_code = { 80001 },
}

local M = {}
M.setup = function (on_attach, capabilities)
  lspconfig["tsserver"].setup({
    root_dir = function (fname)
      return lspconfig.util.root_pattern('package.json', 'tsconfig.json', '.git')(fname)
        or lspconfig.util.path.dirname(fname)
    end,
    init_options = ts_utils.init_options,
    on_attach = function (client, bufnr)
      on_attach(client, bufnr)

      ts_utils.setup(ts_utils_settings)
      ts_utils.setup_client(client)

      u.buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>", nil)
      u.buf_map(bufnr, "n", "gr", ":TSLspRenameFile<CR>", nil)
      u.buf_map(bufnr, "n", "gi", ":TSLspImportAll<CR>", nil)
    end,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  })
end

return M
