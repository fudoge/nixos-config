{
  config,
  pkgs,
  lib,
  ...
}:
{

  # gh-cli configuration
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}
