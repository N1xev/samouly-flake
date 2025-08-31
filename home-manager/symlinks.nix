{ config, lib, ... }:

{
  xdg.configFile = {
  "niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink ~/Projects/flakey/modules/home-manager/niri/config.kdl;
  # "kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink ~/Projects/flakey/modules/home-manager/kitty/kitty.conf;
  "fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink ~/Projects/flakey/modules/home-manager/fish/config.fish;
  "starship.toml".source = config.lib.file.mkOutOfStoreSymlink ~/Projects/flakey/modules/home-manager/starship/starship.toml;
  "ghostty/config.toml".source = config.lib.file.mkOutOfStoreSymlink ~/Projects/flakey/modules/home-manager/ghostty/config.toml;
    # "nvim/".source = config.lib.file.mkOutOfStoreSymlink ~/Projects/flakey/modules/home-manager/nvim;
  };

  home.file = {
  "Pictures/wallpaper.jpg".source = ../modules/home-manager/niri/wallpaper.jpg;
  };
}