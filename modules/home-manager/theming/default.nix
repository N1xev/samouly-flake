{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  cfg = config.theming;
  stateDir = "${config.xdg.stateHome}/matugen";
  cacheDir = "${config.xdg.cacheHome}/matugen";
  templates = ./templates;
  matugenBin = "${inputs.matugen.packages.${pkgs.system}.default}/bin/matugen";

  configToml = pkgs.writeText "matugen-config.toml" ''
    [config]
    reload_apps = false

    [templates.waybar-colors]
    input_path = "${templates}/colors.css"
    output_path = "${cacheDir}/colors.css"

    [templates.swaync]
    input_path = "${templates}/swaync.css"
    output_path = "${cacheDir}/swaync-colors.css"

    [templates.ghostty]
    input_path = "${templates}/ghostty.theme"
    output_path = "${config.xdg.configHome}/ghostty/themes/matugen"

    [templates.tmux]
    input_path = "${templates}/tmux.theme"
    output_path = "${cacheDir}/tmux.theme"

    [templates.starship]
    input_path = "${templates}/starship.toml"
    output_path = "${cacheDir}/starship.toml"

    [templates.gtk-colors]
    input_path = "${templates}/gtk-colors.css"
    output_path = "${cacheDir}/gtk-colors.css"

    [templates.kcolorscheme]
    input_path = "${templates}/Matugen.colors"
    output_path = "${config.xdg.dataHome}/color-schemes/Matugen.colors"

    [templates.qtct-colors]
    input_path = "${templates}/qtct-colors.conf"
    output_path = "${cacheDir}/qtct-colors.conf"

    [templates.kvantum-kvconfig]
    input_path = "${templates}/kvantum.kvconfig"
    output_path = "${config.xdg.configHome}/Kvantum/Matugen/Matugen.kvconfig"

    [templates.rofi]
    input_path = "${templates}/image-picker.razi"
    output_path = "${config.xdg.configHome}/rofi/matugen.razi"

    [templates.discord-vencord]
    input_path = "${templates}/discord.theme.css"
    output_path = "${config.xdg.configHome}/Vencord/themes/matugen.theme.css"

    [templates.discord-vesktop]
    input_path = "${templates}/discord.theme.css"
    output_path = "${config.xdg.configHome}/vesktop/themes/matugen.theme.css"

    [templates.discord-legcord]
    input_path = "${templates}/discord.theme.css"
    output_path = "${config.xdg.configHome}/legcord/themes/matugen/theme.css"

    [templates.neovim]
    input_path = "${templates}/neovim.lua"
    output_path = "${config.xdg.configHome}/nvim/generated.lua"
  '';

  set-wallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    #!/usr/bin/env bash
    set -e

    WALLPAPER="''${1:-}"
    if [ -z "$WALLPAPER" ]; then
      echo "Usage: set-wallpaper <path-to-wallpaper>"
      exit 1
    fi

    if [ ! -f "$WALLPAPER" ]; then
      echo "Error: Wallpaper not found: $WALLPAPER"
      exit 1
    fi

    mkdir -p "${stateDir}"
    mkdir -p "${cacheDir}"
    mkdir -p "${config.xdg.dataHome}/color-schemes"
    mkdir -p "${config.xdg.configHome}/Kvantum/Matugen"
    mkdir -p "${config.xdg.configHome}/qt5ct/colors"
    mkdir -p "${config.xdg.configHome}/qt6ct/colors"
    mkdir -p "${config.xdg.configHome}/ghostty/themes"
    mkdir -p "${config.xdg.configHome}/rofi"
    mkdir -p "${config.xdg.configHome}/Vencord/themes"
    mkdir -p "${config.xdg.configHome}/vesktop/themes"
    mkdir -p "${config.xdg.configHome}/legcord/themes/matugen"
    mkdir -p "${config.xdg.configHome}/walker/themes/matugen"
    mkdir -p "${config.xdg.configHome}/nvim"

    echo "$WALLPAPER" > "${stateDir}/current-wallpaper"

    ${matugenBin} image "$WALLPAPER" \
      --config "${configToml}" \
      --mode dark \
      --type scheme-tonal-spot \
      --prefer=darkness \
      2>&1

    # Copy qtct color scheme to both qt5ct and qt6ct
    cp "${cacheDir}/qtct-colors.conf" "${config.xdg.configHome}/qt5ct/colors/matugen.conf" 2>/dev/null || true
    cp "${cacheDir}/qtct-colors.conf" "${config.xdg.configHome}/qt6ct/colors/matugen.conf" 2>/dev/null || true

    # Set wallpaper
    if pgrep -x swww-daemon >/dev/null; then
      ${pkgs.swww}/bin/swww img "$WALLPAPER" --transition-type fade --transition-duration 1 --fill 2>/dev/null || true
    elif pgrep -x swaybg >/dev/null; then
      pkill -x swaybg
      ${pkgs.swaybg}/bin/swaybg -i "$WALLPAPER" -m fill &
    else
      ${pkgs.swaybg}/bin/swaybg -i "$WALLPAPER" -m fill &
    fi

    # Reload GTK theme
    if command -v gsettings &>/dev/null; then
      gsettings set org.gnome.desktop.interface gtk-theme "" 2>/dev/null || true
      gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark" 2>/dev/null || true
      gsettings set org.gnome.desktop.interface color-scheme "prefer-dark" 2>/dev/null || true
    fi

    # Reload Kvantum if using it
    if [ "$QT_STYLE_OVERRIDE" = "kvantum" ] || [ "$QT_QPA_PLATFORMTHEME" = "kvantum" ]; then
      ${pkgs.qt6Packages.qtstyleplugin-kvantum}/bin/kvantummanager --set Matugen 1>/dev/null || true
    fi

    # Reload waybar (kill and restart)
    pkill -9 waybar 2>/dev/null || true
    sleep 0.5
    nohup waybar >/dev/null 2>&1 &

    # Reload swaync (kill and restart)
    pkill -9 swaync 2>/dev/null || true
    pkill -9 swaync-client 2>/dev/null || true
    sleep 0.5
    nohup swaync >/dev/null 2>&1 &

    # Reload neovim (send SIGUSR1 to reload colors)
    pkill -SIGUSR1 nvim 2>/dev/null || true

    ${pkgs.libnotify}/bin/notify-send "Theme Updated" "Colors generated from $(basename "$WALLPAPER")" --expire-time=1500
  '';

  wallpaper-picker = pkgs.writeShellScriptBin "wallpaper-picker" ''
    #!/usr/bin/env bash
    WALLPAPER_DIR="''${WALLPAPER_DIR:-$HOME/Pictures/Wallpapers}"

    if [ ! -d "$WALLPAPER_DIR" ]; then
      notify-send "Wallpaper Picker" "Wallpaper directory not found: $WALLPAPER_DIR"
      exit 1
    fi

    # Get list of wallpapers
    WALLPAPERS=$(ls -1 "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp} 2>/dev/null)

    if [ -z "$WALLPAPERS" ]; then
      notify-send "Wallpaper Picker" "No wallpapers found"
      exit 1
    fi

    # Use rofi to select wallpaper by name
    selected=$(echo "$WALLPAPERS" | xargs -I {} basename {} | ${pkgs.rofi}/bin/rofi -dmenu -i -p "Select Wallpaper")

    if [ -n "$selected" ]; then
      full_path="$WALLPAPER_DIR/$selected"
      if [ -f "$full_path" ]; then
        set-wallpaper "$full_path"
      fi
    fi
  '';

in
{
  options.theming.enable = lib.mkEnableOption "Enable matugen-based theming";

  config = lib.mkIf cfg.enable {
    home = {
      packages = [
        set-wallpaper
        wallpaper-picker
        inputs.matugen.packages.${pkgs.system}.default
        pkgs.rofi
        pkgs.imagemagick
        pkgs.swaybg
        pkgs.adw-gtk3
        pkgs.libsForQt5.qtstyleplugin-kvantum
        pkgs.qt6Packages.qtstyleplugin-kvantum
        pkgs.libsForQt5.qt5ct
        pkgs.qt6Packages.qt6ct
      ];

      sessionVariables = {
        QT_QPA_PLATFORMTHEME = "qt6ct";
      };

      activation.matugen-generate = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        STATE_FILE="${stateDir}/current-wallpaper"
        if [ -f "$STATE_FILE" ]; then
          WALLPAPER=$(cat "$STATE_FILE")
          if [ -f "$WALLPAPER" ]; then
            $DRY_RUN_CMD mkdir -p "${cacheDir}"
            $DRY_RUN_CMD mkdir -p "${config.xdg.dataHome}/color-schemes"
            $DRY_RUN_CMD mkdir -p "${config.xdg.configHome}/Kvantum/Matugen"
            $DRY_RUN_CMD mkdir -p "${config.xdg.configHome}/qt5ct/colors"
            $DRY_RUN_CMD mkdir -p "${config.xdg.configHome}/qt6ct/colors"
            $DRY_RUN_CMD mkdir -p "${config.xdg.configHome}/ghostty/themes"
            $DRY_RUN_CMD mkdir -p "${config.xdg.configHome}/rofi"
            $DRY_RUN_CMD mkdir -p "${config.xdg.configHome}/Vencord/themes"
            $DRY_RUN_CMD mkdir -p "${config.xdg.configHome}/vesktop/themes"
            $DRY_RUN_CMD mkdir -p "${config.xdg.configHome}/legcord/themes/matugen"
            $DRY_RUN_CMD mkdir -p "${config.xdg.configHome}/nvim"
            $DRY_RUN_CMD ${matugenBin} image "$WALLPAPER" \
              --config "${configToml}" \
              --mode dark \
              --type scheme-tonal-spot \
              --prefer=darkness
            $DRY_RUN_CMD cp "${cacheDir}/qtct-colors.conf" "${config.xdg.configHome}/qt5ct/colors/matugen.conf" 2>/dev/null || true
            $DRY_RUN_CMD cp "${cacheDir}/qtct-colors.conf" "${config.xdg.configHome}/qt6ct/colors/matugen.conf" 2>/dev/null || true
          fi
        fi
      '';
    };

    xdg.configFile = {
      "gtk-3.0/gtk.css" = {
        text = ''
          @import url("file://${cacheDir}/gtk-colors.css");
        '';
      };
      "gtk-4.0/gtk.css" = {
        text = ''
          @import url("file://${cacheDir}/gtk-colors.css");
        '';
      };
      "Kvantum/kvantum.kvconfig" = {
        text = ''
          [General]
          theme=Matugen
        '';
      };
      "legcord/themes/matugen/manifest.json" = {
        text = builtins.toJSON {
          name = "Matugen";
          theme = "theme.css";
          enabled = true;
        };
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "adw-gtk3-dark";
      };
    };
  };
}
