{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./wlogout
    ./caelestia
  ];
}
