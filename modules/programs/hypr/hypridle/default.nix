{
  config,
  pkgs,
  lib,
  ...
}: let
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  caelestia = "${config.programs.caelestia.cli.package}/bin/caelestia";
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  systemctl = "${pkgs.systemd}/bin/systemctl";
in {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${caelestia} shell lock lock";
        before_sleep_cmd = "${caelestia} shell lock lock";
        after_sleep_cmd = "${hyprctl} dispatch dpms on; ${hyprctl} keyword misc:allow_session_lock_restore 1; ${systemctl} --user restart caelestia.service; ${caelestia} shell lock lock; ${brightnessctl} -r";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "${brightnessctl} -s set 10";
          on-resume = "${brightnessctl} -r";
        }
        {
          timeout = 150;
          on-timeout = "${brightnessctl} -sd rgb:kbd_backlight set 0";
          on-resume = "${brightnessctl} -rd rgb:kbd_backlight";
        }
        {
          timeout = 300;
          on-timeout = "${caelestia} shell lock lock";
        }
        {
          timeout = 330;
          on-timeout = "${hyprctl} dispatch dpms off";
          on-resume = "${hyprctl} dispatch dpms on && ${brightnessctl} -r";
        }
        {
          timeout = 1800;
          on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
  };
}
