_: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      font-family = "ComicShannsMono Nerd Font Mono";
      font-size = 12;
      font-style-bold = true;
      theme = "Nahody";
      window-decoration = true;
      window-padding-balance = true;
      window-padding-color = "extend";
      window-padding-x = 0;
      window-padding-y = 0;
      confirm-close-surface = false;
      keybind = [
        "ctrl+shift+w=new_split:up"
        "ctrl+shift+s=new_split:down"
        "ctrl+shift+d=new_split:right"
        "ctrl+shift+a=new_split:left"
        "ctrl+shift+n=new_tab"
        "ctrl+alt+n=new_window"
      ];
    };
    themes = {
      Nahody = {
        background = "030712";
        cursor-color = "ff637e";
        foreground = "f3f4f6";
        palette = [
          "0=#030712"
          "1=#ff637e"
          "2=#ffba00"
          "3=#99a1af"
          "4=#4d0218"
          "5=#364153"
          "6=#364153"
          "7=#f3f4f6"
          "8=#6a7282"
          "9=#ff637e"
          "10=#ffba00"
          "11=#99a1af"
          "12=#a50036"
          "13=#364153"
          "14=#4a5565"
          "15=#f3f4f6"
        ];
        selection-background = "99a1af";
        selection-foreground = "030712";
      };
    };

  };
}
