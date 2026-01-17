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
    ./filemanager
  ];

  home.packages = with pkgs; [
    grim
    grimblast
    slurp
    libnotify

    chafa

    # yazi
    ffmpegthumbnailer
    poppler
    imagemagick
    ueberzugpp
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard";
      package = pkgs.catppuccin-gtk;
    };
  };
}
