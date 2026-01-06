{
  config,
  pkgs,
  lib,
  ...
}:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    nerd-fonts.jetbrains-mono
    nanum
    nanum-gothic-coding
  ];
}
