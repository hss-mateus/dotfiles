" Plugins
call plug#begin()

Plug 'junegunn/goyo.vim'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
Plug 'morhetz/gruvbox'

call plug#end()

" Default nvim configs
set number relativenumber       " Show relative number column
set colorcolumn=80              " Show a vertical ruler in column 80
set backspace=indent,eol,start  " Set backspace to work properly
set tabstop=2                   " Set tab size to 2 spaces
set expandtab                   " Use spaces to insert a tab
set shiftwidth=2                " Set auto identation to 2 spaces
set splitright                  " Always vslpit on the right

" Gruvbox theme
let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox

" Ale linter
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '▲'

" Goyo (zen mode)
let g:goyo_linenr = 1
let g:goyo_width = 86

"" Keybindings

" Set leader key
let mapleader = "\<Space>"

" Clear search highlight on esc press
noremap <silent> <Esc> :noh<Cr><Esc>

" Remove arrows in normal, visual and select mode
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>

" Remove arrows in insert mode
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>

" Split window
noremap <leader>s <C-w>s
noremap <leader>v <C-w>v<C-w>l

" Move through splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Resize split
noremap <M-h> <C-w><
noremap <M-j> <C-w>+
noremap <M-k> <C-w>-
noremap <M-l> <C-w>>

" Add a semicolon to line end
noremap <leader>; A;<Esc>

" Open this file in a split
noremap <leader>co :vsplit ~/.config/nvim/init.vim<Cr>

" Load the changes of this file
noremap <leader>cl :source ~/.config/nvim/init.vim<Cr>

" Toggle zen mode
noremap <silent> <leader>z :Goyo<Cr>


" Open the SML REPL
au FileType sml noremap <silent> <leader>t :vsplit term://zsh<Cr>isml<Cr>val _ = OS.Process.system "clear";<Cr>
