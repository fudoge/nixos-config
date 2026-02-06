{
  config,
  pkgs,
  lib,
  unstable,
  ...
}: {
  programs.claude-code = {
    enable = true;
    package = unstable.claude-code;
  };
}
