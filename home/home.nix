{ config, pkgs, ... }:

{
  home.stateVersion = "20.03";

  programs = {
    home-manager = {
      enable = true;
      path = "\$HOME/dev/dotfiles/home";
    };

    alacritty = {
      enable = true;
      settings = {
        env = {
          TERM = "xterm-256color";
          "WINIT_X11_SCALE_FACTOR" = "1.0";
        };

        shell = {
          program = "zsh";
          args = [ "--login" ];
        };

        font = {
          size = 10.5;
          normal = {
            family = "Hasklig";
            style = "Regular";
          };
        };

        mouse.hide_when_typing = true;

        colors = {
          primary = {
            background = "0x2E3440";
            foreground = "0xD8DEE9";
          };

          cursor = {
            text   = "0x2E3440";
            cursor = "0xD8DEE9";
          };

          normal = {
            black   = "0x3B4252";
            red     = "0xBF616A";
            green   = "0xA3BE8C";
            yellow  = "0xEBCB8B";
            blue    = "0x81A1C1";
            magenta = "0xB48EAD";
            cyan    = "0x88C0D0";
            white   = "0xE5E9F0";
          };

          bright = {
            black   = "0x4C566A";
            red     = "0xBF616A";
            green   = "0xA3BE8C";
            yellow  = "0xEBCB8B";
            blue    = "0x81A1C1";
            magenta = "0xB48EAD";
            cyan    = "0x8FBCBB";
            white   = "0xECEFF4";
          };
        };
      };
    };

    git = {
      enable = true;
      userName = "hss-mateus";
      userEmail = "hss-mateus@tuta.io";
      extraConfig.credential.helper = "store";
    };

    neovim = {
      enable = true;

      plugins = with pkgs.vimPlugins; [
        vim-polyglot
        auto-pairs
        nord-vim
        vim-airline
        vim-airline-themes
        coc-nvim
        fzf-vim
        nerdtree
      ];

      extraConfig = ''
        set number                     " Line number column
        set cursorline                 " Highlight current line
        set colorcolumn=100            " Show a vertical ruler in column 100
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

        " NERDTree
        let g:NERDTreeDirArrowExpandable = ' '
        let g:NERDTreeDirArrowCollapsible = ' '
        let NERDTreeShowHidden = 1
        let NERDTreeIgnore = ['^.git$']

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

        " Go to previous buffer
        noremap <leader><Tab> <C-^>

        " Go to normal mode in terminal mode
        tnoremap <Esc> <C-\><C-n>

        " Open fzf
        noremap <leader>ff :Files<Cr>

        " Toggle NERDTree
        noremap <silent> <leader>ft :NERDTreeToggle<Cr>

        " Add a semicolon to line end
        noremap <leader>; A;<Esc>

        " Trigger completion
        inoremap <silent><expr> <c-space> coc#refresh()
      '';
    };

    tmux = {
      enable = true;
      extraConfig = ''
        set-option -g default-terminal screen-256color

        set -g history-limit 10000

        set -g base-index 1
        set-option -g renumber-windows on

        set -s escape-time 0

        bind-key -n M-n new-window -c "#{pane_current_path}"
        bind-key -n M-1 select-window -t :1
        bind-key -n M-2 select-window -t :2
        bind-key -n M-3 select-window -t :3
        bind-key -n M-4 select-window -t :4
        bind-key -n M-5 select-window -t :5
        bind-key -n M-6 select-window -t :6
        bind-key -n M-7 select-window -t :7
        bind-key -n M-8 select-window -t :8
        bind-key -n M-9 select-window -t :9
        bind-key -n M-0 select-window -t :0

        bind-key -n M-. select-window -n
        bind-key -n M-, select-window -p

        bind-key -n M-< swap-window -t -1
        bind-key -n M-> swap-window -t +1

        bind-key -n M-X confirm-before "kill-window"

        bind-key -n M-- split-window -v -c "#{pane_current_path}"
        bind-key -n M-\\ split-window -h -c "#{pane_current_path}"
        bind-key -n M-v split-window -h -c "#{pane_current_path}"
        bind-key -n M-V split-window -v -c "#{pane_current_path}"

        bind-key -n M-R command-prompt -I "#W" "rename-window '%%'"

        bind-key -n M-f resize-pane -Z

        bind-key -n M-C-h resize-pane -L
        bind-key -n M-C-j resize-pane -D
        bind-key -n M-C-k resize-pane -U
        bind-key -n M-C-l resize-pane -R

        bind-key -n M-h select-pane -L
        bind-key -n M-l select-pane -R
        bind-key -n M-k select-pane -U
        bind-key -n M-j select-pane -D

        bind-key -n "M-H" run-shell 'old=`tmux display -p "#{pane_index}"`; tmux select-pane -L; tmux swap-pane -t $old'
        bind-key -n "M-J" run-shell 'old=`tmux display -p "#{pane_index}"`; tmux select-pane -D; tmux swap-pane -t $old'
        bind-key -n "M-K" run-shell 'old=`tmux display -p "#{pane_index}"`; tmux select-pane -U; tmux swap-pane -t $old'
        bind-key -n "M-L" run-shell 'old=`tmux display -p "#{pane_index}"`; tmux select-pane -R; tmux swap-pane -t $old'

        bind-key -n M-x confirm-before "kill-pane"

        set-option -g status-keys vi
        set-option -g set-titles on
        set-option -g set-titles-string 'tmux - #W'
        set-option -g visual-bell off

        setw -g mode-keys vi
        setw -g monitor-activity on

        set -g visual-activity on

        set -g status-left ""
        set -g status-right '%H:%M %d-%b-%y'

        set -g status-style fg=colour15
        set -g message-style fg=colour0,bg=colour3
        setw -g window-status-current-style fg=yellow,bold
        setw -g window-status-current-format ' #W '
        setw -g window-status-style fg=colour250
        setw -g window-status-format ' #W '
        setw -g window-status-bell-style fg=colour1
      '';
    };

    zathura = {
      enable = true;
      options = {
        default-bg                 = "#2E3440";
        default-fg                 = "#3B4252";
        statusbar-fg               = "#D8DEE9";
        statusbar-bg               = "#434C5E";
        inputbar-bg                = "#2E3440";
        inputbar-fg                = "#8FBCBB";
        notification-bg            = "#2E3440";
        notification-fg            = "#8FBCBB";
        notification-error-bg      = "#2E3440";
        notification-error-fg      = "#BF616A";
        notification-warning-bg    = "#2E3440";
        notification-warning-fg    = "#BF616A";
        highlight-color            = "#EBCB8B";
        highlight-active-color     = "#81A1C1";
        completion-bg              = "#3B4252";
        completion-fg              = "#81A1C1";
        completion-highlight-fg    = "#8FBCBB";
        completion-highlight-bg    = "#81A1C1";
        recolor-lightcolor         = "#2E3440";
        recolor-darkcolor          = "#ECEFF4";
        recolor                    = true;
        recolor-keephue            = false;
        statusbar-basename         = false;
      };
    };
  };

  services = {
    sxhkd = {
      enable = true;
      keybindings = {
        "super + Return"                  = "alacritty";
        "super + e"                       = "alacritty -e ranger";
        "super + d"                       = "dmenu_run -nb '#2e3440' -nf '#e5e9f0' -sb '#a3be8c' -sf '#2e3440' -fn 'Hasklig-10'";
        "super + b"                       = "firefox";
        "super + shift + {q,r}"           = "bspc {quit,wm -r}";
        "super + c"                       = "bspc node -c";
        "super + {t,@space,f}"            = "bspc node -t {tiled,floating,fullscreen}";
        "super + {_,shift + }{h,j,k,l}"   = "bspc node -{f,s} {west,south,north,east}";
        "super + {_,shift + }{1-9,0}"     = "bspc {desktop -f,node -d} '^{1-9,10}'";
        "super + alt + {h,j,k,l}"         = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
        "super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
        "super + {Left,Down,Up,Right}"    = "bspc node -v {-20 0,0 20,0 -20,20 0}";
        "super + p"                       = "scrot -e 'mv $f ~/Images/screenshots/'";
      };
    };

    polybar = {
      enable = true;
      script = "polybar default &";
      config = {
        "module/bspwm" = {
          type = "internal/bspwm";
          enable-click = false;
          enable-scroll = false;
          label-focused-foreground = "#d8dee9";
          label-occupied-foreground = "#4c566a";
          label-empty-foreground = "#2e3440";
        };

        "module/title" = {
          type = "internal/xwindow";
          format-foreground = "#d8dee9";
          label-maxlen = 80;
          label-empty = "Desktop";
        };

        "module/date" = {
          type = "internal/date";
          interval = 1;
          date = "%H:%M";
          date-alt = "%Y-%m-%d%";
        };

        "bar/default" = {
          wm-restack = "bspwm";
          padding = 1;
          background = "#2e3440";
          foreground = "#d8dee9";
          font-0 = "Hasklig:pixelsize=11";
          modules-left = "bspwm";
          modules-center = "title";
          modules-right = "date";
        };
      };
    };
  };

  xsession = {
    enable = true;
    windowManager.bspwm = {
      enable = true;
      monitors.VGA-0 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
      rules = {
        Emacs.state = "tiled";
        Zathura.state = "tiled";
      };
      settings = {
        focus_follows_pointer = true;
        border_width = 0;
        window_gap = 0;
      };
    };
  };
}
