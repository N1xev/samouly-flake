{ ... }:

{
  imports = [
    ./packages.nix
    # other imports goes here
    ./spotify.nix
  ];

  # Session Variables
  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "fish";
  };

  # Extend PATH cleanly
  home.sessionPath = [ "$HOME/.cargo/bin" "$HOME/.local/bin" ];

}
