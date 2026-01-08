{
  pkgs,
  username,
  withGui,
  withHyprland,
  ...
}:
{
  imports = [
    ../../modules/cli
    ../../modules/guis
    ../../modules/shell
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.11";
}
