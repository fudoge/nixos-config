{
  config,
  pkgs,
  lib,
  withGui ? false,
  ...
}:
let
  logoImage = ../../../../assets/nix-logo.png;
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
            width = 30;
            height = 15;
            padding = {
              top = 1;
              left = 2;
            };
          }
        else
          {
            type = "small";
          };
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "wm"
        "wmtheme"
        "font"
        "cursor"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "localip"
        "battery"
        "locale"
      ];
    };
  };
}
