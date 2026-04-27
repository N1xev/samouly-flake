{
  description = "Samouly Nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # fabric-widgets = {
    #   url = "github:Fabric-Development/fabric";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    Ambxst = {
      url = "github:Axenide/Ambxst";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sddm-stray = {
      url = "github:Bqrry4/sddm-stray";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    matugen = {
      url = "github:InioX/matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      vicinae,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "samouly";
      hostname = "nixos";
      timezone = "Africa/Cairo";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
          allowUnsupportedSystem = true;
          permittedInsecurePackages = [
            "electron-36.9.5"
            "ventoy-full-gtk3"
          ];
        };
        overlays = [
          (import ./overlays/material-icons.nix)
        ];
      };
    in
    {

      nixosConfigurations = {
        ${hostname} = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = {
            inherit
              inputs
              username
              hostname
              timezone
              ;
          };
          modules = [
            ./nixos/configuration.nix
            inputs.hyprland.nixosModules.default
            inputs.niri-flake.nixosModules.niri
          ];
        };
      };

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/home.nix
          inputs.spicetify-nix.homeManagerModules.default
          inputs.hyprland.homeManagerModules.default
          vicinae.homeManagerModules.default
        ];
        extraSpecialArgs = {
          inherit
            inputs
            username
            system
            ;
        };
      };
    };
}
