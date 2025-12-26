{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./editors
    ./hypr
    ./terminals
  ];
}
