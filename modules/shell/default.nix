{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./starship
    ./zsh
  ];

  home.packages = with pkgs; [
    eza
    zoxide
    bat
  ];
}
