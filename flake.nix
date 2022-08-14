{
  description = "My NixOS and stand-alone home-manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
      overlays = [];
    };
    lib = nixpkgs.lib;
  in {
    # Stand-alone home-manager flake
    #
    # Usage:
    #   1. Install Home Manager and apply the configuration by 
    #     $ nix build --no-link .#homeConfiguration.diego.activationPacakge
    #     $ "$(nix path-info .#homeConfiguration.diego.activationPackage"/activate
    #
    #   2. Once home-manage is installed.
    #     $ home-manager switch --flake '.#diego'
    #     to apply.
    #
    # See: [Home Manager Manual / 3 Nix Flakes / 3.2 Standalone setup](https://nix-community.github.io/home-manager/index.html#sec-flakes-standalone)
    homeConfigurations.diego = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home/diego.nix  ];
    };

    nixosConfigurations = {
      nixos-vm = lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos-vm/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.diego = import ./home/diego.nix;
          }
        ];
      };
    };
  };
}
