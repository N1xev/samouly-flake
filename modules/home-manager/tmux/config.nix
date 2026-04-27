{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "screen-256color";
    historyLimit = 10000;

    plugins = with pkgs.tmuxPlugins; [
      rose-pine
      sensible
      vim-tmux-navigator
      yank
      # this is the mf saver
      resurrect
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5'
          set -g @plugin 'sandudorogan/tmux-pane-tree'
          set -g @tmux_pane_tree_install_agent_hooks 1
        '';
      }
    ];

    extraConfig = ''
      # General Settings
      set -g status-interval 1
      set -g mouse on
      set -g allow-passthrough on
      set-option -sa terminal-overrides ",xterm*:Tc"

      # Pane border
      setw -g pane-border-status bottom
      set -g pane-border-format "#[align=centre]#{?pane_active,#[bold],#[fg=black,bg=default]} #{pane_index} • #{?pane_active,#[bold],#[fg=black,bg=default]}#{pane_current_command} "
      setw -g pane-border-lines single

      # Status Bar Styling
      set -g status-left ""
      set -g status-right "#[fg=white bg=default] #S #[fg=brightblack bg=default]•#{?pane_in_mode,#[bold fg=yellow]#[bg=default]  ,#{?window_zoomed_flag,#[bold fg=cyan]#[bg=default]  ,#{?client_prefix,#[bold fg=red]#[bg=default]  ,#[bold fg=blue]#[bg=default]  }}}"
      set -g status-style bg=default
      set -g pane-active-border-style "fg=brightblack"
      set -g pane-border-style "fg=black"
      set -g window-status-format "#[fg=white bg=default] #I:#W "
      set -g window-status-current-format "#[fg=red bg=default bold] #I:#W "
      set -g status-justify "left"

      # Keybindings
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix
      bind -n M-H previous-window
      bind -n M-L next-window

      set -g base-index 1
      setw -g pane-base-index 1
      set-option -g renumber-windows on

      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind - split-window -c '#{pane_current_path}'
      bind / split-window -h -c '#{pane_current_path}'
      bind X if-shell '[ #{session_windows} -gt 1 ]' 'kill-window' 'new-window \; kill-window -t #{window_id}:-1'

      # External Theme
      if-shell "test -f ~/.cache/matugen/tmux.theme" "source-file ~/.cache/matugen/tmux.theme"
    '';
  };
}
