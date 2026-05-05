{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "xterm-256color";
    historyLimit = 10000;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
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
      {
        plugin = pkgs.tmuxPlugins.mkTmuxPlugin {
          pluginName = "tmux-dotbar";
          version = "unstable-2025-04-30";
          src = pkgs.fetchFromGitHub {
            owner = "vaaleyard";
            repo = "tmux-dotbar";
            rev = "main";
            sha256 = "0k5pcyrd5iisbsg6vmsglsma44gabk8d3rn4bcz23algk5x4m92r";
          };
          postInstall = ''
            ln -s $out/share/tmux-plugins/tmux-dotbar/dotbar.tmux \
                  $out/share/tmux-plugins/tmux-dotbar/tmux_dotbar.tmux
          '';
        };
        extraConfig = ''
          set -g @tmux-dotbar-position "bottom"
          set -g @tmux-dotbar-justify "absolute-centre"
          set -g @tmux-dotbar-left "true"
          set -g @tmux-dotbar-right "true"

          # Use terminal colors (no hardcoded bg)
          set -g @tmux-dotbar-bg "default"
          set -g @tmux-dotbar-fg "brightblack"
          set -g @tmux-dotbar-fg-current "white"
          set -g @tmux-dotbar-fg-session "brightblack"
          set -g @tmux-dotbar-fg-prefix "cyan"

          set -g @tmux-dotbar-status-right "#[fg=white bg=default] #I#[fg=brightblack ]#{?pane_in_mode,#[bold fg=yellow]  ,#{?window_zoomed_flag,#[bold fg=cyan]#[bg=default]  ,#{?client_prefix,#[bold fg=red]#[bg=default]  ,#[bold fg=blue]#[bg=default]  }}}"
          set -g @tmux-dotbar-window-status-format "#[bold]●"
          set -g @tmux-dotbar-window-status-separator " "
          set -g @tmux-dotbar-maximized-icon " "
          set -g @tmux-dotbar-show-maximized-icon-for-all-tabs true
        '';
      }
    ];
    extraConfig = ''
      # General Settings
      set -g status-interval 1
      set -g mouse on
      set -g allow-passthrough on
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -sa terminal-features ",*:RGB"
      # Keybindings
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix
      bind -n M-H previous-window
      bind -n M-L next-window
      set -g pane-border-status off
      set -g pane-border-style "fg=brightblack"
      set -g pane-active-border-style "fg=brightblack"
      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind - split-window -c '#{pane_current_path}'
      bind / split-window -h -c '#{pane_current_path}'
      bind X if-shell '[ #{session_windows} -gt 1 ]' 'kill-window' 'new-window \; kill-window -t #{window_id}:-1'
    '';
  };
}
