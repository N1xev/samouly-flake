{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    home-manager
    kitty
    python3Full
    python313Packages.pip
    pipx
    ninja
    pkg-config
    cairo
    python313Packages.pycairo
    gobject-introspection
    glib
    glib.dev
    gobject-introspection.dev
  ];
}
