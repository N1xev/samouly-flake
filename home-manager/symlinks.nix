{ config, lib, ... }:

{
  xdg.configFile = {
  "niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink ~/Projects/flakey/modules/home-manager/niri/config.kdl;
  "fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink ~/Projects/flakey/modules/home-manager/fish/config.fish;
  "starship.toml".source = config.lib.file.mkOutOfStoreSymlink ~/Projects/flakey/modules/home-manager/starship/starship.toml;
  "ghostty/config".source = config.lib.file.mkOutOfStoreSymlink ~/Projects/flakey/modules/home-manager/ghostty/config;
  "waybar/".source = config.lib.file.mkOutOfStoreSymlink ~/Projects/flakey/modules/home-manager/waybar;
  };

  home.file = {
  "Pictures/wallpaper.jpg".source = ../modules/home-manager/niri/wallpaper.jpg;
  };
}