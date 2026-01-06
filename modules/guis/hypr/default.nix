{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hyprland
    ./hyprpanel
    ./hyprlock
  ];
}
