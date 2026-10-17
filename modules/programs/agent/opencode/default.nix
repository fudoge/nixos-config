{
  config,
  pkgs,
  lib,
  inputs,
  unstable,
  ...
}: {
  programs.opencode = {
    enable = true;
    package =
      if pkgs.stdenv.hostPlatform.isDarwin
      then unstable.opencode
      else pkgs.opencode;
  };
}
