{ config, pkgs, quickshell, system, ... }:

{
  home.packages = [
    quickshell.packages.${system}.default

  ];

}
