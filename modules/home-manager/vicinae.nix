{ config, pkgs, ... }:
{
  # إعدادات Nix
   nix = {
    package = pkgs.nix;  # هذا السطر مطلوب
    settings = {
      extra-substituters = [ "https://vicinae.cachix.org" ];
      extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
    };
  };
  # خدمات
  services.vicinae = {
    enable = true;
    autoStart = true;
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
