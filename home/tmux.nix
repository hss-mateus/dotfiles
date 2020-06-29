{
  programs.tmux = {
    enable = true;
    extraConfig = ''
        set -g default-terminal screen-256color
        set -ga terminal-overrides ,*256col*:Tc

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
}
