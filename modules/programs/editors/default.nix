{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./vscode
    ./zed
  ];
}
