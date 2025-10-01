{ config, lib, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # environment.sessionVariables = {
  #   __GL_GSYNC_ALLOWED = "1";
  #   __GL_VRR_ALLOWED = "1";
  #   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  #   LIBVA_DRIVER_NAME = "nvidia";
  #   GBM_BACKEND = "nvidia-drm";
  #   WLR_NO_HARDWARE_CURSORS = "1";
  #   __GL_THREADED_OPTIMIZATIONS = "1";
  #   __GL_SHADER_CACHE = "1";
  # };
  environment.sessionVariables = {
    # الأساسية لـ NVIDIA مع Wayland
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";

    # لـ Wayland/Hyprland
    XDG_SESSION_TYPE = "wayland";
  };

  environment.systemPackages = with pkgs; [
    nvtopPackages.full
    nvidia-system-monitor-qt
    gpu-viewer
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    glxinfo
  ];

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
    "split_lock_detect=off"
    "mitigations=off"
  ];

  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  security.rtkit.enable = true;

  services.udev.extraRules = ''
    KERNEL=="nvidia", RUN+="${pkgs.runtimeShell} -c 'mknod -m 666 /dev/nvidiactl c 195 255'"
    KERNEL=="nvidia*", RUN+="${pkgs.runtimeShell} -c 'mknod -m 666 /dev/nvidia%n c 195 %n'"
    KERNEL=="nvidia_uvm", RUN+="${pkgs.runtimeShell} -c 'mknod -m 666 /dev/nvidia-uvm c $$(grep nvidia-uvm /proc/devices | cut -d \" \" -f 1) 0'"
  '';

  systemd.user.services.gamemode = {
    description = "GameMode daemon";
    wantedBy = [ "default.target" ];
  };

  networking.networkmanager.enable = true;
}
