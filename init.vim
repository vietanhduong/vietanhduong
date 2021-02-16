set nocompatible

filetype off

syntax on

filetype plugin indent on

set modelines=0

set number

set ruler

set visualbell

set encoding=utf-8

set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:>

nnoremap j gj
nnoremap k gk
nnoremap L l
nnoremap H h
nnoremap l w
nnoremap h b

nnoremap <C-k> <C-u>
nnoremap <C-j> <C-d>

inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^

set hidden
set mouse=nicr
set ttyfast

set laststatus=2

set showmode
set showcmd

map <leader>q qgip

set listchars=tab:▸\ ,eol:¬

map <leader>l :set list!<CR>

set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
