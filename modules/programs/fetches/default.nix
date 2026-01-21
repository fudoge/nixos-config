{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./fastfetch
  ];

  home.packages = with pkgs; [
    nitch
    pfetch
    onefetch
  ];
}
