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
    mpv
    vlc

    # ------------------------
    # Sway / Wayland utilities
    # ------------------------
    awww
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
    pywalfox-native
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
    obsidian
    blender

    # ------------------------
    # Development tools
    # ------------------------
    git
    gh
    gh-dash
    neovim
    emacs
    zed-editor
    claude-code
    ollama
    jetbrains-toolbox
    ghostty
    fish
    nushell
    wget
    pkg-config
    bruno

    # Go
    go
    gopls
    # Rust
    rustc
    rustup
    # C / C++
    cmake
    gcc
    clang-tools
    gnumake
    # Web dev
    nodejs
    bun
    cypress
    playwright-test
    postgresql

    just
    gnupg

    # Nix stuff
    statix
    nix-diff

    # GTK4/Cairo development libraries (bar dependencies)
    gammastep
    fluent-gtk-theme
    colloid-gtk-theme
    flameshot

    # ------------------------
    # Fonts & theming
    # ------------------------
    nerd-fonts.fira-code
    nerd-fonts.geist-mono
    geist-font
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
    nerd-fonts.monaspace

    # ------------------------
    # Multimedia & streaming
    # ------------------------
    obs-studio
    xdg-desktop-portal-gnome
    # ------------------------
    # Communication
    # ------------------------
    vesktop
    telegram-desktop
    zapzap
    google-chrome
    brave

    ### misc
    libxcb
    libxkbcommon
    # ------------------------
    # Inputs (flakes)
    # ------------------------
    inputs.zen-browser.packages."${system}".beta
    # inputs.fabric-widgets.packages.${system}.default
    # inputs.fabric-widgets.packages.${system}.run-widget
    # inputs.dms-cli.packages.${pkgs.system}.default
    (lib.hiPrio inputs.Ambxst.packages.${system}.default)
  ];
}
