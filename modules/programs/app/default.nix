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
    ./anki
    ./notion
    ./synology-chat
  ];
}
