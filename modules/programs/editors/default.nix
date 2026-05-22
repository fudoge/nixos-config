{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./nvf
    ./vscode
    ./zed
  ];
}
