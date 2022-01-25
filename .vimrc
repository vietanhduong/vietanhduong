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

" fold setting
" z + o -> open a fold at the cursor
" z shift + o -> open all folds at the cursor
" z + c -> closes a fold at the cursor
" z shift + m -> closes all open folds
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2

" color scheme setting
colorscheme ron 

" change line number color
" highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" hook set comment color is green
highlight Comment ctermfg=Green

" visual color
highlight Visual cterm=bold ctermbg=239 ctermfg=NONE

nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

vnoremap <C-c> "+y<CR>
