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

    extraConfig = builtins.readFile ./hyprland.lua;
  };
}
