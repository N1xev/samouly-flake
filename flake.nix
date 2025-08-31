{
  description = "Samouly cute NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-flake.url = "github:sodiboo/niri-flake";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, home-manager, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "samouly";
      hostname = "nixos";
      timezone = "Africa/Cairo";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        ${hostname} = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs username system hostname timezone; };
          modules =
            [ ./nixos/configuration.nix inputs.niri-flake.nixosModules.niri ];
        };
      };

      homeConfigurations.${hostname} =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home-manager/home.nix ];
          extraSpecialArgs = { inherit inputs username system; };
        };
    };
}
