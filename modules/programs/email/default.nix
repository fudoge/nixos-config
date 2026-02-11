{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.aerc = {
    enable = true;
  };
}
