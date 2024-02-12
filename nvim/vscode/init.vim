set nocompatible " be iMproved, required
filetype off  " required
syntax on "właczony syntax     
set number "włączone numerowanie
set relativenumber
set hidden
set ttimeoutlen=0
filetype plugin indent on    
set background=dark
set ts=4 sw=4 et

"nie wyświetla alertu dla whitespaceu
let g:python_highlight_space_errors = 0


"------------------------------------------------------------------------------------------------

"Skrót do przemieszczania bloku kodu 

nnoremap J :m .+1<CR>==
nnoremap K :m .-2<CR>==
inoremap J <Esc>:m .+1<CR>==gi
inoremap K <Esc>:m .-2<CR>==gi
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"Skróty Coc-nvim autocomplete
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#next(1) : "\<S-Tab>"
inoremap <expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<TAB>"


