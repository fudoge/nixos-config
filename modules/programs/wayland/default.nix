{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./wlogout
    ./vicinae
    ./caelestia
  ];
}
