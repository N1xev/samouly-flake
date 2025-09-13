{ config, lib, ... }:

{
  xdg.configFile = {
    "niri/config.kdl".source = ../modules/home-manager/niri/config.kdl;
    "fish/config.fish".source = ../modules/home-manager/fish/config.fish;
    "starship.toml".source = ../modules/home-manager/starship/starship.toml;
    "ghostty/config".source = ../modules/home-manager/ghostty/config;
    "waybar/".source = ../modules/home-manager/waybar;
  };

  home.file = {
    "Pictures/wallpaper.jpg".source =
      ../modules/home-manager/niri/wallpaper.jpg;
  };
}
