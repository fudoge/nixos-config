{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./spaceship
    ./zsh
  ];
}
