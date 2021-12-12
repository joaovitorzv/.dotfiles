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
vim.cmd [[colorscheme gruvbox]]
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
--Remap space as leader key
u.map('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Quit, Save & Quit
u.map('n', '<leader>s', '<cmd> w<CR>', { noremap = true })
u.map('n', '<leader>q', '<cmd> wq<CR>', { noremap = true })
u.map('n', '<leader>!q', '<cmd> q<CR>', { noremap = true })
-- Source config 
u.map('n', '<leader>,', '<cmd>so ~/dotfiles/nvim/lua/plugins/init.lua<CR>', { noremap = true })
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
u.map('n', '<leader>t', '<cmd> :NERDTreeFind<CR>', { noremap = true })
u.map('n', '<leader>T', '<cmd> :NERDTreeToggle<CR>', { noremap = true })
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

require("plugins")
require("lsp")
