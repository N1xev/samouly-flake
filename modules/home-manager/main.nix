{ ... }:

{
  imports = [
    ./packages.nix
    ./spotify.nix
    ./hypr/hyprland.nix
    ./ghostty/config.nix
    ./tmux/config.nix
    # ./widgetFrameworks.nix
    ./programs.nix
    ./theming
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "fish";
  };

  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
  ];

}
