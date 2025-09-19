{ config, pkgs, ags, astal, system, ... }:

{
  home.packages = [
    ags.packages.${system}.default

    # astal core
    astal.packages.${system}.default

    # modules من astal
    astal.packages.${system}.hyprland
    astal.packages.${system}.mpris
    astal.packages.${system}.battery
    astal.packages.${system}.network
    astal.packages.${system}.bluetooth
    astal.packages.${system}.wireplumber
  ];
}
