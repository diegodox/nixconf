{
  config,
  pkgs,
  ...
}: {
  # Enable the X11 windowing system.
  environment.pathsToLink = [ "/libexec" ];
  services.picom.enable = true;
  services.xserver = {
    enable = true;
    desktopManager = {
      runXdgAutostartIfNone = true; # handle XDG autostart (eg. input method)
    };
    displayManager = {
      defaultSession = "none+i3";
      # startx.enable = true;
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        picom
        i3status
        rofi
      ];
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      # fcitx5-qt
    ];
  };
}
