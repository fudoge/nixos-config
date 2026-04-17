{
  pkgs,
  username,
  ...
}: {
  imports = [
    ../../modules/shell
    ../../modules/programs/editors/nvf
    ../../modules/programs/git
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.11";
}
