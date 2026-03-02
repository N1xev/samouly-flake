{ pkgs, username, ... }:

{
  imports = [
    ../modules/home-manager/main.nix
    ./symlinks.nix
  ];

  theming.enable = true;

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

  fonts.fontconfig.enable = true;

  xresources.properties = {
    "Xcursor.theme" = "Bibata-Modern-Ice";
    "Xcursor.size" = 25;
    "Xft.dpi" = 172;
  };

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    pointerCursor = {
      x11.enable = true;
      gtk.enable = true;

      name = "Bibata-Modern-Ice";
      size = 25;
      package = pkgs.bibata-cursors;
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Ice";
      package = pkgs.bibata-cursors;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common = {
        default = [ "gtk" ];
      };
    };
  };
  # systemd.user.services.polkit-gnome-authentication-agent-1 = {
  #   Unit = {
  #     Description = "polkit-gnome-authentication-agent-1";
  #     Wants = [ "graphical-session.target" ];
  #     After = [ "graphical-session.target" ];
  #   };
  #   Service = {
  #     Type = "simple";
  #     ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #     Restart = "on-failure";
  #     RestartSec = 1;
  #     TimeoutStopSec = 10;
  #   };
  #   Install = {
  #     WantedBy = [ "graphical-session.target" ];
  #   };
  # };

  services.gnome-keyring.enable = true;
  services.swaync.enable = true;

  home.stateVersion = "25.05";
}
