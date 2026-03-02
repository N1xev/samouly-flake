{ pkgs, inputs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.monaspace
  ];

  environment.systemPackages = with pkgs; [
    (discord.override { withVencord = true; })
    inputs.sddm-stray.packages.${pkgs.stdenv.hostPlatform.system}.default
    git
    file-roller
    home-manager
    pulseaudio
    kitty
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
    ntfs3g
  ];
}
