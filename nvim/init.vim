syntax on

set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab 
set smartindent

set exrc
set guicursor=
set relativenumber
set nu
set nowrap
set incsearch
set scrolloff=8
set signcolumn=yes
set backspace=indent,eol,start
set colorcolumn=80
set nohlsearch
set completeopt=menuone,noselect

"coc required
set hidden 
set nobackup 
set nowritebackup 
set cmdheight=2
set updatetime=300
set shortmess+=c

call plug#begin('~/.vim/plugged')

" colorscheme
Plug 'gruvbox-community/gruvbox'

" syntax highlight
" Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


Plug 'prabirshrestha/vim-lsp'
Plug 'neovim/nvim-lspconfig'

" useful plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'preservim/nerdtree'
Plug 'windwp/nvim-autopairs'
Plug 'p00f/nvim-ts-rainbow'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" airline 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" treeshitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript" },
  highlight = {
    enable = false,
    disable = { "cuda", "python" },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false 
  },
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = nil,
  }
}
EOF

"fzf
set rtp+=~/.vim/bundle/fzf

" colorscheme 
colorscheme gruvbox 

" transparent bg
highlight Normal     ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE

" leader key
let mapleader = " "

" nerdtree
nmap <F6> :NERDTreeToggle<CR>

" telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr> 
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" window 
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<CR>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

" window tabs
nnoremap <leader><tab> :tabn<CR>
nnoremap <leader><S-Tab> :tabp<CR>

" copypaste
noremap <Leader>p "+p
noremap <Leader>y "+y

" find
nnoremap <silent> <leader>f :GFiles<CR> 

" utils  
nnoremap <leader>s :w<CR>
nnoremap <leader>q :wq<CR>

" definitions
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"nmap <silent> gd :call CocAction('jumpDefinition', 'vsplit')<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" COC...k?
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" lua
command! Scratch lua require'tools'.makeScratch()

lua << EOF
require'nvim-autopairs'.setup{}
require'lspconfig'.pylsp.setup{}
EOF

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
