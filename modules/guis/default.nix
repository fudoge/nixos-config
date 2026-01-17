{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./app
    ./catppuccin
    ./editors
    ./hypr
    ./terminals
    ./wayland
  ];

  home.packages = with pkgs; [
    grimblast
    slurp
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard";
      package = pkgs.catppuccin-gtk;
    };
  };
}
