{
  config,
  pkgs,
  lib,
  ...
}: let
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  caelestia = "${config.programs.caelestia.cli.package}/bin/caelestia";
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  dpmsOn = "${hyprctl} dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
  dpmsOff = "${hyprctl} dispatch 'hl.dsp.dpms({ action = \"disable\" })'";
  restartFcitx = "${pkgs.systemd}/bin/systemctl --user restart fcitx5.service";
  caelestiaLock = pkgs.writeShellScriptBin "caelestia-lock" ''
    set -euo pipefail

    runtime_dir="''${XDG_RUNTIME_DIR:-/tmp}"
    guard="$runtime_dir/caelestia-lock.guard"
    stamp="$runtime_dir/caelestia-lock.stamp"
    now="$(${pkgs.coreutils}/bin/date +%s)"

    exec 9>"$guard"
    ${pkgs.util-linux}/bin/flock -n 9 || exit 0

    if [ -r "$stamp" ]; then
      last="$(${pkgs.coreutils}/bin/cat "$stamp" 2>/dev/null || ${pkgs.coreutils}/bin/echo 0)"
      if [ "$((now - last))" -lt 5 ]; then
        exit 0
      fi
    fi

    ${pkgs.coreutils}/bin/printf '%s\n' "$now" > "$stamp"
    exec ${caelestia} shell lock lock
  '';
  lockCmd = "${caelestiaLock}/bin/caelestia-lock";
in {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = lockCmd;
        before_sleep_cmd = "${hyprctl} eval 'hl.config({ misc = { allow_session_lock_restore = true } })'; ${lockCmd}";
        after_sleep_cmd = "${dpmsOn}; ${brightnessctl} -r; ${restartFcitx}";
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
          on-timeout = lockCmd;
        }
        {
          timeout = 330;
          on-timeout = dpmsOff;
          on-resume = "${dpmsOn} && ${brightnessctl} -r";
        }
        {
          timeout = 1800;
          on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
  };
}
