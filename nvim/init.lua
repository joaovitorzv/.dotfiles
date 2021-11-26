local u = require('utils')
-- Tabs
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Limit bar
vim.o.colorcolumn = '90'

-- Relative line
vim.o.relativenumber = true

-- Dont break lines
vim.o.wrap = false

-- Stop scroll
vim.o.scrolloff = 8

--Set colorscheme (order is important here)
vim.o.termguicolors = true
-- vim.g.onedark_terminal_italics = 2
vim.cmd [[colorscheme gruvbox]]

require('plugins')

--Remap space as leader key
u.map('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Quit, Save & Quit
u.map('n', '<leader>s', '<cmd> w<CR>', { noremap = true })
u.map('n', '<leader>q', '<cmd> wq<CR>', { noremap = true })
u.map('n', '<leader>!q', '<cmd> q<CR>', { noremap = true })

-- Source init.lua
u.map('n', '<leader>up', '<cmd>so ~/dotfiles/nvim/init.lua<CR>', { noremap = true })

-- Moving around
u.map('n', '<leader>h', '<cmd> wincmd h<CR>', { noremap = true })
u.map('n', '<leader>j', '<cmd> wincmd j<CR>', { noremap = true })
u.map('n', '<leader>k', '<cmd> wincmd k<CR>', { noremap = true })
u.map('n', '<leader>l', '<cmd> wincmd l<CR>', { noremap = true })

-- Resize buffer
u.map('n', '<leader>+', '<cmd> vertical resize +5<CR>', { noremap = true, silent = true })
u.map('n', '<leader>-', '<cmd> vertical resize -5<CR>', { noremap = true, silent = true })

-- Moving around buffer tabs
u.map('n', '<leader>1', '<cmd> tabN<CR>', nil)
u.map('n', '<leader>2', '<cmd> tabn<CR>', nil)

-- Toggle NERDTree
u.map('n', '<leader>t', '<cmd> :NERDTreeToggle<CR>', { noremap = true })
vim.g.NERDTreeShowHidden = 1

-- Remap for dealing with word wrap
u.map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
u.map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Non-volatile paste
u.map('v', '<S-p>', '"0p', nil)
-- Yank from clipboard
u.map('n', '<leader>p', '"+p', { noremap = true })
u.map('v', '<leader>p', '"+p', { noremap = true })
u.map('v', '<leader>y', '"+y', { noremap = true })

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Y yank until the end of line  (note: this is now a default on master)
u.map('n', 'Y', 'y$', { noremap = true })

--Add leader shortcuts
u.map('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
u.map('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
u.map('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
u.map('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
u.map('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
u.map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })

-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  u.buf_map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', nil)
  u.buf_map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  u.buf_map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  u.buf_map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  u.buf_map(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  u.buf_map(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  u.buf_map(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  u.buf_map(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  u.buf_map(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  u.buf_map(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  u.buf_map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  u.buf_map(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  u.buf_map(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  u.buf_map(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  u.buf_map(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  u.buf_map(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  u.buf_map(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  u.buf_map(bufnr, 'n', '<leader>so', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local null_ls = require "null-ls"

local sources = {
  null_ls.builtins.diagnostics.eslint_d.with({
    prefer_local = "node_modules/.bin",
  }),
  null_ls.builtins.code_actions.eslint_d.with({
    prefer_local = "node_modules/.bin"
  }),
  null_ls.builtins.formatting.prettierd,
}

null_ls.config({ sources = sources, debug = true })

local modules = { "lsp" }
for _, module in ipairs(modules) do
  local module_ok = pcall(require, module)
  
  if not module_ok then
    print(vim.inspect('failed to load "' .. module .. '" inside lsp.init'))
  else
    print(vim.inspect('successfuly loaded ' .. module))
  end
end

-- Enable the following language servers
local servers = { 'pyright', 'tsserver', 'bashls', 'null-ls' }
for _, lsp in ipairs(servers) do
 if lsp == 'tsserver' then
    local ts_utils = require("nvim-lsp-ts-utils")
    nvim_lsp.tsserver.setup {
      -- Needed for inlayHints. Merge this table with your settings or copy
      -- it from the source if you want to add your own init_options.
      init_options = ts_utils.init_options,
      on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

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

        -- defaults
        ts_utils.setup({})
        -- required to fix code action ranges and filter diagnostics
        ts_utils.setup_client(client)

        -- no default maps, so you may want to define some here
        local tsopts = { silent = true }
        u.buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>", tsopts)
        u.buf_map(bufnr, "n", "gr", ":TSLspRenameFile<CR>", tsopts)
        u.buf_map(bufnr, "n", "gi", ":TSLspImportAll<CR>", tsopts)
      end,
      capabilities = capabilities
    }
  elseif nvim_lsp[lsp] == 'null-ls' then
    nvim_lsp[lsp].setup {
      on_attach = function(client, _)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
      end,
      capabilities = capabilities,
    }
  else
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'


