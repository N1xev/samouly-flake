{ pkgs, ... }: {

  programs.fish = {
    enable = true;

    shellAliases = {
      "gpu-temp" =
        "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits";
      "gpu-usage" =
        "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
      "gpu-mem" =
        "nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader";
      "gpu-info" = "nvidia-smi";
      "gpu-driver" = "cat /proc/driver/nvidia/version";

      "nvidia-versions" = "nix search nixpkgs nvidia | grep nvidiaPackages";
      "current-nvidia" =
        "nix eval nixpkgs#linuxPackages.nvidiaPackages.stable.version";

      "steam-gaming" = "gamemoderun steam";
      "check-vulkan" = "vulkaninfo --summary";
    };

    interactiveShellInit = ''
      set -gx MANGOHUD 1
      set -gx DXVK_HUD fps,memory,gpuload
      set -gx PROTON_ENABLE_NVAPI 1

      set -gx __GL_THREADED_OPTIMIZATIONS 1
      set -gx __GL_SHADER_CACHE 1
      set -gx __GLX_VENDOR_LIBRARY_NAME nvidia
      set -gx LIBVA_DRIVER_NAME nvidia
      set -gx GBM_BACKEND nvidia-drm

      if status is-interactive
          echo "Gaming environment loaded!"
          echo "GPU: RTX Quadro 3000"
          echo "Use 'gpu-info' to check status"
      end
    '';

    functions = {
      gpu_monitor = {
        description = "Real-time GPU monitoring";
        body = ''
          while true
              clear
              echo "=== GPU Monitor ==="
              echo "Temperature: "(gpu-temp)"°C"
              echo "Usage: "(gpu-usage)"%"
              echo "Memory: "(gpu-mem)
              echo ""
              nvidia-smi --query-gpu=utilization.gpu,memory.used,temperature.gpu,power.draw --format=csv
              sleep 2
          end
        '';
      };

      gaming_check = {
        description = "Check gaming setup status";
        body = ''
          echo "Gaming System Status"
          echo ""
          echo "GPU Info:"
          gpu-info | head -3
          echo ""
          echo "Temperature: "(gpu-temp)"°C"
          echo "GPU Usage: "(gpu-usage)"%"
          echo "Vulkan: "
          if vulkaninfo --summary >/dev/null 2>&1
              echo "Working"
          else
              echo "Not working"
          end
          echo ""
          echo "GameMode: "
          if pgrep gamemoded >/dev/null
              echo "Running"
          else
              echo "آot running"
          end
        '';
      };
    };

    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
    ];
  };

  programs.mangohud = {
    enable = true;
    settings = {
      fps = true;
      gpu_stats = true;
      gpu_temp = true;
      gpu_power = true;
      cpu_stats = true;
      cpu_temp = true;
      ram = true;
      vram = true;
      frametime = true;
      position = "top-left";
      toggle_hud = "Shift_R+F12";
      toggle_logging = "Shift_L+F2";
    };
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
        ioprio = 7;
        inhibit_screensaver = 1;
        softrealtime = "auto";
      };

      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
      };
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  
}
