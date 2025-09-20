{
  description = "Samouly cute NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    niri-flake.url = "github:sodiboo/niri-flake";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae.url = "github:vicinaehq/vicinae";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fabric = {
      url = "github:Fabric-Development/fabric";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, home-manager, nixpkgs, vicinae, quickshell, ... }@inputs:
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
          modules = [
            ./nixos/configuration.nix
            inputs.hyprland.nixosModules.default
            inputs.niri-flake.nixosModules.niri
          ];
        };
      };

      homeConfigurations.${username} =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home-manager/home.nix
            inputs.spicetify-nix.homeManagerModules.default
            inputs.hyprland.homeManagerModules.default
            vicinae.homeManagerModules.default
          ];
          extraSpecialArgs = { inherit inputs username quickshell system; };
        };
    };
}
