{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./gh-cli
    ./gh-dash
  ];

  # git configuration
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Chaewoon Kang";
        email = "kchawoon@naver.com";
      };
      init.defaultBranch = "main";
      credential."https://gitlab.com".helper = "!${lib.getExe pkgs.glab} auth git-credential";
    };
  };

  home.packages = [pkgs.glab];
}
