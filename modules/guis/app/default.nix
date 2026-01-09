{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./spotify-player
    ./vesktop
    ./sioyek
  ];
}
