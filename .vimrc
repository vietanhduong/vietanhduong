syntax on
set tabstop=2
set shiftwidth=2
set expandtab
set ai
set number
set hlsearch
set ruler
set backspace=indent,eol,start

set pastetoggle=<F3>

colorscheme ron 

" change line number color
" highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" hook set comment color is green
highlight Comment ctermfg=Green

" visual color
highlight Visual cterm=bold ctermbg=236 ctermfg=NONE

" map Ctrl + h i j k to switch panel
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
