{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./cava
    ./spicetify
  ];
}
