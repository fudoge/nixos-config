{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./wlogout
    ./rofi
    ./vicinae
  ];
}
