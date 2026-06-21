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
  home.homeDirectory = "/Users/${username}";

  home.stateVersion = "26.05";
}
