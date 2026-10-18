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
        email = "77766067+fudoge@users.noreply.github.com";
      };
      core.editor = "vim";
      init.defaultBranch = "main";
      credential."https://gitlab.com".helper = "!${lib.getExe pkgs.glab} auth git-credential";
      credential."https://gitlab-apclab.synology.me".helper = "!${lib.getExe pkgs.glab} auth git-credential";
    };
  };

  home.packages = with pkgs; [
    glab
    forgejo-cli
  ];
}
