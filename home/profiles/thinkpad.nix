{
  pkgs,
  withGui,
  withHyprland,
  ...
}:
{
  imports = [
    ../../modules/cli
    ../../modules/guis
    ../../modules/services
    ../../modules/shell
  ];

  home.username = "chaewoon";
  home.homeDirectory = "/home/chaewoon";

  home.stateVersion = "25.05";
}
