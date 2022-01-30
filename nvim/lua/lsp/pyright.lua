local lspconfig = require('lspconfig')

local settings = {
  python = {
    pythonPath = "python3"
  }
}

local M = {}
M.setup = function (on_attach, capabilities)
  lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = settings,
  })
end

return M
