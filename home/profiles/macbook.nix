{
  pkgs,
  username,
  ...
}: {
  imports = [
    ../../modules/shell
    ../../modules/programs/editors/nvf
  ];

  home.username = username;
  home.homeDirectory = "/Users/${username}";

  home.stateVersion = "25.11";
}
