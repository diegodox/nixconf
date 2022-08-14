{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    kitty
    fzf
    file
    exa
    bat
    lazygit
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];
}
