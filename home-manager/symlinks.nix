{ config, lib, ... }:

{
  xdg.configFile = {
    "niri/config.kdl".source = ../modules/home-manager/niri/config.kdl;
    "starship.toml".source = ../modules/home-manager/starship/starship.toml;
    "ghostty/config".source = ../modules/home-manager/ghostty/config;
    # "hypr/hyprland.conf".source = ../modules/home-manager/hypr/hyprland.conf;
  };

  home.file = {
    "Pictures/wallpaper.jpg".source =
      ../modules/home-manager/niri/wallpaper.jpg;
    "ghostty/colors".text = " ";
  };
}
