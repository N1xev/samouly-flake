_: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      font-family = "MonaspiceRn Nerd Font Mono";
      font-size = 12;
      font-style-bold = true;
      theme = "matugen";
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
  };
}
