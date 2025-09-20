{ config, pkgs, ... }:

{
  home.username = "samouly";
  home.homeDirectory = "/home/samouly";

  imports = [ ../modules/home-manager/main.nix ./symlinks.nix ];

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  nixpkgs.overlays = [
      (final: prev: {
        material-symbols = prev.material-symbols.overrideAttrs (oldAttrs: {
          version = "4.0.0-unstable-2025-04-11";

          src = final.fetchFromGitHub {
            owner = "google";
            repo = "material-design-icons";
            rev = "941fa95d7f6084a599a54ca71bc565f48e7c6d9e";
            hash = "sha256-5bcEh7Oetd2JmFEPCcoweDrLGQTpcuaCU8hCjz8ls3M=";
            sparseCheckout = [ "variablefont" ];
          };
        });
      })
    ];

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.theme" = "Bibata-Modern-Ice";
    "Xcursor.size" = 25;
    "Xft.dpi" = 172;
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;

    name = "Bibata-Modern-Ice";

    size = 25;

    package = pkgs.bibata-cursors;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Ice";
      package = pkgs.bibata-cursors;
    };
  };
  # Packages that should be installed to the user profile.

  programs.git = {
    enable = true;
    userName = "N1xev";
    userEmail = "alasamouly@gmail.com";
  };

  # starship - an customizable prompt for any shell
  programs.starship = { enable = true; };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
    shellAliases = { k = "kubectl"; };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = { common = { default = [ "gtk" ]; }; };
  };

  services.gnome-keyring.enable = true;

  home.stateVersion = "25.05";
}
