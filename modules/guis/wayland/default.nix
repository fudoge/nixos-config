{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./wlogout
    ./rofi
  ];
}
