{ config, pkgs, ... }:

{
  config.programs.git = {
    enable = true;
    userName = "diegodox";
    userEmail = "android.mxdiego9@gmail.com";
    delta.enable = true;
    extraConfig.init.defaultBranch = "main";
  };
}
