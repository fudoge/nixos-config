{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.localsend = {
    enable = true;
  };
}
