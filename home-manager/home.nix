{ pkgs, username, ... }:

{
  imports = [
    ../modules/home-manager/main.nix
    ./symlinks.nix
  ];

  theming.enable = true;

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

  services.gnome-keyring.enable = true;
  services.swaync.enable = false;

  home.stateVersion = "26.05";
}
