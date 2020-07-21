{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      vim-polyglot
      auto-pairs
      base16-vim
      vim-airline
      vim-airline-themes
      coc-nvim
      fzf-vim
      nerdtree
      vim-endwise
      vim-sensible
      vim-commentary
      vim-surround
    ];

    extraConfig = ''
      set number                     " Line number column
      set cursorline                 " Highlight current line
      set termguicolors              " Highlight the background and foreground
      set colorcolumn=80             " Show a vertical ruler in column 80
      set expandtab                  " Use spaces instead of tabs
      set tabstop=2                  " 2 spaces in a tab
      set softtabstop=2              " How far cursor moves while typing tab
      set shiftwidth=2               " Size of auto indentation
      set smartindent                " Auto-indent new lines
      set nowrap                     " Don't wrap text
      set noshowmode                 " Dont show current mode in command line
      set noshowcmd                  " Don't show keys pressed in command line
      set hidden                     " Load multiple buffers in background
      set updatetime=300             " Update each 300ms, for better auto-completion response
      set shortmess+=c               " Remove ins-completion-menu messages
      set signcolumn=yes             " Enable sign column to display errors and warnings
      set ignorecase                 " Ignore case in search
      set smartcase                  " Don't ignore case if search have upper case

      " Theme
      colorscheme base16-onedark

      " Airline
      let g:airline_powerline_fonts = 1
      let g:airline_theme = 'onedark'

      " NERDTree
      let g:NERDTreeDirArrowExpandable = ' '
      let g:NERDTreeDirArrowCollapsible = ' '
      let NERDTreeShowHidden = 1
      let NERDTreeIgnore = ['^.git$']

      "" Keybindings

      " Leader key
      let mapleader = "\<Space>"

      " Command mode with ;
      noremap ; :

      " Clear search highlight on esc
      noremap <silent> <Esc> :noh<Cr><Esc>

      " Remove arrows
      noremap <Down> <Nop>
      noremap <Left> <Nop>
      noremap <Right> <Nop>
      noremap <Up> <Nop>

      " Split window
      noremap <leader>ws <C-w>s
      noremap <leader>wv <C-w>v<C-w>l

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

      " Go to most recent buffer
      noremap <leader><Tab> <C-^>

      " Go to previous and next buffer
      noremap <leader>bp :bp<Cr>
      noremap <leader>bn :bn<Cr>

      " Switch to buffer interactively
      noremap <leader>bb :Buffers<Cr>

      " Find project files
      noremap <leader><leader> :Files<Cr>

      " Toggle NERDTree
      noremap <silent> <leader>ft :NERDTreeToggle<Cr>

      " Add a semicolon to line end
      noremap <leader>; A;<Esc>

      " Trigger completion
      inoremap <silent><expr> <c-space> coc#refresh()
    '';
  };
}
