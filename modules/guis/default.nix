{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./app
    ./catppuccin
    ./editors
    ./hypr
    ./terminals
    ./wayland
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard";
      package = pkgs.catppuccin-gtk;
    };
  };
}
