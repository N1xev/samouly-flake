{ quickshell, system, ... }:

{
  home.packages = [
    quickshell.packages.${system}.default

  ];

}
