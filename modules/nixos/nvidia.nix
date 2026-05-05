{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-cpu-intel
  ];
  services.xserver.videoDrivers = [ "nvidia" ];

  boot.initrd.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_drm"
    "nvidia_uvm"
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        nvidia-vaapi-driver
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };

    nvidia = {
      modesetting.enable = true;
      open = true;
      powerManagement.enable = true;
      prime = {
        sync.enable = true;
        offload = {
          enable = false;
          # enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };

    };
  };

  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD";
    NVD_BACKEND = "direct";
  };
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  services.thermald.enable = true;
}
