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
                    set -g @continuum-save-interval '5'
          set -g @plugin 'vaaleyard/tmux-dotbar'

          set -g @tmux-dotbar-fg "brightblack"
          set -g @tmux-dotbar-bg "default"
          set -g @tmux-dotbar-fg-current "blue"
          set -g @tmux-dotbar-fg-session "brightblack"
          set -g @tmux-dotbar-fg-prefix "blue"
          set -g @tmux-dotbar-position "bottom"
          set -g @tmux-dotbar-justify "absolute-centre"
          set -g @tmux-dotbar-left "true"
          # set -g @tmux-dotbar-status-left "#S" # see code
          set -g @tmux-dotbar-right "true"
          set -g @tmux-dotbar-status-right "#[bold] %H:%M " # see code
          set -g @tmux-dotbar-window-status-format "#[bold] #W "
          set -g @tmux-dotbar-window-status-separator " • "
          set -g @tmux-dotbar-maximized-icon "󰊓"
          set -g @tmux-dotbar-show-maximized-icon-for-all-tabs true

          set -g pane-active-border-style "fg=blue"
          set -g pane-border-style "fg=black"

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
