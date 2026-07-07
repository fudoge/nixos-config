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

  xdg.configFile = {
    "hypr/custom/rules.lua".source = ./rules.lua;
  };

  home.file = {
    ".local/bin/hypr-monitor-autoset.sh" = {
      source = ../../../../scripts/hypr-monitor-autoset.sh;
      executable = true;
      force = true;
    };
    ".local/bin/hypr-monitor-listen.sh" = {
      source = ../../../../scripts/hypr-monitor-listen.sh;
      executable = true;
      force = true;
    };
  };
}
