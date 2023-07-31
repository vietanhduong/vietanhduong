call plug#begin()
Plug 'hashivim/vim-terraform'
Plug 'chaoren/vim-wordmotion'
call plug#end()

syntax on
set tabstop=2
set shiftwidth=2
set expandtab
set ai
set number
set hlsearch
set ruler
set backspace=indent,eol,start
set mouse=a
set pastetoggle=<F3>
set bg=dark
set t_Co=256
set laststatus=2

" fold setting
" z + o -> open a fold at the cursor
" z shift + o -> open all folds at the cursor
" z + c -> closes a fold at the cursor
" z shift + m -> closes all open folds
set foldmethod=indent
set foldnestmax=10
set foldlevel=2
set nofoldenable

" color scheme setting

" change line number color
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" hook set comment color is green
highlight Comment ctermfg=Green

" visual color
highlight Visual cterm=none ctermbg=239 ctermfg=NONE

nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

" remap ctrl + c to copy select to clipboard
vnoremap <C-c> "+y<CR>

" remap clear search hight light
nnoremap <silent> <Esc><Esc> :let @/=""<CR>

" remap open explorer tab
nnoremap <C-\> <Esc>:Le<CR>

" remap switch tab
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" delete without yanking
" nnoremap d "_d
" vnoremap d "_d

" replace currently selected text with default register
" without yanking it
vnoremap p "_dP

" tab on select
vmap <Tab> >gv
vmap <S-Tab> <gv

" highlight trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" move lines
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv
