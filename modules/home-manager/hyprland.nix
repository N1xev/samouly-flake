{ inputs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "WLR_NO_HARDWARE_CURSORS,1"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "LIBVA_DRIVER_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
        "__GL_GSYNC_ALLOWED,1"
        "__GL_VRR_ALLOWED,1"
        "MANGOHUD,1"
      ];

      misc = {
        vfr = true;
        vrr = 1;
        allow_session_lock_restore = true;
      };

      bind = [
        "SUPER, G, exec, gamemoderun steam"
        "SUPER SHIFT, G, exec, nvidia-settings"
        "SUPER, M, exec, mangohud --dlsym glxinfo"
      ];

      windowrule = [
        "immediate, class:^(steam_app_).*"
        "fullscreen, class:^(steam_app_).*"
        "workspace 5, class:^(steam_app_).*"
      ];
    };
  };
}
