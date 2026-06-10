{
  config,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    settings = {};

    extraConfig =
      builtins.replaceStrings
      ["@brightnessctl@"]
      ["${lib.getExe pkgs.brightnessctl}"]
      (builtins.readFile ./hyprland.lua);
  };
}
