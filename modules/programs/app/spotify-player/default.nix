{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.spotify-player = {
    enable = true;
  };
}
