{
  pkgs,
  username,
  ...
}: {
  imports = [
    ../../modules/programs
    ../../modules/shell
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "26.05";
}
