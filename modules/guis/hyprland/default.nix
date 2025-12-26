{
  config,
  pkgs,
  lib,
}:
{

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$terminal" = "ghostty";
      "$mainMod" = "ALT";
      bind = [
        "$mainMod, Return, exec, $terminal"
      ];
    };
  };
}
