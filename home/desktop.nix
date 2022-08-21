{
  config,
  pkgs,
  ...
}: {
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This avoid breaking
  # with a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    vim
  ];

  imports = [
    ../modules/development/git.nix
    ../modules/development/bash.nix
    ../modules/development/fish
  ];
}
