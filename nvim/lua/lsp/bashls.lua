local lspconfig = require('lspconfig')

local M = {}
M.setup = function (on_attach)
  lspconfig.bashls.setup({
    on_attach = function (client, bufnr)
      on_attach(client, bufnr)
    end
  })
end

return M
