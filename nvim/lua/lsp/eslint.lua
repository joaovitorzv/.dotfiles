local M = {}
M.setup = function (on_attach, capabilities)
  require("lspconfig")["eslint"].setup({
    on_attach = function (client, bufnr)
      client.resolved_capabilities.document_formatting = true
      on_attach(client, bufnr)
    end,
    capabilities = capabilities
  })
end

return M
