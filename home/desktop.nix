{ config, pkgs, ... }: 

{
  programs.home-manager.enable = true;
  home.stateVersion = "22.05";
  home.packages = [
    pkgs.vim
    pkgs.lazygit
  ];

  imports = [
    ../modules/development/git.nix
    ../modules/development/bash.nix
  ];
}
