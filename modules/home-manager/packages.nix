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
    discord
    legcord
    google-chrome
    # ------------------------
    # Inputs (flakes)
    # ------------------------
    inputs.zen-browser.packages."${system}".beta
    inputs.fabric.packages.${system}.default
    inputs.fabric.packages.${system}.run-widget
  ];

  # Set environment variables for pkg-config
  home.sessionVariables = {
    PKG_CONFIG_PATH = lib.concatStringsSep ":" [
      "${pkgs.glib.dev}/lib/pkgconfig"
      "${pkgs.cairo.dev}/lib/pkgconfig"
      "${pkgs.gtk4.dev}/lib/pkgconfig"
      "${pkgs.gdk-pixbuf.dev}/lib/pkgconfig"
      "${pkgs.gobject-introspection.dev}/lib/pkgconfig"
      "${pkgs.atk.dev}/lib/pkgconfig"
      "${pkgs.pango.dev}/lib/pkgconfig"
      "${pkgs.wayland.dev}/lib/pkgconfig"
    ];

    LD_LIBRARY_PATH = lib.concatStringsSep ":" [
      "${pkgs.glib}/lib"
      "${pkgs.cairo}/lib"
      "${pkgs.gtk4}/lib"
      "${pkgs.gdk-pixbuf}/lib"
      "${pkgs.gobject-introspection}/lib"
      "${pkgs.atk}/lib"
      "${pkgs.pango}/lib"
      "${pkgs.wayland}/lib"
    ];

    GI_TYPELIB_PATH = lib.concatStringsSep ":" [
      "${pkgs.gtk4}/lib/girepository-1.0"
      "${pkgs.glib}/lib/girepository-1.0"
      "${pkgs.gobject-introspection}/lib/girepository-1.0"
      "${pkgs.gdk-pixbuf}/lib/girepository-1.0"
      "${pkgs.cairo}/lib/girepository-1.0"
      "${pkgs.atk}/lib/girepository-1.0"
      "${pkgs.pango}/lib/girepository-1.0"
    ];
  };
}
