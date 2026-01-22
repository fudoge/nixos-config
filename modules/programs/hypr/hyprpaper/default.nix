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
    };
  };
}
