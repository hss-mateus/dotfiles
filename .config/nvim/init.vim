" Plugins
call plug#begin()

Plug 'junegunn/goyo.vim'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" Default nvim configs
set number relativenumber
set colorcolumn=80
set backspace=indent,eol,start
set tabstop=2
set shiftwidth=2
set expandtab
set splitbelow
set splitright
set nowrap
set noshowmode
set noshowcmd

" Set 4 identation spaces in c files
au FileType c set tabstop=4
au FileType c set shiftwidth=4

" Gruvbox theme
let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox

" Ale linter
let g:ale_sign_column_always = 1

" Goyo (zen mode)
let g:goyo_linenr = 1
let g:goyo_width = 86

" Airline
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'minimalist'

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

" Move through tabs
noremap <leader>1 1gt<Cr>
noremap <leader>2 2gt<Cr>
noremap <leader>3 3gt<Cr>
noremap <leader>4 4gt<Cr>
noremap <leader>5 5gt<Cr>
noremap <leader>6 6gt<Cr>
noremap <leader>7 7gt<Cr>
noremap <leader>8 8gt<Cr>
noremap <leader>9 9gt<Cr>
noremap <leader>0 10gt<Cr>

" Add a semicolon to line end
noremap <leader>; A;<Esc>

" Open this file in a split
noremap <leader>co :vsplit ~/.config/nvim/init.vim<Cr>

" Load the changes of this file
noremap <leader>cl :source ~/.config/nvim/init.vim<Cr>

" Toggle zen mode
noremap <silent> <leader>z :Goyo<Cr>

" Open a terminal buffer
noremap <silent> <leader>ts :split term://zsh<Cr>i
noremap <silent> <leader>tv :vsplit term://zsh<Cr>i

" Open the SML REPL
au FileType sml noremap <silent> <leader>ts :split term://zsh<Cr>isml<Cr>val _ = OS.Process.system "clear";<Cr>
au FileType sml noremap <silent> <leader>tv :vsplit term://zsh<Cr>isml<Cr>val _ = OS.Process.system "clear";<Cr>
