{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hyprland
    ./hyprlock
    ./hypridle
    ./hyprpaper
    ./hyprqt6engine
  ];
}
