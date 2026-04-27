{ pkgs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/nixos/main.nix
    ./cachix.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "i915.enable_guc=2" ];
    # kernelPackages = pkgs.linuxPackages_6_12;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services = {

    desktopManager = {
      gnome = {
        enable = false;
      };
      plasma6 = {
        enable = true;
      };
    };

    displayManager = {
      sddm = {
        enable = true;
        extraPackages = with pkgs; [
          kdePackages.qtsvg
          kdePackages.qtmultimedia
        ];
        wayland.enable = true;
        theme = "sddm-stray";
      };
    };

    printing.enable = true;
    pulseaudio.enable = false;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  security.rtkit.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = "Alaa Elsamouly";
    extraGroups = [
      "networkmanager"
      "wheel"
      "kvm"
      "adbusers"
    ];
  };

  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # Existing libraries
        opencode

        # Athas / WebKit GUI requirements
        webkitgtk_4_1
        libsoup_3
        gtk3
        glib
        zlib
        libx11
        libxext
        libxrender
        libxi
        libxcursor
        libxdamage
        libxfixes
        libxcomposite
        libxrandr
        libxcb
        cups
        cairo
        pango
        libgbm
        expat
        libxkbcommon
        fuse
        libxtst
        freetype

        # Common extras for modern TUI/GUI tools
        dbus
        udev
        libuuid
        alsa-lib
        at-spi2-atk
        nss
        nspr
        mesa
        libGL
      ];
    };
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;

    http-connections = 50;

    keep-outputs = true;
    keep-derivations = true;

  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "25.05";
}
