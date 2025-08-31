{
  description = "Samouly cute NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
};
  
  outputs = { self, home-manager, nixpkgs, ... }@inputs:
  let 
    hostname = "nixos";
    username = "samouly";
  in {
    nixosConfigurations = {
      ${username} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
          modules = [
            ./hosts/samouly/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.samouly = ./home-manager/home.nix;
            }
          ];
    };
  };
  };
}