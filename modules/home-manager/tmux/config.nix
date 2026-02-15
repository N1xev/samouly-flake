{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = rose-pine;
        extraConfig = ''
          # ┌──────────────────────────┐
          # │                          │
          # │     ░▀█▀░█▄█░█░█░█░█     │
          # │     ░░█░░█░█░█░█░▄▀▄     │
          # │     ░░▀░░▀░▀░▀▀▀░▀░▀     │
          # │                          │
          # └──────────────────────────┘
          set -g status-interval 1

          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '1'
          # Pane border
          setw -g pane-border-status bottom
          set -g pane-border-format "#[align=centre]#{?pane_active,#[bold],#[fg=black,bg=default]} #{pane_index} • #{?pane_active,#[bold],#[fg=black,bg=default]}#{pane_current_command} "
          setw -g pane-border-lines single

          # Left vacío (ventanas a la izquierda)
          set -g status-left ""

          # Right: hora y estado del cliente
          # set -g status-right "#[fg=black bg=default]│#[fg=white bg=black] %H:%M #[bg=default fg=brightblack]┃#[fg=green bg=brightblack]   "

          set -g status-right "#[fg=white bg=default] #S #[fg=brightblack bg=default]•#{?pane_in_mode,#[bold fg=yellow]#[bg=default]  ,#{?window_zoomed_flag,#[bold fg=cyan]#[bg=default]  ,#{?client_prefix,#[bold fg=red]#[bg=default]  ,#[bold fg=blue]#[bg=default]  }}}"

          # Estilo general
          set -g status-style bg=default
          set -g pane-active-border-style "fg=brightblack"
          set -g pane-border-style "fg=black"

          # Ventanas: solo índice
          set -g window-status-format "#[fg=white bg=default] #I "
          set -g window-status-current-format "#[fg=red bg=default bold] #I "

          # Ventanas alineadas a la izquierda
          set -g status-justify "left"

          # Set default shell
          set-option -g default-shell /home/samouly/.nix-profile/bin/fish

          # Set true color
          set-option -sa terminal-overrides ",xterm*:Tc"

          # Set mouse mode on
          set -g mouse on

          # Set prefix
          unbind C-b
          set -g prefix C-Space
          bind C-Space send-prefix

          # Shift Alt vim keys to switch windows
          bind -n M-H previous-window
          bind -n M-L next-window

          # Start window numbering at 1
          set -g base-index 1
          setw -g pane-base-index 1
          set-window-option -g pane-base-index 1
          set-option -g renumber-windows on

          set -g @plugin 'tmux-plugins/tpm'
          set -g @plugin 'tmux-plugins/tmux-sensible'
          set -g @plugin 'christoomey/vim-tmux-navigator'
          set -g @plugin 'tmux-plugins/tmux-yank'
          # source-file ~/.config/tmux/chadmux.conf
          # source-file ~/.config/tmux/dotbar.conf

          # Set vi-mode
          set-window-option -g mode-keys vi

          # Yazi
          set -g allow-passthrough on

          set -ga update-environment TERM
          set -ga update-environment TERM_PROGRAM

          # Keybindings
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

          # Open panes in current directory
          bind - split-window -c '#{pane_current_path}'
          bind / split-window -h -c '#{pane_current_path}'

          run '~/.tmux/plugins/tpm/tpm'
        '';
      }
    ];
  };
}
