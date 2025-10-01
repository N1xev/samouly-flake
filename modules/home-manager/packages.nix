{ pkgs, inputs, lib, system, ... }: {
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
    gtk4
    gtk4-layer-shell
    wayland
    wayland-protocols
    wayland-scanner
    brightnessctl
    cliphist
    # ------------------------
    # Nix utilities
    # ------------------------
    nixfmt-classic
    nix-output-monitor
    direnv

    # ------------------------
    # Productivity / docs
    # ------------------------
    hugo # static site generator
    glow # markdown previewer
    vhs
    freeze
    gemini-cli
    matugen
    obsidian
    blender

    # ------------------------
    # Development tools
    # ------------------------
    git
    neovim
    vscode
    ghostty
    wezterm
    vim # fallback editor
    fish
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
    tela-circle-icon-theme
    whitesur-icon-theme
    # tau-hydrogen
    flameshot
    ventoy-full-gtk

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
    inter
    material-symbols
    # ------------------------
    # Multimedia & streaming
    # ------------------------
    obs-studio
    # ------------------------
    # Communication
    # ------------------------
    legcord
    discord
    google-chrome
    # ------------------------
    # Inputs (flakes)
    # ------------------------
    inputs.zen-browser.packages."${system}".beta
    inputs.fabric.packages.${system}.default
    inputs.fabric.packages.${system}.run-widget
    inputs.dms-cli.packages.${pkgs.system}.default
    inputs.dgop.packages.${pkgs.system}.default
  ];
}
