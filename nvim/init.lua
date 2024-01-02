require("packages")
require("utils")

vim.cmd [[
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

set foldmethod=indent
set foldnestmax=10
set foldlevel=2
set nofoldenable

highlight Comment ctermfg=040
highlight Visual cterm=none ctermbg=239 ctermfg=NONE

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
]]

-- Set relative line number
vim.wo.relativenumber = true

if vim.g.vscode then
  -- https://github.com/vscode-neovim/vscode-neovim/issues/298
  vim.opt.clipboard:append("unnamedplus")
end

nmap("<C-j>", "<C-d>")
nmap("<C-k>", "<C-u>")

-- Copy selection to system clipboard
vmap("<C-c>", '"+y<CR>')

-- clear search highlight
nmap("<Esc><Esc>", ":let @/=\"\"<CR>")

-- Open Explorer tab
nmap("<C-\\>", "<Esc>:Le<CR>")

-- Switch tab
nmap("<C-h>", ":tabprevious<CR>")
nmap("<C-l>", ":tabnext<CR>")

-- tab on select
vmap("<Tab>", ">gv")
vmap("<S-Tab>", "<gv")

-- Move lines up and down
nmap("<A-j>", ":m .+1<CR>==")
nmap("<A-k>", ":m .-2<CR>==")
vmap("<A-j>", ":m '>+1<CR>gv=gv")
vmap("<A-k>", ":m '<-2<CR>gv=gv")

