{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./spaceship
    ./zsh
  ];

  home.packages = with pkgs; [
    eza
    zoxide
  ];
}
