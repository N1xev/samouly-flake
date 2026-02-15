{
  pkgs,
  inputs,
  system,
  ...
}:
{
  home.packages = with pkgs; [
    # ------------------------
    # Command-line utilities
    # ------------------------
    nitch
    yazi
    fzf
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    ntfs3g
    unzip
    lazygit
    ripgrep
    # ------------------------
    # System monitoring & tools
    # ------------------------
    btop
    iotop
    iftop
    strace
    ltrace
    lsof
    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils
    procps
    iw
    wirelesstools
    khal
    libnotify
    lutris
    heroic
    bottles
    mangohud
    goverlay
    protontricks
    protonup-qt
    steam-run
    steam
    gamemode
    gamescope
    mpv
    vlc

    # ------------------------
    # Sway / Wayland utilities
    # ------------------------
    swww
    swaybg
    waybar
    fuzzel
    swaylock
    wl-clipboard
    wl-screenrec
    ffmpeg
    xdg-desktop-portal-wlr
    playerctl
    xwayland-satellite
    bluetui
    pavucontrol
    pamixer
    slurp
    uwsm
    dbus
    gtk4
    gtk4-layer-shell
    nwg-icon-picker
    wayland
    wayland-protocols
    wayland-scanner
    brightnessctl
    cliphist
    grimblast
    papirus-icon-theme
    gimp
    # ------------------------
    # Nix utilities
    # ------------------------
    nixfmt
    nix-output-monitor
    direnv

    # ------------------------
    # Productivity / docs
    # ------------------------
    hugo # static site generator
    tmux # my beloved terminal multiplixer
    glow # markdown previewer
    vhs
    freeze
    gemini-cli
    matugen
    obsidian
    blender
    kdePackages.dolphin
    libreoffice-qt
    # opencode # TODO: undefined reference, see issue #opencode-missing

    # ------------------------
    # Development tools
    # ------------------------
    git
    neovim
    neovide
    vscode
    jetbrains.webstorm
    ghostty
    wezterm
    vim
    fish
    nushell
    wget
    pkg-config
    # Go
    go
    gopls
    # Rust
    rustc
    cargo
    # C / C++
    cmake
    gcc
    clang-tools
    # Web dev
    vercel-pkg
    nodejs
    bun
    cypress
    playwright-test
    postgresql

    # Nix stuff
    statix
    nix-diff

    # GTK4/Cairo development libraries (bar dependencies)
    glib
    glib.dev
    gobject-introspection
    gobject-introspection.dev
    cairo
    cairo.dev
    gdk-pixbuf
    gdk-pixbuf.dev
    atk
    atk.dev
    pango
    pango.dev
    wayland.dev
    gammastep
    fluent-gtk-theme
    colloid-gtk-theme
    whitesur-icon-theme
    # tau-hydrogen
    flameshot

    # ------------------------
    # Fonts & theming
    # ------------------------
    nerd-fonts.fira-code
    nerd-fonts.geist-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.comic-shanns-mono
    comic-mono
    fira-code
    geist-font
    nwg-look
    gcr
    polkit_gnome
    inter
    material-symbols
    comic-mono
    monaspace

    # ------------------------
    # Multimedia & streaming
    # ------------------------
    obs-studio
    xdg-desktop-portal-gnome
    # ------------------------
    # Communication
    # ------------------------
    legcord
    vesktop
    discord
    zapzap
    google-chrome
    brave
    # ------------------------
    # Inputs (flakes)
    # ------------------------
    inputs.zen-browser.packages."${system}".beta
    # inputs.fabric-widgets.packages.${system}.default
    # inputs.fabric-widgets.packages.${system}.run-widget
    # inputs.dms-cli.packages.${pkgs.system}.default
    (lib.hiPrio inputs.Ambxst.packages.${system}.default)

    inputs.dgop.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
