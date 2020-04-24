" Plugins

call plug#begin()

Plug 'junegunn/goyo.vim'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'

call plug#end()

set number relativenumber
let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox
set backspace=indent,eol,start
set tabstop=2
set shiftwidth=2
set expandtab

" Goyo (zen mode)
let g:goyo_linenr = 1
let g:goyo_width = 86

" Keymaps

" Set leader key
let mapleader="\<space>"

" Clear search on esc
noremap <silent> <Esc> :noh<cr><Esc>

" Remove arrows in Insert and Command Mode
noremap! <Down> <Nop>
noremap! <Left> <Nop>
noremap! <Right> <Nop>
noremap! <Up> <Nop>

" Remove arrows in Normal, Visual and Select Mode
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>

" Split window
noremap <leader>wv <C-w>v<C-w>l
noremap <leader>ws <C-w>s

" Change to split
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Resize split
noremap <M-h> <C-w><
noremap <M-j> <C-w>+
noremap <M-k> <C-w>-
noremap <M-l> <C-w>>

" Add semicolon to line end
noremap <leader>; A;<esc>

" Open nvim config file
noremap <leader>ce :vsplit ~/.config/nvim/init.vim<cr>

" Load nvim config file to running instance
noremap <leader>cl :source ~/.config/nvim/init.vim<cr>

" Toggle zen mode
noremap <silent> <leader>z :Goyo<cr>
