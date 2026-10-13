{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  unstable = import inputs.nixpkgs-unstable {system = pkgs.stdenv.hostPlatform.system;};
in {
  home.packages = lib.optionals pkgs.stdenv.isLinux [pkgs.bubblewrap];

  programs.codex = {
    enable = true;
    package = unstable.codex;
  };
}
