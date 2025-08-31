{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
  programs.niri.package = pkgs.niri-unstable;
  programs.niri.enable = true;
}