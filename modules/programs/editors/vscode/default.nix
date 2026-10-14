{
  config,
  pkgs,
  lib,
  ...
}: {
  # vscode
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      mvllow.rose-pine

      mhutchie.git-graph
      vscodevim.vim
      yzhang.markdown-all-in-one

      tamasfe.even-better-toml
      redhat.vscode-yaml

      golang.go
      hashicorp.hcl
      hashicorp.terraform
      docker.docker
      (pkgs.vscode-utils.extensionFromVscodeMarketplace {
        publisher = "AmazonWebServices";
        name = "aws-toolkit-vscode";
        version = "4.17.0";
        sha256 = "02rb6z0la7lqlnbywbalbyyfbzljhpy0cn32q77h2774lxi45zpv";
      })
      redhat.ansible
      ms-python.python
      ms-pyright.pyright
      kamadorueda.alejandra
      batisteo.vscode-django
      esbenp.prettier-vscode
      jnoortheen.nix-ide
      bbenoist.nix
    ];
    profiles.default.userSettings = {
      "workbench.colorTheme" = "Rosé Pine";
      "terminal.integrated.enableMultiLinePasteWarning" = "never";
    };
  };
}
