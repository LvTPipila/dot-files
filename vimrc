"         _
" __    _(_)_ __ ___  _ __ ___
" \ \  / / | '_ ' _ \| '__/ __|
"  \ \/ /| | | | | | | | | (__
"   \__/ |_|_| |_| |_|_|  \___|

set nocompatible
set encoding=utf-8

syntax on
filetype plugin indent on

" PLUGINS SECTION

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'leafgarland/typescript-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-utils/vim-man'
Plug 'vim-scripts/TagHighlight'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-scripts/indentpython.vim'
Plug 'rust-lang/rust.vim'

call plug#end()


" VISUALS

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=2
set expandtab                   "Expand tabs into spaces
set smartindent
set autoindent
set nu                          "Enable line number
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set smarttab
set relativenumber				"Enable relative line number
set scrolloff=8
set signcolumn=yes
set clipboard=unnamed           "Allows to copy from computer clipboard into vim
set colorcolumn=100

highlight ColorColumn ctermbg=233 guibg=grey

colorscheme nord
set background=dark

if executable('rg')
	let g:rg_derive_root='true'
endif

let mapleader = " "
let g:netrw_browse_split=2
let g:netrw_banner = 0
let g:netrw_winsize = 72

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
"nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +10<CR>
nnoremap <silent> <Leader>- :vertical resize -10<CR>
"nnoremap <leader>M :!ctags -R .<CR>
"nnoremap <leader>C :UpdateTypesFileOnly<CR>
" You Complete Me commands
"nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>

