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
Plug 'marko-cerovac/material.nvim'
Plug 'gruvbox-community/gruvbox'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" syntax highlight
" Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'p00f/nvim-ts-rainbow'
Plug 'neovim/nvim-lspconfig'
" useful plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'preservim/nerdtree'
Plug 'windwp/nvim-autopairs'

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
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    disable = { "cuda", "python" },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  rainbow = {
    enable = true,
    extented_mode = false,
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
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> gd :call CocAction('jumpDefinition', 'vsplit')<CR>

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
EOF
