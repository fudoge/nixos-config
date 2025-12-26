{
  config,
  pkgs,
  lib,
}:
{

  import = [
    ./gh-cli
  ];

  # git configuration
  programs.git = {
    enable = true;
    userName = "Chaewoon Kang";
    userEmail = "kchawoon@naver.com";
    extraConfig.init.defaultBranch = "main";
  };

}
