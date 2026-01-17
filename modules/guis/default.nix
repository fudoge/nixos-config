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
    grim
    grimblast
    slurp
    libnotify
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard";
      package = pkgs.catppuccin-gtk;
    };
  };
}
