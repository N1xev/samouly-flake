{ pkgs, ... }: {
  nix = {
    package = pkgs.nix;
    settings = {
      extra-substituters = [ "https://vicinae.cachix.org" ];
      extra-trusted-public-keys =
        [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
    };
  };

  services.vicinae = {
    enable = true;
    settings = {
      faviconService = "twenty";
      font.size = 11;
      theme.name = "vicinae-dark";
      window = {
        opacity = 0.95;
        rounding = 10;
      };
    };
  };
}
