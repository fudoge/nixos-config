{
  config,
  pkgs,
  lib,
  username,
  ...
}: {
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = true;
      splash = false;

      preload = ["/home/${username}/Pictures/wallpapers/nix-black-4k.png"];
      wallpaper = [
        "eDP-1, /home/${username}/Pictures/wallpapers/nix-black-4k.png"
      ];
    };
  };
}
