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

      input-field = [
        {
          monitor = "";
          size = "20%, 5%";
          outline_thickness = 3;

          inner_color = "rgba(0,0,0,0.0)";
          dots_size = 0.33;
          dots_spacing = 0.15;
          dots_center = true;
          dots_rounding = -1;
          hide_input = false;

          fade_on_empty = false;
          rounding = 15;

          position = "0, -60";
          halign = "center";
          valign = "center";

          placeholder_text = "<i>Input Password to Unlock...</i>";
        }
      ];

      labels = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 80;
          font_family = "JetBrainoMono Nerd Font";
          position = "0, 160";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:60000] date '+%A, %B %d'";
          font_size = 18;
          font_family = "JetBrainoMono Nerd Font";
          position = "0, 40";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
