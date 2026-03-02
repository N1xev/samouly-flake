_: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
    settings = {
      env = [
        "WLR_NO_HARDWARE_CURSORS,1"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "LIBVA_DRIVER_NAME,iHD"
        "GBM_BACKEND,nvidia-drm"
        "NIXOS_OZONE_WL,1"
        "NVD_BACKEND,direct"
        "MOZ_DISABLE_RDD_SANDBOX,1"
        "__GL_GSYNC_ALLOWED,1"
        "GDK_BACKEND,wayland"
      ];

      # Miscellaneous settings for better performance and compatibility
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        allow_session_lock_restore = true;
        enable_swallow = false;
        focus_on_activate = true;
      };

      # Monitor configuration
      monitor = ",preferred,auto,auto";

      # Program variables
      "$terminal" = "ghostty";
      "$fileManager" = "nautilus";
      "$menu" = "vicinae toggle";

      # Input configuration
      input = {
        kb_layout = "us,ara";
        kb_options = "grp:alt_shift_toggle";
        numlock_by_default = true;
        repeat_delay = 300;
        repeat_rate = 35;
        follow_mouse = 1;
        focus_on_close = 1;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
          scroll_factor = 0.5;
          drag_lock = true;
          tap-to-click = true;
          tap-and-drag = true;
        };
        special_fallthrough = true;
      };

      # General settings (optimized for performance)
      general = {
        gaps_in = 3;
        gaps_out = 10;
        border_size = 1;
        "col.active_border" = "rgba(ff637eee) rgba(4d0218ee) 45deg";
        "col.inactive_border" = "rgba(4a5565aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
        no_focus_fallback = true;
      };

      # Decoration settings (optimized for performance)
      decoration = {
        rounding = 0;
        active_opacity = 0.9;
        inactive_opacity = 0.85;
        shadow = {
          enabled = false;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 10;
          passes = 5;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint, 0.23, 1, 0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear, 0, 0, 1, 1"
          "quick, 0.15, 0, 0.1, 1"
        ];
        animation = [
          "windows, 1, 3, easeOutQuint"
          "windowsIn, 1, 3, easeOutQuint, popin 80%"
          "windowsOut, 1, 2, linear, popin 80%"
          "fadeIn, 1, 2, quick"
          "fadeOut, 1, 2, quick"
          "fade, 1, 2, quick"
          "workspaces, 1, 2, quick"
          "workspacesIn, 1, 2, quick"
          "workspacesOut, 1, 2, quick"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      gestures = {
        workspace_swipe_distance = 200;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_create_new = false;
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, return, exec, $terminal"
        "$mainMod, Q, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "$mainMod, D, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"
        # Focus movement
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        # Workspace switching
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        # Move to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        # Special workspace
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod CONTROL, S, movetoworkspace, special:magic"
        # Scroll workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        # Move to left/right workspaces (keyboard support)
        "$mainMod, left, workspace, e-1"
        "$mainMod, right, workspace, e+1"
        # Gaming bindings
        "$mainMod, G, exec, gamemoderun steam"
        "$mainMod SHIFT, G, exec, nvidia-settings"
        "$mainMod, M, exec, mangohud --dlsym glxinfo"
        "$mainMod, Z, exec, zen-beta"

        # GUI Screenshot -> Copy + Save to Pictures/Screenshots
        "$mainMod SHIFT, S, exec, flameshot gui -c -p ~/Pictures/Screenshots"

        # Fullscreen Screenshot -> Copy + Save to Pictures/Screenshots
        ", Print, exec, flameshot full -c -p ~/Pictures/Screenshots"

        # Active Screen (under cursor) -> Copy + Save to Pictures/Screenshots
        "CONTROL, Print, exec, flameshot screen -c -p ~/Pictures/Screenshots"

        # test notifications
        # F12 - Short wisdom quote
        "SUPER_ALT, F12, exec, notify-send -i /home/samouly/Downloads/llama.webp 'Daily Wisdom' 'The journey of a thousand miles begins with a single step.' -u normal"

        # F11 - Long motivational message
        "SUPER_ALT, F11, exec, notify-send -i /home/samouly/Downloads/llama.webp 'Motivation' 'Success is not final, failure is not fatal: it is the courage to continue that counts. Keep pushing forward, embrace challenges, and never stop learning. Your potential is limitless when you believe in yourself.' -u normal"

        # F10 - Notification with 2 action buttons
        "SUPER_ALT, F10, exec, notify-send -i /home/samouly/Downloads/llama.webp 'Quick Actions' 'Choose your next move' --action='work=Start Working' --action='break=Take Break' -u normal"

        # F9 - Notification with multiple action buttons
        "SUPER_ALT, F9, exec, notify-send -i /home/samouly/Downloads/llama.webp 'Control Panel' 'What would you like to do?' --action='code=Open VSCode' --action='browser=Open Browser' --action='terminal=Open Terminal' --action='shutdown=Shutdown' -u critical"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Long press bindings (repeatable)
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Edge bindings (repeatable)
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      # Autostart
      exec-once = [
        "swaybg -i ~/Pictures/wallpaper.jpg -m fill &"
        "vicinae server &"
        "waybar &"
      ];

      gesture = [ "3, horizontal, workspace" ];

      # Binds settings
      binds = {
        scroll_event_delay = 0;
      };

    };
  };
}
