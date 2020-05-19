" Vim Plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

" Plugins
call plug#begin()

Plug 'junegunn/goyo.vim'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" Default nvim configs
set number relativenumber
set colorcolumn=80
set backspace=indent,eol,start
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set smarttab
set expandtab
set splitbelow
set splitright
set nowrap
set noshowmode
set noshowcmd
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes
set history=1000
set autoread
set incsearch
set hlsearch
set ignorecase
set smartcase
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" Nord theme
colorscheme nord

" Ale linter
let g:ale_sign_column_always = 1

" Goyo (zen mode)
let g:goyo_linenr = 1
let g:goyo_width = 86

" Airline
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'nord'

" NERDTree
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let NERDTreeShowHidden = 1
let NERDTreeIgnore = ['^.git$']

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
noremap <leader>wh <C-w>h
noremap <leader>wj <C-w>j
noremap <leader>wk <C-w>k
noremap <leader>wl <C-w>l

" " Resize split
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

" Terminal Mode
tnoremap <Esc> <C-\><C-n>

" Toggle NERDTree
noremap <silent> <C-\> :NERDTreeToggle<Cr>

" Open fzf
noremap <C-p> :Files<Cr>

" Add a semicolon to line end
noremap <leader>; A;<Esc>

" Open this file in a split
noremap <leader>co :vsplit ~/.config/nvim/init.vim<Cr>

" Load the changes of this file
noremap <leader>cl :source ~/.config/nvim/init.vim<Cr>

" Toggle zen mode
noremap <silent> <leader>z :Goyo<Cr>

" Coc.nvim
inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> K :call <SID>show_documentation()<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
