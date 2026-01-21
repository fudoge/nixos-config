{
  pkgs,
  username,
  withGui,
  withHyprland,
  ...
}: {
  imports = [
    ../../modules/programs
    ../../modules/shell
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.11";
}
