{ pkgs, ... }:
{

  programs = {

    zoxide = {
      enable = true;
    };

    git = {
      enable = true;
      settings = {
        user.name = "N1xev";
        user.email = "alasamouly@gmail.com";
        url."git@github.com:".insteadOf = "https://github.com/";
      };
    };

    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*" = {
        addKeysToAgent = "yes";
      };
    };

    starship = {
      enable = true;
    };

    bash = {
      enable = true;
      enableCompletion = true;

      bashrcExtra = ''
        export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
        export PATH="$PATH:$HOME/bin:$HOME/.bun/bin:$HOME/bun/bin"

        if [[ $- == *i* ]] && [ -z "$TMUX" ]; then
          if tmux has-session -t Main 2>/dev/null; then
            exec tmux attach-session -t Main
          else
            exec tmux new-session -s Main
          fi
        fi
      '';

      shellAliases = {
        k = "kubectl";
        hms = "home-manager switch --flake ~/Projects/flakey/#$USER";
        nrs = "sudo nixos-rebuild switch --flake ~/Projects/flakey/#$hostname";
      };

    };

    nushell = {
      shellAliases = {
        hms = "home-manager switch --flake ~/Projects/flakey/#$USER";
        nrs = "sudo nixos-rebuild switch --flake ~/Projects/flakey/#$hostname";
      };

      extraConfig = ''
        $env.config.hooks = ($env.config.hooks | upsert pre_prompt [
          {
            condition: {|| ($env.TMUX? | is-empty) }
            code: '''
              if ($env.TMUX? | is-empty) {
                let has_session = (do { tmux has-session -t Main } | complete | get exit_code) == 0
                if $has_session {
                  tmux attach-session -t Main
                } else {
                  tmux new-session -s Main
                }
              }
            '''
          }
        ])
      '';
    };

    fish = {
      enable = true;

      shellAliases = {
        "gpu-temp" = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits";
        "gpu-usage" = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
        "gpu-mem" = "nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader";
        "gpu-info" = "nvidia-smi";
        "gpu-driver" = "cat /proc/driver/nvidia/version";

        "nvidia-versions" = "nix search nixpkgs nvidia | grep nvidiaPackages";
        "current-nvidia" = "nix eval nixpkgs#linuxPackages.nvidiaPackages.stable.version";

        "steam-gaming" = "gamemoderun steam";
        "check-vulkan" = "vulkaninfo --summary";
        "hms" = "home-manager switch --flake ~/Projects/flakey/#$USER";
        "nrs" = "sudo nixos-rebuild switch --flake ~/Projects/flakey/#$hostname";
      };

      interactiveShellInit = ''
        set -gx DXVK_HUD fps,memory,gpuload
        set -gx PROTON_ENABLE_NVAPI 1
        set -g fish_greeting ""
        set -gx __GL_THREADED_OPTIMIZATIONS 1
        set -gx __GL_SHADER_CACHE 1
        set -gx __GLX_VENDOR_LIBRARY_NAME nvidia
        set -gx LIBVA_DRIVER_NAME iHD
        set -gx GBM_BACKEND nvidia-drm
        set completion_dir $HOME/.config/fish/completions

        # Use matugen-generated starship config if available
        if test -f ~/.cache/matugen/starship.toml
          set -gx STARSHIP_CONFIG ~/.cache/matugen/starship.toml
        end

        # Auto-attach to tmux session (only in interactive terminals, not inside tmux)
        if status is-interactive; and not set -q TMUX
          if tmux has-session -t Main 2>/dev/null
            exec tmux attach-session -t Main
          else
            exec tmux new-session -s Main
          end
        end

        starship init fish | source
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
          inherit (pkgs.fishPlugins.fzf-fish) src;
        }
        {
          name = "done";
          inherit (pkgs.fishPlugins.done) src;
        }
      ];

    };

    mangohud = {
      enable = false;
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

    # ax-shell = {
    #   enable = true;
    #   settings = {
    #     # --- General ---
    #     wallpapersDir = "Pictures/Wallpapers";
    #
    #   };
    # };
  };

  # programs.gamemode = {
  #   enable = true;
  #   settings = {
  #     general = {
  #       renice = 10;
  #       ioprio = 7;
  #       inhibit_screensaver = 1;
  #       softrealtime = "auto";
  #     };

  #     gpu = {
  #       apply_gpu_optimisations = "accept-responsibility";
  #       gpu_device = 0;
  #     };
  #   };
  # };

  # programs.steam = {
  #   enable = true;
  #   remotePlay.openFirewall = true;
  #   dedicatedServer.openFirewall = true;
  #   gamescopeSession.enable = true;
  # };

}
