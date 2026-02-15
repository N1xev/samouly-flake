# NVIDIA VAAPI Hardware Encoding Analysis

## Issue Identified

You are experiencing the **NVIDIA VAAPI encoding limitation**. The error message:
```
[AVHWFramesContext @ 0x55891e7b8880] Failed to create surface: 14 (the requested RT Format is not supported).
[AVHWFramesContext @ 0x55891e7b8880] Unable to allocate a surface from internal buffer pool.
Cannot allocate memory
```

This is the **exact same error** reported in [wl-screenrec issue #32](https://github.com/russelltg/wl-screenrec/issues/32).

## Root Cause

**NVIDIA's VAAPI driver (`nvidia-vaapi-driver`) only supports VIDEO DECODE, not VIDEO ENCODE.**

The `nvidia-vaapi-driver` provides VA-API compatibility for NVIDIA GPUs but:
- ✅ Supports hardware-accelerated **decoding** (H264, HEVC, VP8, VP9, AV1)
- ❌ Does **NOT** support hardware-accelerated **encoding** through VA-API

When you run `vainfo` with NVIDIA driver, you'll see only `VAEntrypointVLD` (Video Decode) entries, but **NO** `VAEntrypointEncSlice` (Video Encode) entries.

## Your Current Setup Analysis

### ✅ What's Working:
- `hardware.graphics` configuration is correct
- `nvidia-vaapi-driver` is installed
- `LIBVA_DRIVER_NAME=nvidia` is set
- Prime sync is enabled for hybrid GPU setup
- Hyprland environment variables are mostly correct

### ❌ The Problem:
You're trying to use **VAAPI encoding** (likely through `wl-screenrec` or similar) on NVIDIA, which is not supported by `nvidia-vaapi-driver`.

### 🔴 Critical Missing Configuration:

1. **`NVD_BACKEND=direct`** environment variable is **NOT set** in your configuration
2. **`services.xserver.videoDrivers = [ "nvidia" ];`** is **missing** from nvidia.nix
3. **Missing `nv-codec-headers`** for NVENC support
4. **Missing CUDA/ENC libraries** for hardware encoding

## Solutions

### Option 1: Use Intel iGPU for Encoding (Recommended for Hybrid Laptops)

Since you have Intel + NVIDIA hybrid setup (Prime sync enabled), use Intel's VA-API driver for encoding:

```nix
# modules/nixos/nvidia.nix
{ pkgs, inputs, ... }:
{
  # ... existing imports ...

  services.xserver.videoDrivers = [ "nvidia" ];  # ADD THIS

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver      # Intel VA-API driver (for encoding)
        nvidia-vaapi-driver     # NVIDIA VA-API (for decoding only)
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
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  # Use Intel for VA-API (supports encoding)
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";  # Intel driver supports encode
    NVD_BACKEND = "direct";     # Required for NVIDIA VAAPI
  };
}
```

### Option 2: Use NVENC Directly (NVIDIA Native Encoding)

For applications that support NVENC directly (OBS, FFmpeg with NVENC):

```nix
# modules/nixos/nvidia.nix
{ pkgs, inputs, ... }:
{
  # ... existing configuration ...

  services.xserver.videoDrivers = [ "nvidia" ];  # ADD THIS

  # Ensure nvidia-uvm is loaded (required for NVENC)
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_drm" "nvidia_uvm" ];

  # Add NVENC support packages
  environment.systemPackages = with pkgs; [
    nv-codec-headers-12  # NVIDIA codec headers for NVENC
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
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
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };
}
```

### Option 3: Fix Hyprland Environment Variables

Update your Hyprland environment for better NVIDIA compatibility:

```nix
# modules/home-manager/hypr/hyprland.nix
wayland.windowManager.hyprland = {
  # ... existing config ...
  settings = {
    env = [
      "WLR_NO_HARDWARE_CURSORS,1"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "LIBVA_DRIVER_NAME,nvidia"
      "GBM_BACKEND,nvidia-drm"
      "NIXOS_OZONE_WL,1"
      "NVD_BACKEND,direct"              # ADD THIS - Required for NVIDIA VAAPI
      "MOZ_DISABLE_RDD_SANDBOX,1"       # ADD THIS - Firefox hw accel
      "__GL_GSYNC_ALLOWED,1"
      "GDK_BACKEND,wayland"
    ];
    # ... rest of config ...
  };
};
```

## Verification Commands

After rebuilding, test with:

```bash
# Check VA-API support
nix shell nixpkgs#libva-utils -c vainfo

# Check NVIDIA driver
nix shell nixpkgs#libva-utils -c vainfo --display drm --device /dev/dri/renderD128

# For NVENC test
nix shell nixpkgs#ffmpeg -c ffmpeg -encoders | grep nvenc

# Test with NVD_LOG for debugging
NVD_LOG=1 nix shell nixpkgs#libva-utils -c vainfo
```

## Application-Specific Workarounds

### For wl-screenrec:
Use software encoding or switch to wf-recorder with Intel VA-API:
```bash
# Use Intel GPU for recording
wf-recorder -c h264_vaapi -d /dev/dri/renderD128
```

### For OBS:
Use NVENC directly (not VAAPI):
- Settings → Output → Encoder: "NVIDIA NVENC H.264"

### For FFmpeg:
Use NVENC instead of VAAPI:
```bash
ffmpeg -i input.mp4 -c:v h264_nvenc output.mp4  # NVIDIA encoding
# instead of
ffmpeg -i input.mp4 -c:v h264_vaapi output.mp4   # VAAPI (won't work on NVIDIA)
```

## Summary

| Feature | NVIDIA VAAPI | Intel VA-API | NVENC |
|---------|--------------|--------------|-------|
| Video Decode | ✅ Yes | ✅ Yes | N/A |
| Video Encode | ❌ No | ✅ Yes | ✅ Yes |
| Works with wl-screenrec | ❌ No | ✅ Yes | ❌ No |
| Works with OBS | ❌ No | ✅ Yes | ✅ Yes |

**Recommendation**: Since you have a hybrid Intel+NVIDIA laptop, use **Intel VA-API** for encoding workloads and **NVIDIA** for display/GPU tasks.

## Sources

1. [wl-screenrec issue #32 - ffmpeg cannot allocate memory error](https://github.com/russelltg/wl-screenrec/issues/32)
2. [NVIDIA VAAPI Driver - elFarto/nvidia-vaapi-driver](https://github.com/elFarto/nvidia-vaapi-driver)
3. [NixOS NVIDIA Wiki](https://wiki.nixos.org/wiki/NVIDIA)
4. [Hyprland NVIDIA Guide](https://wiki.hyprland.org/Nvidia/)
5. [Accelerated Video Playback - NixOS Wiki](https://wiki.nixos.org/wiki/Accelerated_Video_Playback)
