{ pkgs, inputs, system, ... }:

{
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    fastfetch
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
    ## golang
    go
    gopls

    ## web dev
    vercel-pkg
    nodejs
    bun
    cypress
    playwright-test

    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    fish
    wget
    discord
    vesktop
    vscode
    ghostty
    wezterm
    git
    fuzzel
    xwayland-satellite
  ];
}
