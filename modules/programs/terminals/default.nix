{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./ghostty
    ./kitty
  ];
}
