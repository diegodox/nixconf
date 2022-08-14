{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  # outputs = { nixpkgs, home-manager, ... }:
  outputs = { nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
      overlays = [];
    };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      nixos-vm = lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos-vm/configuration.nix
        ];
      };
    };
  };
}
