{ pkgs, inputs, lib, system, ... }: {
  home.packages = with pkgs; [
    # ------------------------
    # Command-line utilities
    # ------------------------
    nitch
    yazi # terminal file manager
    fzf # fuzzy finder
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
    btop # replacement of htop/nmon
    iotop # IO monitoring
    iftop # network monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
    sysstat
    lm_sensors # sensors
    ethtool
    pciutils # lspci
    usbutils # lsusb
    procps # For CPU/memory stats (bar dependency)
    iw # WiFi configuration tool (replacement for wireless-tools)
    wirelesstools # Alternative WiFi tools
    khal
    libnotify
    lutris
    heroic
    bottles
    mangohud
    goverlay
    protontricks
    protonup-qt

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
    gtk4-layer-shell # For wayland layer shell support (bar dependency)
    wayland
    wayland-protocols
    wayland-scanner
    brightnessctl
    
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
    pkg-config # For finding libraries (bar dependency)
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
