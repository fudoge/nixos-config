{
  config,
  pkgs,
  lib,
  ...
}:
{

  imports = [
    ./gh-cli
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
