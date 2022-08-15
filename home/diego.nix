{ config, pkgs, ... }:

{
  # programs.home-manager.enable = true;
  home.username = "diego";
  home.homeDirectory = "/home/diego";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manger release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  imports = [
    ../modules/development/git.nix
  ];
}
