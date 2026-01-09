{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.gh-dash = {
    enable = true;
  };
}
