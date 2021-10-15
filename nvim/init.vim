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
Plug 'tomasiser/vim-code-dark'
Plug 'gruvbox-community/gruvbox'

" syntax highlight
" Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
"Plug 'jparise/vim-graphql'
Plug 'neovim/nvim-lspconfig'

" useful plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'preservim/nerdtree'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" auto brackets
Plug 'jiangmiao/auto-pairs'

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
  }
}
EOF

"fzf
set rtp+=~/.vim/bundle/fzf

" colorscheme
set background=dark
colorscheme gruvbox 
let g:airline_theme='gruvbox'

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
nnoremap <leader>f :FZF<CR> 
nnoremap <silent> <leader>pf :Files %:p:h<CR>

" utils  
nnoremap <leader>s :w<CR>
nnoremap <leader>q :wq<CR>

" definitions
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> gd :call CocAction('jumpDefinition', 'vsplit')<CR>

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
  require'lspconfig'.pyright.setup{}
EOF
