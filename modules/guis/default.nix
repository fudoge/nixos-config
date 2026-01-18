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
    ./kde
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

    rclone
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard";
      package = pkgs.catppuccin-gtk;
    };
  };
}
