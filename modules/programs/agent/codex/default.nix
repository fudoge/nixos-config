{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  unstable = import inputs.nixpkgs-unstable {system = pkgs.stdenv.hostPlatform.system;};
in {
  programs.codex = {
    enable = true;
    package = unstable.codex;
  };
}
