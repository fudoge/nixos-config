{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hyprland
    ./hypridle
    ./hyprpaper
    ./hyprqt6engine
    ./hyprcursor
  ];
}
