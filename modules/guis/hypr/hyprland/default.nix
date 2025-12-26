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
      monitor = ", preferred,auto,1.25";
      "$terminal" = "ghostty";
      "$mainMod" = "ALT";
      exec-once = [
        "hyprpanel"
      ];
      bind = [
        "$mainMod, Return, exec, $terminal"
      ];
    };
  };
}
