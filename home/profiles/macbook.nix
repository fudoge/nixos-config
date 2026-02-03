{
  pkgs,
  username,
  ...
}: {
  imports = [
    ../../modules/shell
  ];

  home.username = username;
  home.homeDirectory = "/Users/${username}";

  home.stateVersion = "25.11";
}
