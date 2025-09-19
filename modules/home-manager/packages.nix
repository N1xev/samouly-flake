{ pkgs, inputs, system, ... }:

{
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    nitch
    yazi # terminal file manager

    # utils
    fzf # A command-line fuzzy finder

    # misc
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # sway stuff
    swaynotificationcenter
    swww
    swaybg

    # nix related

    nixfmt-classic
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal
    vhs
    freeze
    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring
    fuzzel

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
    kubectl

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # developement
    # ide & text editors
    neovim
    vscode
    ghostty
    wezterm
    git

    ## golang
    go
    gopls

    ## rust dev
    rustc
    cargo

    ## C & c++ dev
    cmake
    gcc

    ## web dev
    vercel-pkg
    nodejs
    bun
    cypress
    playwright-test

    # python

    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    fish
    wget
    discord
    vesktop
    xwayland-satellite

    # fonts
    nerd-fonts.fira-code
    nerd-fonts.geist-mono
    fira-code
    geist-font

    polkit_gnome
    nwg-look
    gcr

    obs-studio

    inputs.zen-browser.packages."${system}".beta
    inputs.fabric.packages.${system}.default
    inputs.fabric.packages.${system}.run-widget

    # Aylur's projects
    # inputs.ags.packages.${system}.default
    # inputs.astal.packages.${system}.default
    # waybar
    waybar
    waybar-mpris
    playerctl

    gemini-cli
    direnv
    google-chrome
    matugen
    uwsm
    dbus
  ];
}
