{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  unstable = import inputs.nixpkgs-unstable {system = pkgs.stdenv.hostPlatform.system;};
in {
  # vscode
  programs.kiro = {
    enable = true;
    package = unstable.kiro;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      catppuccin.catppuccin-vsc
      mvllow.rose-pine
      jdinhlife.gruvbox

      mhutchie.git-graph
      vscodevim.vim
      yzhang.markdown-all-in-one

      tamasfe.even-better-toml
      redhat.vscode-yaml

      golang.go
      hashicorp.hcl
      hashicorp.terraform
      docker.docker
      redhat.ansible
      ms-python.python
      ms-pyright.pyright
      kamadorueda.alejandra
      batisteo.vscode-django
      esbenp.prettier-vscode
      jnoortheen.nix-ide
      bbenoist.nix
    ];
  };
}
