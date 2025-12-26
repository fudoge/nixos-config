{
  config,
  pkgs,
  lib,
  ...
}:
{

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ", preferred,auto,1";
      "$terminal" = "ghostty";
      "$mainMod" = "ALT";
      bind = [
        "$mainMod, Return, exec, $terminal"
      ];
    };
  };
}
