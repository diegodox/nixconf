# Determine user and home direcotry on runtime.
{ config, pkgs, ... }:

{
  home.username = "$USER";
  home.homeDirectory = "/." + builtins.getEnv "HOME";
}
