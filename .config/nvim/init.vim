" Setup vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

" Plugins
call plug#begin()

" Syntax highlight
Plug 'sheerun/vim-polyglot'

" Pairs completion
Plug 'jiangmiao/auto-pairs'

" Color theme
Plug 'arcticicestudio/nord-vim'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" LSP support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" Basic nvim settings
set number                     " Line number column
set cursorline                 " Highlight current line
set backspace=indent,eol,start " Make backspace work decently
set expandtab                  " Use spaces instead of tabs
set tabstop=2                  " 2 spaces in a tab
set softtabstop=2              " How far cursor moves while typing tab
set autoindent                 " Enable auto-indentation
set shiftwidth=2               " Size of auto indentation
set smartindent                " Auto-indent new lines
set smarttab                   " Auto-indent line when tab is pressed at the beginning
set splitbelow                 " Open new vertial splits below
set splitright                 " Open new splits at the right
set nowrap                     " Don't wrap text
set noshowmode                 " Dont show current mode in command line
set noshowcmd                  " Don't show keys pressed in command line
set hidden                     " Load multiple buffers in background
set updatetime=300             " Update each 300ms, for better auto-completion response
set shortmess+=c               " Remove ins-completion-menu messages
set signcolumn=yes             " Enable sign column to display errors and warnings
set history=1000               " Set command history to 1000
set autoread                   " Reload file contents when edited in other place
set ignorecase                 " Ignore case in search
set smartcase                  " Don't ignore case if search have upper case
set scrolloff=8                " Scroll before the cursor hits the last line
set sidescrolloff=15           " Same but horizontally

" Theme
colorscheme nord

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'nord'

"" Keybindings

" Leader key
let mapleader = "\<Space>"

" Clear search highlight on esc
noremap <silent> <Esc> :noh<Cr><Esc>

" Remove arrows
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>

" Split window
noremap <leader>s <C-w>s
noremap <leader>v <C-w>v<C-w>l

" Move through splits
noremap <leader>wh <C-w>h
noremap <leader>wj <C-w>j
noremap <leader>wk <C-w>k
noremap <leader>wl <C-w>l

" Resize split
noremap <C-h> <C-w><
noremap <C-k> <C-w>+
noremap <C-j> <C-w>-
noremap <C-l> <C-w>>

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

" Go to normal mode in terminal mode
tnoremap <Esc> <C-\><C-n>

" Open fzf
noremap <C-p> :Files<Cr>

" Add a semicolon to line end
noremap <leader>; A;<Esc>

" Trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
