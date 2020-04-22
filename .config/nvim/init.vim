" Plugins

call plug#begin()

Plug 'junegunn/goyo.vim'
Plug 'arcticicestudio/nord-vim'
" Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'preservim/nerdtree'

call plug#end()

" set hidden
" set nobackup
" set nowritebackup
" set updatetime=300
" set shortmess+=c
" set signcolumn=yes
set number relativenumber
colorscheme nord
" set inccommand=split
set backspace=indent,eol,start
" set noshowmode
" set noshowcmd
set tabstop=2
set shiftwidth=2
set expandtab

"" Nerd Tree
" let NERDTreeShowHidden=1
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" Airline
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
"
"" Coc autocompletion
"let g:coc_global_extensions = [
"  \ 'coc-tsserver',
"  \ 'coc-clangd',
"  \ 'coc-eslint'
"  \ ]
"
"if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
"  let g:coc_global_extensions += ['coc-eslint']
"endif
"
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"function! ShowDocIfNoDiagnostic(timer_id)
"  if (coc#util#has_float() == 0)
"    silent call CocActionAsync('doHover')
"  endif
"endfunction
"
"function! s:show_hover_doc()
"  call timer_start(500, 'ShowDocIfNoDiagnostic')
"endfunction
"
"autocmd CursorHoldI * :call <SID>show_hover_doc()
"autocmd CursorHold * :call <SID>show_hover_doc()

" Goyo (zen mode)
let g:goyo_linenr = 1
let g:goyo_width = 86

" Keymaps

" Set leader key
let mapleader="\<space>"

" Clear search on esc
noremap <silent> <Esc> :noh<cr><Esc>

" Autocompletion on ctrl + space
"inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

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

" Navigate between buffers
" noremap <leader>bp :bp<cr>
" noremap <leader>bn :bn<cr>
" noremap <leader>bd :bd<cr>

" Add semicolon to line end
noremap <leader>; A;<esc>

" Open nvim config file
noremap <leader>ce :vsplit ~/.config/nvim/init.vim<cr>

" Load nvim config file to running instance
noremap <leader>cl :source ~/.config/nvim/init.vim<cr>

" Search
" noremap <C-p> :Files<cr>
" noremap <leader>sb :Buffers<cr>

" Toggle nerd
" noremap <leader>f :NERDTreeToggle<cr>

" Toggle zen mode
noremap <silent> <leader>z :Goyo<cr>
