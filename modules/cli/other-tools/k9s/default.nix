{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.k9s = {
    enable = true;
  };
}
