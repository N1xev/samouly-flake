{ pkgs, ... }:

{
  services.vicinae = {
    enable = true;
    autoStart = true;
    settings = {
      faviconService = "google";
      font.size = 15;
      popToRootOnClose = false;
      rootSearch.searchFiles = true;
      theme.name = "tokyo-night";
      window = {
        csd = true;
        opacity = 1;
        rounding = 10;
      };
    };
  };

}
