{ ... }: 

{ 
  imports = [ 
    ./niri.nix
    ./hyprland.nix
    # System
    ./packages.nix
    ../../nixos/hardware-configuration.nix 
    ./nvidia.nix
  ];
  
}