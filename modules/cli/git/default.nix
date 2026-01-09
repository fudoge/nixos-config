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
    };
  };
}
