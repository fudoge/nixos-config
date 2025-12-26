{
  pkgs,
  withGui,
  withHyprland,
}:
{
  imports = [
    ../modules/cli
    ../modules/services
    ../modules/guis
  ];

  home.username = "chaewoon";
  home.homeDirectory = "/home/chaewoon";

  home.stateVersion = "25.05";
}
