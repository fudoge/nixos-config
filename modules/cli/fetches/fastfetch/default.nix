{
  config,
  pkgs,
  lib,
  withGui ? false,
  ...
}:
let
  logoImage = ../../../assets/logo.png;
in
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo =
        if withGui then
          {
            type = "kitty";
            source = "${logoImage}";
          }
        else
          {
            type = "small";
          };
      modules = [
        "title"
        "seperator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "wm"
        "wm theme"
        "font"
        "cursor"
        "terminal"
        "terminal font"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "local ip"
        "battery"
        "locale"
      ];
    };
  };
}
