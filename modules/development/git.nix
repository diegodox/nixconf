{ config, pkgs, ... }:

{
  config.programs.git = {
    enable = true;
    userName = "diegodox";
    userEmail = "android.mxdiego9@gmail.com";
    delta.enable = true;
    extraConfig.init.defaultBranch = "main";
  };
  config.programs.gh.enable = true;
  config.home.packages = [ pkgs.lazygit ];
}
