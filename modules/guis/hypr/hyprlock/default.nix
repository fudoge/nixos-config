{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        ignore_empty_input = true;
      };

      background = [
        {
          monitor = "";
          path = "screenshot";

          blur_passes = 3;
          blur_size = 7;
          noise = 0.0117;
          contrast = 0.8196;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_drakness = 0.0;
        }
      ];
    };
  };
}
