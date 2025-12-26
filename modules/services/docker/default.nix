{
  config,
  lib,
  pkgs,
  enable ? true,
  ...
}:

lib.mkIf enable {
  virtualisation.docker.enable = true;
}
