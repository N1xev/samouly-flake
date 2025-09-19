{ pkgs, inputs, system, ... }:

{
home.packages = with pkgs; [

  # ------------------------
  # Command-line utilities
  # ------------------------
  nitch
  yazi                 # terminal file manager
  fzf                  # fuzzy finder
  file
  which
  tree
  gnused
  gnutar
  gawk
  zstd
  gnupg

  # ------------------------
  # System monitoring & tools
  # ------------------------
  btop                 # replacement of htop/nmon
  iotop                # IO monitoring
  iftop                # network monitoring
  strace               # system call monitoring
  ltrace               # library call monitoring
  lsof                 # list open files
  sysstat
  lm_sensors           # sensors
  ethtool
  pciutils             # lspci
  usbutils             # lsusb

  # ------------------------
  # Sway / Wayland utilities
  # ------------------------
  swaynotificationcenter
  swww
  swaybg
  fuzzel
  waybar
  waybar-mpris
  playerctl
  xwayland-satellite
  uwsm
  dbus

  # ------------------------
  # Nix utilities
  # ------------------------
  nixfmt-classic
  nix-output-monitor
  direnv

  # ------------------------
  # Productivity / docs
  # ------------------------
  hugo                 # static site generator
  glow                 # markdown previewer
  vhs
  freeze
  gemini-cli
  matugen

  # ------------------------
  # Development tools
  # ------------------------
  git
  neovim
  vscode
  ghostty
  wezterm
  vim                  # fallback editor
  fish
  wget

  # Go
  go
  gopls

  # Rust
  rustc
  cargo

  # C / C++
  cmake
  gcc

  # Web dev
  vercel-pkg
  nodejs
  bun
  cypress
  playwright-test

  # ------------------------
  # Fonts & theming
  # ------------------------
  nerd-fonts.fira-code
  nerd-fonts.geist-mono
  fira-code
  geist-font
  nwg-look
  gcr
  polkit_gnome

  # ------------------------
  # Multimedia & streaming
  # ------------------------
  obs-studio

  # ------------------------
  # Communication
  # ------------------------
  discord
  vesktop
  google-chrome

  # ------------------------
  # Inputs (flakes)
  # ------------------------
  inputs.zen-browser.packages."${system}".beta
  inputs.fabric.packages.${system}.default
  inputs.fabric.packages.${system}.run-widget
];
}
