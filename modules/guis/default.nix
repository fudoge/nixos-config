{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./catppuccin
    ./editors
    ./hypr
    ./terminals
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard";
      package = pkgs.catppuccin-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
