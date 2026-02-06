{
  config,
  pkgs,
  lib,
  unstable,
  ...
}: {
  programs.gemini-cli = {
    enable = true;
    package = unstable.gemini-cli;
  };
}
