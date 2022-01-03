local null_ls = require("null-ls")
local b = null_ls.builtins

-- local eslint_opts = {
--     condition = function(utils)
--         return utils.root_has_file(".eslintrc.js")
--     end,
--     diagnostics_format = "#{m} [#{c}]",
--     prefer_local = "node_modules/.bin"
-- }

local sources = {
    b.formatting.prettierd,
    -- b.diagnostics.eslint_d.with(eslint_opts),
    -- b.formatting.eslint_d.with(eslint_opts),
    -- b.code_actions.eslint_d.with(eslint_opts),
    b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
    b.code_actions.gitsigns,
}

local M = {}
M.setup = function(on_attach)
    null_ls.setup({
        -- debug = true,
        sources = sources,
        on_attach = on_attach
    })
end

return M
