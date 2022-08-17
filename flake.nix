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
        overlays = [ ];
      };
      lib = nixpkgs.lib;
    in
    {
      # Stand-alone home-manager flake
      #
      # Usage:
      #   1. Install Home Manager and apply the configuration by
      #     $ nix build --no-link .#homeConfiguration.standalone.activationPacakge
      #     $ "$(nix path-info .#homeConfiguration.standalone.activationPackage"/activate
      #
      #   2. Once home-manage is installed.
      #     $ home-manager switch --flake '.#standalone'
      #     to apply.
      #
      #   See [^1] for more infomation.
      #
      # Note:
      #   - You need to have `~/.config/nix/nix.conf` as follows
      #     `exprimental-features = nix-command flakes`
      #
      #   See [^2] for quick reference, [^3] for complete manual.
      #
      # See:
      #   1. [Home Manager Manual - 3 Nix Flakes - 3.2 Standalone setup](https://nix-community.github.io/home-manager/index.html#sec-flakes-standalone)
      #   2. [NixOS Wiki - Nix command](https://nixos.wiki/wiki/Nix_command)
      #   3. [Nix manual - 7. Command Reference - 7.6 Files - 7.6.1 nix.conf](https://nixos.org/manual/nix/stable/command-ref/conf-file.html)
      homeConfigurations.standalone = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/standalone.nix
          ./home/desktop.nix
          ./modules/development/git.nix
          ./modules/development/bash.nix
          ./modules/development/fish
        ];
      };

      # NixOS flake
      #
      # Usage:
      #   Use command follows
      #   $ sudo nixos-rebuild switch --flake .#host-name
      #   host-name can be omitted if your host's name and host-name are same.
      nixosConfigurations = {
        nixos-vm = lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos-vm/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.diego = import ./home/diego.nix;
            }
          ];
        };
      };
    };
}
