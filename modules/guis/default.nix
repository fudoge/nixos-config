{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./editors
    ./hyprland
    ./terminals
  ];
}
