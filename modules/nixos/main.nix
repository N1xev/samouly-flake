{ ... }: 

{ 
  imports = [ 
    ./niri.nix
    # System
    ./packages.nix
    ../../nixos/hardware-configuration.nix 
  ];
  
}