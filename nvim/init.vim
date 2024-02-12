set nocompatible " be iMproved, required
filetype off  " required
syntax on "właczony syntax     
set number "włączone numerowanie
set relativenumber
set hidden
set ttimeoutlen=0
call plug#begin('~/.config/nvim/plugged')
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'tanvirtin/monokai.nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'neoclide/coc.nvim'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'tribela/vim-transparent'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'preservim/tagbar'
Plug 'tpope/vim-commentary'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'mattn/emmet-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'fedepujol/move.nvim'
Plug 'epwalsh/obsidian.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-lua/plenary.nvim'
call plug#end()            
filetype plugin indent on    
colorscheme gruvbox-material 
set background=dark
set ts=4 sw=4 et

"nie wyświetla alertu dla whitespaceu
let g:python_highlight_space_errors = 0


"------------------------------------------------------------------------------------------------
"SKRÓTY KLAWISZOWE
"zapisuje ctrl+s
nnoremap <C-s> :w<CR>
"wychodzi 
nnoremap <C-q> :q<CR>
"kopiuje Ctrl+c w trybie visual
vnoremap <C-c> :y<CR>
"Zaznacza wszystko
map <C-a> <esc>ggVG<CR>

"Skrót F9 uruchamia kod pythona
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!clear;python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!clear;python3' shellescape(@%, 1)<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"Skróty klawiszowe dla NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

"Skrót dla Tagbar
nmap <F8> :TagbarToggle<CR>

"Skrót do przemieszczania bloku kodu 
nnoremap J :MoveLine(1)<CR>
nnoremap K :MoveLine(-1)<CR>
vnoremap J :MoveBlock(1)<CR>
vnoremap K :MoveBlock(-1)<CR>

"Skróty Coc-nvim autocomplete
" inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#next(1) : "\<S-Tab>"
" inoremap <expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<TAB>"






nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"------------------------------------------------------------------------------------------------



lua << EOF
require("nvim-treesitter.configs").setup({
    ensure_installed = { "javascript", "python", "lua", "vim", "json", "html", "tsx", "markdown" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        disable = {"css"},
    },
})
EOF

lua << EOF
require("obsidian").setup({
    workspaces = {
    {
      name = "Notatki Zettelkasten",
      path = "~/Documents/Osobiste/Notatki Zettelkasten",
    },
    },
    templates = {
      subdir = "all/template",
    },
    daily_notes = {
        date_format = "%Y%m%d%H%M",
    },
   disable_frontmatter = true,

})
EOF
set conceallevel=1

lua << EOF
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}
EOF


lua << EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
     mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping({
                c = function()
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    else
                        vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                    end
                end,
                i = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    else
                        fallback()
                    end
                end
            }),
            ['<C-p>'] = cmp.mapping({
                c = function()
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                    else
                        vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
                    end
                end,
                i = function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                    else
                        fallback()
                    end
                end
            }),
                ['<Tab>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    }),
  })

EOF
